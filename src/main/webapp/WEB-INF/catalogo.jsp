<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="model.ProdottoBean" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Premium Sneakers | Catalogo</title>
    <style>
        /* Reset e Base */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; }
        body { background-color: #ffffff; color: #000000; -webkit-font-smoothing: antialiased; }
        
        /* Header e Navigazione Stile Minimal */
        header { text-align: center; padding: 40px 20px 20px; }
        h1 { font-size: 2rem; font-weight: 700; letter-spacing: -0.5px; text-transform: uppercase; margin-bottom: 20px; }
        
        .navbar { display: flex; justify-content: center; gap: 30px; border-bottom: 1px solid #eeeeee; padding-bottom: 20px; margin-bottom: 40px; }
        .navbar a { text-decoration: none; color: #555555; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px; transition: color 0.3s; }
        .navbar a:hover, .navbar a.active { color: #000000; font-weight: bold; }

        /* Griglia Prodotti */
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px 60px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 50px 20px; }
        
        /* Singola Card Prodotto */
        .product-card { text-align: center; display: flex; flex-direction: column; cursor: pointer; transition: opacity 0.3s; }
        .product-card:hover { opacity: 0.8; }
        
        /* Placeholder per l'immagine della scarpa */
        .image-placeholder { background-color: #f6f6f6; height: 280px; display: flex; align-items: center; justify-content: center; margin-bottom: 15px; color: #cccccc; font-size: 0.9rem; text-transform: uppercase; }
       /* Gestione layout e transizioni per la galleria prodotti */
        .image-wrapper { 
            height: 380px; 
            position: relative; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin-bottom: 20px; 
            overflow: hidden; 
            background-color: #f6f6f6; 
        }
        
        .product-img, .product-img-hover { 
            position: absolute; 
            max-width: 90%; /* Lascia un piccolo margine interno per non far toccare le scarpe ai bordi */
            max-height: 90%; 
            object-fit: contain; 
            transition: opacity 0.4s ease, transform 0.5s ease; 
        }
        
        .product-img-hover {
            opacity: 0; 
        }
        
        /* Animazione di swap dell'immagine on-hover */
        .product-card:hover .product-img { 
            opacity: 0; 
        }
        
        .product-card:hover .product-img-hover { 
            opacity: 1; 
            transform: scale(1.05); 
        }
        
        /* Testi del prodotto */
        .product-brand { font-size: 0.8rem; color: #888888; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .product-title { font-size: 1rem; font-weight: 600; margin-bottom: 8px; line-height: 1.3; }
        .product-price { font-size: 1rem; font-weight: 400; margin-bottom: 15px; }
        
        /* Bottone */
        .btn-add { background-color: #000000; color: #ffffff; border: none; padding: 12px 0; width: 100%; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; cursor: pointer; transition: background-color 0.3s; margin-top: auto; }
        .btn-add:hover { background-color: #333333; }
        
        .empty-msg { text-align: center; grid-column: 1 / -1; color: #888; padding: 50px 0; }
    </style>
</head>
<body>

    <header>
        <h1>Urban Steps</h1>
        
        <nav class="navbar">
            <a href="catalogo?categoria=Tutte">Tutte</a>
            <a href="catalogo?categoria=Limited">Limited</a>
            <a href="catalogo?categoria=High">High</a>
            <a href="catalogo?categoria=Mid">Mid</a>
            <a href="catalogo?categoria=Low">Low</a>
            <a href="catalogo?categoria=Retro">Retro</a>
        </nav>
        
    </header>

    <div class="container">
        <div class="product-grid">
            <%
                /* Recupero dei prodotti dalla request inviata dalla Servlet */
                Collection<?> prodotti = (Collection<?>) request.getAttribute("listaProdotti");
                
                if (prodotti != null && !prodotti.isEmpty()) {
                    Iterator<?> it = prodotti.iterator();
                    
                    while (it.hasNext()) {
                        ProdottoBean p = (ProdottoBean) it.next();
            %>
                        <div class="product-card">
                            <div class="image-wrapper">
                                <img src="img/<%= p.getId() %>.jpg" alt="<%= p.getNome() %>" class="product-img">
                                <img src="img/<%= p.getId() %>_alt.jpg" alt="<%= p.getNome() %> - Dettaglio" class="product-img-hover">
                            </div>
                            
                            <div class="product-brand">Nike</div>
                            <div class="product-title"><%= p.getNome() %></div>
                            <div class="product-price">€ <%= String.format("%.2f", p.getPrezzo()) %></div>
                            
                            <button class="btn-add">Aggiungi al carrello</button>
                        </div>
            <%
                    }
                } else {
            %>
                    <div class="empty-msg">Nessun modello attualmente disponibile.</div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>