package control;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Carrello;
import model.CarrelloItem;
import model.ProdottoBean;
import model.ProdottoDAO;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Sincronizziamo la sessione come richiesto dalle slide del prof per evitare problemi con AJAX
        synchronized (session) {
            Carrello carrello = (Carrello) session.getAttribute("carrello");

            if (carrello == null) {
                carrello = new Carrello();
                session.setAttribute("carrello", carrello);
            }

            String action = request.getParameter("action");

            if (action != null) {
                if (action.equals("aggiungi")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProdottoDAO dao = new ProdottoDAO();
                    
                    try {
                        ProdottoBean prodotto = dao.doRetrieveByKey(id);
                        if (prodotto != null) {
                            carrello.aggiungiProdotto(prodotto);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    
                    response.sendRedirect("catalogo?categoria=Tutte");
                    return;
                }
                else if (action.equals("diminuisci")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    carrello.diminuisciProdotto(id);
                    response.sendRedirect("carrello");
                    return;
                }
                else if (action.equals("rimuovi")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    carrello.rimuoviProdotto(id);
                    response.sendRedirect("carrello");
                    return;
                }
                else if (action.equals("svuota")) {
                    session.removeAttribute("carrello");
                    response.sendRedirect("carrello");
                    return;
                }
                else if (action.equals("aggiungiAjax")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    ProdottoDAO dao = new ProdottoDAO();
                    int totalePezzi = 0;

                    try {
                        ProdottoBean prodotto = dao.doRetrieveByKey(id);
                        if (prodotto != null) {
                            carrello.aggiungiProdotto(prodotto);
                        }
                        
                        for (CarrelloItem item : carrello.getItems()) {
                            totalePezzi += item.getQuantita();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    response.setContentType("text/plain");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(String.valueOf(totalePezzi));
                    return;
                }
            }

            request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}