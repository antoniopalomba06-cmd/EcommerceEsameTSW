package control;

import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.OrdineDAO;
import model.Carrello;
import model.CarrelloItem;
import model.DettaglioOrdineBean;
import model.OrdineBean;
import model.UtenteBean;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utente == null) {
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        if (carrello == null || carrello.getItems().isEmpty()) {
            request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
            return;
        }

        OrdineBean ordine = new OrdineBean();
        ordine.setIdUtente(utente.getId());
        ordine.setDataOrdine(new Date(System.currentTimeMillis()));
        
        double totale = 0;

        for (CarrelloItem item : carrello.getItems()) {
            DettaglioOrdineBean det = new DettaglioOrdineBean();
            det.setIdProdotto(item.getProdotto().getId());
            det.setQuantita(item.getQuantita());
            det.setPrezzoAcquisto(item.getProdotto().getPrezzo());
            
            totale += (item.getProdotto().getPrezzo() * item.getQuantita());
            ordine.addDettaglio(det);
        }

        ordine.setTotale(totale);

        OrdineDAO ordineDAO = new OrdineDAO();
        ordineDAO.doSave(ordine);

        session.removeAttribute("carrello");

        request.getRequestDispatcher("/WEB-INF/view/checkoutSuccess.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}