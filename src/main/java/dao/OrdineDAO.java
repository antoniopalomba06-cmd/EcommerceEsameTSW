package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import model.OrdineBean;
import model.DettaglioOrdineBean;

public class OrdineDAO {

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

    public int doSave(OrdineBean ordine) {
        int idOrdine = -1;
        try (Connection con = ds.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Ordine (id_utente, data_ordine, totale) VALUES (?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );
            ps.setInt(1, ordine.getIdUtente());
            ps.setDate(2, ordine.getDataOrdine());
            ps.setDouble(3, ordine.getTotale());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idOrdine = rs.getInt(1);
                ordine.setId(idOrdine);
            }

            PreparedStatement psDettaglio = con.prepareStatement(
                "INSERT INTO DettaglioOrdine (id_ordine, id_prodotto, quantita, prezzo_acquisto) VALUES (?, ?, ?, ?)"
            );
            for (DettaglioOrdineBean det : ordine.getDettagli()) {
                psDettaglio.setInt(1, idOrdine);
                psDettaglio.setInt(2, det.getIdProdotto());
                psDettaglio.setInt(3, det.getQuantita());
                psDettaglio.setDouble(4, det.getPrezzoAcquisto());
                psDettaglio.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return idOrdine;
    }

    public List<OrdineBean> doRetrieveByUtente(int idUtente) {
        List<OrdineBean> ordini = new ArrayList<>();
        try (Connection con = ds.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM Ordine WHERE id_utente = ? ORDER BY data_ordine DESC")) {
            
            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineBean ordine = new OrdineBean();
                    ordine.setId(rs.getInt("id"));
                    ordine.setIdUtente(rs.getInt("id_utente"));
                    ordine.setDataOrdine(rs.getDate("data_ordine"));
                    ordine.setTotale(rs.getDouble("totale"));
                    ordini.add(ordine);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ordini;
    }
}