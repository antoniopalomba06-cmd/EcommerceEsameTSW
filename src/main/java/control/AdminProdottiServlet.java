package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProdottoBean;
import model.UtenteBean;

@WebServlet("/admin/prodotti")
public class AdminProdottiServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProdottoDAO prodottoDAO = new ProdottoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String action = request.getParameter("action");
        try {
            if (action != null) {
                if (action.equals("delete")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    prodottoDAO.doDelete(id);
                    response.sendRedirect(request.getContextPath() + "/admin/prodotti");
                    return;
                } else if (action.equals("edit")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProdottoBean prodotto = prodottoDAO.doRetrieveByKey(id);
                    request.setAttribute("prodotto", prodotto);
                    request.getRequestDispatcher("/WEB-INF/view/admin-modifica.jsp").forward(request, response);
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

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
        String idStr = request.getParameter("id");
        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));
        String categoria = request.getParameter("categoria");

        ProdottoBean prodotto = new ProdottoBean();
        prodotto.setNome(nome);
        prodotto.setDescrizione(descrizione);
        prodotto.setPrezzo(prezzo);
        prodotto.setQuantita(quantita);
        prodotto.setCategoria(categoria);

        try {
            if (idStr != null && !idStr.isEmpty()) {
                prodotto.setId(Integer.parseInt(idStr));
                prodottoDAO.doUpdate(prodotto);
            } else {
                prodottoDAO.doSave(prodotto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/prodotti");
    }
}