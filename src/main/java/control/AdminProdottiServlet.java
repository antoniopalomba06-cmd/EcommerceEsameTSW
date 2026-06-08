package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProdottoBean;
import model.ProdottoDAO;
import model.UtenteBean;

@WebServlet("/admin/prodotti")
public class AdminProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProdottoDAO prodottoDAO = new ProdottoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Controllo Sicurezza: Solo l'admin può passare
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");
        if (utente == null || !"admin".equals(utente.getRuolo())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // 2. Gestione dei comandi (es. elimina)
        String action = request.getParameter("action");
        try {
            if (action != null && action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                prodottoDAO.doDelete(id);
                response.sendRedirect(request.getContextPath() + "/admin/prodotti");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 3. Caricamento prodotti per la tabella
        try {
            List<ProdottoBean> catalogo = prodottoDAO.doRetrieveAll();
            request.setAttribute("prodotti", catalogo);
            request.getRequestDispatcher("/WEB-INF/view/admin-prodotti.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gestione inserimento nuovo prodotto dal form
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        String categoria = request.getParameter("categoria");

        ProdottoBean nuovoProdotto = new ProdottoBean();
        nuovoProdotto.setNome(nome);
        nuovoProdotto.setDescrizione(descrizione);
        nuovoProdotto.setPrezzo(prezzo);
        nuovoProdotto.setQuantita(quantita);
        nuovoProdotto.setCategoria(categoria);

        try {
            prodottoDAO.doSave(nuovoProdotto);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/prodotti");
    }
}