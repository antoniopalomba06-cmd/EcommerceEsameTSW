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
    public List<ProdottoBean> doRetrieveAll() throws SQLException {
        List<ProdottoBean> prodotti = new ArrayList<>();
        String query = "SELECT * FROM Prodotto";
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ProdottoBean bean = new ProdottoBean();
                bean.setId(rs.getInt("id"));
                bean.setNome(rs.getString("nome"));
                bean.setDescrizione(rs.getString("descrizione"));
                bean.setPrezzo(rs.getDouble("prezzo"));
                bean.setQuantita(rs.getInt("quantita"));
                
                /* Lettura della nuova colonna categoria */
                bean.setCategoria(rs.getString("categoria"));
                
                prodotti.add(bean);
            }
        }
        return prodotti;
    }

    /* Nuovo metodo per recuperare i prodotti filtrati per categoria */
    public List<ProdottoBean> doRetrieveByCategory(String categoria) throws SQLException {
        List<ProdottoBean> prodotti = new ArrayList<>();
        String query = "SELECT * FROM Prodotto WHERE categoria = ?";
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, categoria);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProdottoBean bean = new ProdottoBean();
                    bean.setId(rs.getInt("id"));
                    bean.setNome(rs.getString("nome"));
                    bean.setDescrizione(rs.getString("descrizione"));
                    bean.setPrezzo(rs.getDouble("prezzo"));
                    bean.setQuantita(rs.getInt("quantita"));
                    bean.setCategoria(rs.getString("categoria"));
                    
                    prodotti.add(bean);
                }
            }
        }
        return prodotti;
    }
    /* Metodo per recuperare un SINGOLO prodotto tramite il suo ID (fondamentale per il carrello) */
    public ProdottoBean doRetrieveByKey(int id) throws SQLException {
        ProdottoBean bean = null;
        String query = "SELECT * FROM Prodotto WHERE id = ?";
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bean = new ProdottoBean();
                    bean.setId(rs.getInt("id"));
                    bean.setNome(rs.getString("nome"));
                    bean.setDescrizione(rs.getString("descrizione"));
                    bean.setPrezzo(rs.getDouble("prezzo"));
                    bean.setQuantita(rs.getInt("quantita"));
                    bean.setCategoria(rs.getString("categoria"));
                }
            }
        }
        return bean;
    }
}