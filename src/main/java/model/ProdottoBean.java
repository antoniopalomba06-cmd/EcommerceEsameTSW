package model;

public class ProdottoBean {
    private int id;
    private String nome;
    private String descrizione;
    private double prezzo;
    private int quantita;
    private String categoria; // Nuova variabile per il filtro

    // Costruttore vuoto
    public ProdottoBean() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }

    public int getQuantita() { return quantita; }
    public void setQuantita(int quantita) { this.quantita = quantita; }

    /* Metodi Getter e Setter per la Categoria */
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
}