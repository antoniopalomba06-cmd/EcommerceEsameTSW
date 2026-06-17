package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.OrdineDAO;
import model.OrdineBean;
import model.UtenteBean;

@WebServlet("/adminOrdini")
public class AdminOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UtenteBean utente = (UtenteBean) session.getAttribute("utente");

        if (utente == null || !"admin".equals(utente.getRuolo())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        OrdineDAO dao = new OrdineDAO();
        List<OrdineBean> tuttiGliOrdini = dao.doRetrieveAll();

        request.setAttribute("ordini", tuttiGliOrdini);
        request.getRequestDispatcher("/WEB-INF/view/admin-ordini.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}