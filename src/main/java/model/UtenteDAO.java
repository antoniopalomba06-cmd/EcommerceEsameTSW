package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class UtenteDAO {

    // Questa variabile conterrà il pool di connessioni
    private static DataSource ds;

    // Blocco statico che si avvia subito per pescare il file context.xml
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/EcommerceDB");
        } catch (NamingException e) {
            System.out.println("Errore di configurazione DataSource: " + e.getMessage());
        }
    }

    // Metodo per salvare un nuovo utente nel Database
    public synchronized void doSave(UtenteBean utente) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        // La query SQL con i punti interrogativi per evitare gli attacchi SQL Injection (il prof apprezzerà)
        String insertSQL = "INSERT INTO Utente (nome, cognome, email, password, ruolo) VALUES (?, ?, ?, ?, ?)";

        try {
            // Peschiamo una connessione libera dal pool
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            
            // Riempiamo i punti interrogativi coi dati del Bean
            preparedStatement.setString(1, utente.getNome());
            preparedStatement.setString(2, utente.getCognome());
            preparedStatement.setString(3, utente.getEmail());
            preparedStatement.setString(4, utente.getPassword());
            preparedStatement.setString(5, utente.getRuolo());

            // Eseguiamo il salvataggio
            preparedStatement.executeUpdate();
            
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
            } finally {
                if (connection != null) connection.close(); // Questo non distrugge la connessione, la restituisce al pool
            }
        }
    }
 // Metodo per verificare le credenziali (Login)
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
            preparedStatement.setString(2, password);

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

