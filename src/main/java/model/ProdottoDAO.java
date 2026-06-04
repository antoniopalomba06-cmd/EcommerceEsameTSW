package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProdottoDAO {

    private static DataSource ds;

    // Inizializzazione del DataSource dal file context.xml
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/EcommerceDB");
        } catch (NamingException e) {
            System.out.println("Errore di configurazione DataSource: " + e.getMessage());
        }
    }

    // Metodo per recuperare TUTTO il catalogo prodotti dal database
    public synchronized List<ProdottoBean> doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        
        // Creiamo una lista vuota che conterrà i nostri prodotti
        List<ProdottoBean> prodotti = new ArrayList<>();

        String selectSQL = "SELECT * FROM Prodotto";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            
            // Eseguiamo la query e salviamo la tabella risultante nel ResultSet
            rs = preparedStatement.executeQuery();

            // Cicliamo riga per riga i risultati del database
            while (rs.next()) {
                ProdottoBean bean = new ProdottoBean();
                bean.setId(rs.getInt("id"));
                bean.setNome(rs.getString("nome"));
                bean.setDescrizione(rs.getString("descrizione"));
                bean.setPrezzo(rs.getDouble("prezzo"));
                bean.setQuantita(rs.getInt("quantita"));
                
                // Aggiungiamo il prodotto "confezionato" alla nostra lista
                prodotti.add(bean);
            }
        } finally {
            // Chiusura a cascata obbligatoria per liberare le risorse e restituire la connessione al pool
            try {
                if (rs != null) rs.close();
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                } finally {
                    if (connection != null) connection.close();
                }
            }
        }
        return prodotti;
    }
}