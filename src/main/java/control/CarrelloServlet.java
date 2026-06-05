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
import model.ProdottoBean;
import model.ProdottoDAO;

@WebServlet("/carrello")
public class CarrelloServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Recuperiamo la Sessione dell'utente (il suo "zaino" virtuale)
        HttpSession session = request.getSession();
        
        // 2. Cerchiamo il carrello nello zaino
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        // 3. Se non ha un carrello (è appena entrato), gliene diamo uno nuovo e lo mettiamo in sessione
        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        String action = request.getParameter("action");

        if (action != null) {
            // Se ha cliccato "Aggiungi al carrello"
            if (action.equals("aggiungi")) {
                int id = Integer.parseInt(request.getParameter("id"));
                ProdottoDAO dao = new ProdottoDAO();
                
                try {
                    ProdottoBean prodotto = dao.doRetrieveByKey(id);
                    if (prodotto != null) {
                        carrello.aggiungiProdotto(prodotto); // Mettiamo la scarpa nel carrello
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                
                // Ricarica la pagina del catalogo dopo aver aggiunto
                response.sendRedirect("catalogo?categoria=Tutte");
                return;
            }
        }

        // Se vuole solo "Vedere" il carrello, lo mandiamo alla pagina carrello.jsp (che creeremo dopo)
        request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}