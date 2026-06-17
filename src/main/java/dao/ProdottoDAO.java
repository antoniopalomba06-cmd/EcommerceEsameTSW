package dao;

import model.ProdottoBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Blob;

public class ProdottoDAO {

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/EcommerceDB");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    private void extractImages(ResultSet rs, ProdottoBean bean) throws SQLException {
        Blob blob = rs.getBlob("immagine");
        if (blob != null && blob.length() > 0) {
            byte[] imageBytes = blob.getBytes(1, (int) blob.length());
            bean.setImmagine(imageBytes);
            bean.setBase64Image(Base64.getEncoder().encodeToString(imageBytes));
        }
        
        Blob blobAlt = rs.getBlob("immagine_alt");
        if (blobAlt != null && blobAlt.length() > 0) {
            byte[] imageBytesAlt = blobAlt.getBytes(1, (int) blobAlt.length());
            bean.setImmagineAlt(imageBytesAlt);
            bean.setBase64ImageAlt(Base64.getEncoder().encodeToString(imageBytesAlt));
        }
    }

    public List<ProdottoBean> doRetrieveAll() throws SQLException {
        List<ProdottoBean> prodotti = new ArrayList<>();
        String query = "SELECT * FROM Prodotto WHERE attivo = true";
        
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
                bean.setCategoria(rs.getString("categoria"));
                extractImages(rs, bean);
                prodotti.add(bean);
            }
        }
        return prodotti;
    }

    public List<ProdottoBean> doRetrieveByCategory(String categoria) throws SQLException {
        List<ProdottoBean> prodotti = new ArrayList<>();
        String query = "SELECT * FROM Prodotto WHERE categoria = ? AND attivo = true";
        
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
                    extractImages(rs, bean);
                    prodotti.add(bean);
                }
            }
        }
        return prodotti;
    }

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
                    extractImages(rs, bean);
                }
            }
        }
        return bean;
    }

    public void doSave(ProdottoBean prodotto) throws SQLException {
        String query = "INSERT INTO Prodotto (nome, descrizione, prezzo, quantita, categoria, immagine, immagine_alt, attivo) VALUES (?, ?, ?, ?, ?, ?, ?, true)";
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setInt(4, prodotto.getQuantita());
            ps.setString(5, prodotto.getCategoria());
            ps.setBytes(6, prodotto.getImmagine());
            ps.setBytes(7, prodotto.getImmagineAlt());
            ps.executeUpdate();
        }
    }

    public void doDelete(int id) throws SQLException {
        String query = "UPDATE Prodotto SET attivo = false WHERE id = ?";
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void doUpdate(ProdottoBean prodotto) throws SQLException {
        boolean hasImage = prodotto.getImmagine() != null && prodotto.getImmagine().length > 0;
        boolean hasImageAlt = prodotto.getImmagineAlt() != null && prodotto.getImmagineAlt().length > 0;
        
        StringBuilder query = new StringBuilder("UPDATE Prodotto SET nome = ?, descrizione = ?, prezzo = ?, quantita = ?, categoria = ?");
        if (hasImage) query.append(", immagine = ?");
        if (hasImageAlt) query.append(", immagine_alt = ?");
        query.append(" WHERE id = ?");
        
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement(query.toString())) {
            
            int index = 1;
            ps.setString(index++, prodotto.getNome());
            ps.setString(index++, prodotto.getDescrizione());
            ps.setDouble(index++, prodotto.getPrezzo());
            ps.setInt(index++, prodotto.getQuantita());
            ps.setString(index++, prodotto.getCategoria());
            
            if (hasImage) ps.setBytes(index++, prodotto.getImmagine());
            if (hasImageAlt) ps.setBytes(index++, prodotto.getImmagineAlt());
            
            ps.setInt(index, prodotto.getId());
            ps.executeUpdate();
        }
    }
}