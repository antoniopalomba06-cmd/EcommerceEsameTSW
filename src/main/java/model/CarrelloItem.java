package model;

public class CarrelloItem {
    
    private ProdottoBean prodotto;
    private int quantita;

    public CarrelloItem(ProdottoBean prodotto, int quantita) {
        this.prodotto = prodotto;
        this.quantita = quantita;
    }

    public ProdottoBean getProdotto() { 
        return prodotto; 
    }
    
    public void setProdotto(ProdottoBean prodotto) { 
        this.prodotto = prodotto; 
    }
    
    public int getQuantita() { 
        return quantita; 
    }
    
    public void setQuantita(int quantita) { 
        this.quantita = quantita; 
    }
    
    // Calcola in automatico il prezzo per la quantità (es. 2 scarpe x 200€ = 400€)
    public double getPrezzoTotale() { 
        return prodotto.getPrezzo() * quantita; 
    }
}