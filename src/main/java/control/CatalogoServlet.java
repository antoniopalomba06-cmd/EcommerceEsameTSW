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
import model.ProdottoBean;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        
        /* 1. Leggiamo la categoria scelta dall'utente cliccando sulla navbar */
        String categoria = request.getParameter("categoria");
        
        try {
            List<ProdottoBean> prodotti;
            
            /* 2. Logica di filtraggio: se c'è una categoria specifica (e non è "Tutte"), filtriamo */
            if (categoria != null && !categoria.trim().isEmpty() && !categoria.equalsIgnoreCase("Tutte")) {
                prodotti = prodottoDAO.doRetrieveByCategory(categoria);
            } else {
                /* Altrimenti carichiamo il catalogo completo */
                prodotti = prodottoDAO.doRetrieveAll();
            }
            
            /* 3. Passiamo la lista dei prodotti e la categoria attiva alla View */
            request.setAttribute("listaProdotti", prodotti);
            
            request.getRequestDispatcher("/WEB-INF/view/catalogo.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("Errore nel recupero del catalogo: " + e.getMessage());
            response.sendError(500, "Errore interno del server database");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}