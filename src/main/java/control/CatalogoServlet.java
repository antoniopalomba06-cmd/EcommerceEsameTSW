package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ProdottoBean;
import model.ProdottoDAO;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        
        try {
            // 1. Chiediamo al Model (DAO) la lista completa dei prodotti
            List<ProdottoBean> prodotti = prodottoDAO.doRetrieveAll();
            
           
            request.setAttribute("listaProdotti", prodotti);
            
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/catalogo.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException e) {
            System.out.println("Errore nel recupero del catalogo: " + e.getMessage());
            response.sendError(500, "Errore interno del server database");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}