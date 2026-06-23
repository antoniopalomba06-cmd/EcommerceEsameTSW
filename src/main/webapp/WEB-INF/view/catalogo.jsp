<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="model.ProdottoBean" %>
<%
    int cartCount = 0;
    model.Carrello currentCart = (model.Carrello) session.getAttribute("carrello");
    if (currentCart != null) {
        for (model.CarrelloItem i : currentCart.getItems()) {
            cartCount += i.getQuantita();
        }
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Catalogo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/main.js" defer></script>
</head>
<body>
    <header>
        <h1><a href="${pageContext.request.contextPath}/home" style="color: inherit; text-decoration: none;">UrbanStep</a></h1>
        <nav class="navbar">
        	<a href="ProfiloServlet">Il Mio Profilo</a>
            <a href="catalogo?categoria=Tutte">Tutte</a>
            <a href="catalogo?categoria=Limited">Limited</a>
            <a href="catalogo?categoria=High">High</a>
            <a href="catalogo?categoria=Mid">Mid</a>
            <a href="catalogo?categoria=Low">Low</a>
            <a href="catalogo?categoria=Retro">Retro</a>
            <a href="carrello" style="font-weight: 700;">🛒 Carrello <span id="cart-badge" style="background-color: #e74c3c; color: white; border-radius: 50%; padding: 2px 8px; font-size: 0.75rem; margin-left: 5px;"><%= cartCount %></span></a>
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
                            <a href="prodotto?id=<%= p.getId() %>" style="text-decoration: none; color: inherit; display: block;">
                                <div class="image-wrapper">
                                    <% if (p.getBase64Image() != null && !p.getBase64Image().isEmpty()) { %>
                                        <img src="data:image/jpeg;base64,<%= p.getBase64Image() %>" alt="<%= p.getNome() %>" class="product-img">
                                    <% } else { %>
                                        <img src="${pageContext.request.contextPath}/images/placeholder.jpg" alt="Immagine non disponibile" class="product-img">
                                    <% } %>

                                    <% if (p.getBase64ImageAlt() != null && !p.getBase64ImageAlt().isEmpty()) { %>
                                        <img src="data:image/jpeg;base64,<%= p.getBase64ImageAlt() %>" alt="<%= p.getNome() %> - Dettaglio" class="product-img-hover">
                                    <% } %>
                                </div>
                                <div class="product-brand">Nike</div>
                                <div class="product-title"><%= p.getNome() %></div>
                            </a>
                            <div class="product-price">€ <%= String.format("%.2f", p.getPrezzo()) %></div>
                            
                            <button class="btn-add" onclick="window.location.href='prodotto?id=<%= p.getId() %>'">Scegli Taglia</button>
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