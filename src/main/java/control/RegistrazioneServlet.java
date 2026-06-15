package control;

import java.io.IOException;
import java.sql.SQLException;

import dao.UtenteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UtenteBean;

@WebServlet("/registrazione")
public class RegistrazioneServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String indirizzo = request.getParameter("indirizzo");

        UtenteBean utente = new UtenteBean();
        utente.setNome(nome);
        utente.setCognome(cognome);
        utente.setEmail(email);
        utente.setPassword(password);
        utente.setRuolo("cliente");
        utente.setIndirizzo(indirizzo);

        UtenteDAO utenteDAO = new UtenteDAO();

        try {
            utenteDAO.doSave(utente);
            request.getRequestDispatcher("/WEB-INF/view/registrazione-successo.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errore", "Errore durante la registrazione. Riprova.");
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
        }
    }
}