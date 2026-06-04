-- -----------------------------------------------------
-- Creazione tabella Prodotto
-- -----------------------------------------------------
DROP TABLE IF EXISTS Prodotto;

CREATE TABLE Prodotto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descrizione VARCHAR(255),
    prezzo DECIMAL(10, 2) NOT NULL,
    quantita INT NOT NULL,
    categoria VARCHAR(50) NOT NULL
);

-- -----------------------------------------------------
-- Popolamento iniziale del catalogo (Sneakers)
-- -----------------------------------------------------
INSERT INTO Prodotto (nome, descrizione, prezzo, quantita, categoria) VALUES 
('Jordan 4 Military Black', 'Sneaker Air Jordan 4 retro, colorazione Military Black', 350.00, 10, 'Retro'),
('Jordan 4 Yellow Thunder', 'Sneaker Air Jordan 4 retro, colorazione Yellow Thunder', 280.00, 5, 'Retro'),
('Nocta Hot Step 2 White', 'Sneaker Nike x Nocta Hot Step 2, colorazione Total White', 220.00, 8, 'Limited');