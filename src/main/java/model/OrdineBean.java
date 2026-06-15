package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class OrdineBean {
    private int id;
    private int idUtente;
    private Date dataOrdine;
    private double totale;
    private List<DettaglioOrdineBean> dettagli;

    public OrdineBean() {
        this.dettagli = new ArrayList<>();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    public Date getDataOrdine() { return dataOrdine; }
    public void setDataOrdine(Date dataOrdine) { this.dataOrdine = dataOrdine; }
    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }
    public List<DettaglioOrdineBean> getDettagli() { return dettagli; }
    public void setDettagli(List<DettaglioOrdineBean> dettagli) { this.dettagli = dettagli; }
    public void addDettaglio(DettaglioOrdineBean dettaglio) { this.dettagli.add(dettaglio); }
}