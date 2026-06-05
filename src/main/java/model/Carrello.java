package model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {
    
    private List<CarrelloItem> items;

    public Carrello() {
        items = new ArrayList<>();
    }

    public void aggiungiProdotto(ProdottoBean prodotto) {
        for (CarrelloItem item : items) {
            if (item.getProdotto().getId() == prodotto.getId()) {
                item.setQuantita(item.getQuantita() + 1);
                return;
            }
        }
        items.add(new CarrelloItem(prodotto, 1));
    }

    public void diminuisciProdotto(int idProdotto) {
        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).getProdotto().getId() == idProdotto) {
                int nuovaQuantita = items.get(i).getQuantita() - 1;
                if (nuovaQuantita > 0) {
                    items.get(i).setQuantita(nuovaQuantita);
                } else {
                    items.remove(i);
                }
                return;
            }
        }
    }

    public void rimuoviProdotto(int idProdotto) {
        items.removeIf(item -> item.getProdotto().getId() == idProdotto);
    }

    public List<CarrelloItem> getItems() {
        return items;
    }

    public double getPrezzoTotale() {
        double totale = 0;
        for (CarrelloItem item : items) {
            totale += item.getPrezzoTotale();
        }
        return totale;
    }
}