package model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
    
    private List<CarrelloItem> items;

    public Carrello() {
        items = new ArrayList<>();
    }

    // Aggiunge un prodotto o aumenta la quantità se è già presente
    public void aggiungiProdotto(ProdottoBean prodotto) {
        for (CarrelloItem item : items) {
            if (item.getProdotto().getId() == prodotto.getId()) {
                item.setQuantita(item.getQuantita() + 1);
                return;
            }
        }
        items.add(new CarrelloItem(prodotto, 1));
    }

    // Rimuove un prodotto specifico dal carrello
    public void rimuoviProdotto(int idProdotto) {
        items.removeIf(item -> item.getProdotto().getId() == idProdotto);
    }

    public List<CarrelloItem> getItems() {
        return items;
    }

    // Calcola il costo totale dell'intero carrello
    public double getPrezzoTotale() {
        double totale = 0;
        for (CarrelloItem item : items) {
            totale += item.getPrezzoTotale();
        }
        return totale;
    }
}