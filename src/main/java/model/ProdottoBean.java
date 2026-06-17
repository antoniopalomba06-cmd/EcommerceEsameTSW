package model;

public class ProdottoBean {
    private int id;
    private String nome;
    private String descrizione;
    private double prezzo;
    private int quantita;
    private String categoria;
    private byte[] immagine;
    private String base64Image;
    private byte[] immagineAlt;
    private String base64ImageAlt;

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
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
    public byte[] getImmagine() { return immagine; }
    public void setImmagine(byte[] immagine) { this.immagine = immagine; }
    public String getBase64Image() { return base64Image; }
    public void setBase64Image(String base64Image) { this.base64Image = base64Image; }
    public byte[] getImmagineAlt() { return immagineAlt; }
    public void setImmagineAlt(byte[] immagineAlt) { this.immagineAlt = immagineAlt; }
    public String getBase64ImageAlt() { return base64ImageAlt; }
    public void setBase64ImageAlt(String base64ImageAlt) { this.base64ImageAlt = base64ImageAlt; }
}