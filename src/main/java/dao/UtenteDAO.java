package dao;
import model.UtenteBean;
import model.PasswordUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UtenteDAO {

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/EcommerceDB");
        } catch (NamingException e) {
            System.out.println("Errore di configurazione DataSource: " + e.getMessage());
        }
    }

    public synchronized void doSave(UtenteBean utente) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        String insertSQL = "INSERT INTO Utente (nome, cognome, email, password, ruolo) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            
            preparedStatement.setString(1, utente.getNome());
            preparedStatement.setString(2, utente.getCognome());
            preparedStatement.setString(3, utente.getEmail());
            preparedStatement.setString(4, PasswordUtils.hashPassword(utente.getPassword()));
            preparedStatement.setString(5, utente.getRuolo());

            preparedStatement.executeUpdate();
            
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
            } finally {
                if (connection != null) connection.close();
            }
        }
    }

    public UtenteBean doRetrieveByEmailAndPassword(String email, String password) throws java.sql.SQLException {
        java.sql.Connection connection = null;
        java.sql.PreparedStatement preparedStatement = null;
        java.sql.ResultSet resultSet = null;
        UtenteBean utente = null;

        String selectSQL = "SELECT * FROM Utente WHERE email = ? AND password = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, PasswordUtils.hashPassword(password));

            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                utente = new UtenteBean();
                utente.setId(resultSet.getInt("id"));
                utente.setNome(resultSet.getString("nome"));
                utente.setCognome(resultSet.getString("cognome"));
                utente.setEmail(resultSet.getString("email"));
                utente.setPassword(resultSet.getString("password"));
                utente.setRuolo(resultSet.getString("ruolo"));
            }
        } finally {
            try {
                if (resultSet != null) resultSet.close();
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                } finally {
                    if (connection != null) connection.close();
                }
            }
        }
        return utente;
    }
}