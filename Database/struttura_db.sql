-- 1. Creiamo il database e diciamo a MySQL di usarlo
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. Tabella Utente (clienti e admin)
CREATE TABLE Utente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    ruolo VARCHAR(20) DEFAULT 'cliente' -- useremo 'cliente' o 'admin'
);

-- 3. Tabella Prodotto 
CREATE TABLE Prodotto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descrizione TEXT,
    prezzo_attuale DECIMAL(10, 2) NOT NULL,
    attivo BOOLEAN DEFAULT TRUE 
);

-- 4. Tabella Ordine (la testata dello scontrino)
CREATE TABLE Ordine (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    data_ordine DATETIME DEFAULT CURRENT_TIMESTAMP,
    totale DECIMAL(10, 2) NOT NULL,
    indirizzo_spedizione VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_utente) REFERENCES Utente(id)
);

-- 5. Tabella DettaglioOrdine 
CREATE TABLE DettaglioOrdine (
    id_ordine INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    prezzo_acquistato DECIMAL(10, 2) NOT NULL, -- Questo salva il prezzo AL MOMENTO DELL'ACQUISTO
    PRIMARY KEY (id_ordine, id_prodotto),
    FOREIGN KEY (id_ordine) REFERENCES Ordine(id),
    FOREIGN KEY (id_prodotto) REFERENCES Prodotto(id)
);