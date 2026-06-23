package control;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;
import model.ProdottoBean;

@WebServlet("/prodotto")
public class DettaglioProdottoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr != null && !idStr.matches("^[0-9]+$")) {
            response.sendRedirect(request.getContextPath() + "/catalogo?categoria=Tutte");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            ProdottoDAO dao = new ProdottoDAO();
            ProdottoBean prodotto = dao.doRetrieveByKey(id);

            if (prodotto != null) {
                request.setAttribute("prodotto", prodotto);
                request.getRequestDispatcher("/WEB-INF/view/prodotto.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/catalogo?categoria=Tutte");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/catalogo?categoria=Tutte");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}