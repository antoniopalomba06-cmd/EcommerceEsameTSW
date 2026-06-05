<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="model.ProdottoBean" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Catalogo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
    <header>
        <h1>UrbanStep</h1>
        <nav class="navbar">
            <a href="catalogo?categoria=Tutte">Tutte</a>
            <a href="catalogo?categoria=Limited">Limited</a>
            <a href="catalogo?categoria=High">High</a>
            <a href="catalogo?categoria=Mid">Mid</a>
            <a href="catalogo?categoria=Low">Low</a>
            <a href="catalogo?categoria=Retro">Retro</a>
            <a href="carrello" style="font-weight: 700;">🛒 Carrello</a>
        </nav>
    </header>

    <div class="container">
        <div class="product-grid">
            <%
                Collection<?> prodotti = (Collection<?>) request.getAttribute("listaProdotti");
                if (prodotti != null && !prodotti.isEmpty()) {
                    Iterator<?> it = prodotti.iterator();
                    while (it.hasNext()) {
                        ProdottoBean p = (ProdottoBean) it.next();
            %>
                        <div class="product-card">
                            <div class="image-wrapper">
                                <img src="images/<%= p.getId() %>.jpg" alt="<%= p.getNome() %>" class="product-img">
                                <img src="images/<%= p.getId() %>_alt.jpg" alt="<%= p.getNome() %> - Dettaglio" class="product-img-hover">
                            </div>
                            <div class="product-brand">Nike</div>
                            <div class="product-title"><%= p.getNome() %></div>
                            <div class="product-price">€ <%= String.format("%.2f", p.getPrezzo()) %></div>
                            <form action="carrello" method="get">
                                <input type="hidden" name="action" value="aggiungi">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button type="submit" class="btn-add">Aggiungi al carrello</button>
                            </form>
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