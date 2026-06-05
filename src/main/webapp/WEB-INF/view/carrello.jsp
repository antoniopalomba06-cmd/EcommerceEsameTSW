<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>
<%@ page import="model.CarrelloItem" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Il tuo Carrello</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
    <header>
        <h1>UrbanStep</h1>
        <nav class="navbar">
            <a href="catalogo?categoria=Tutte">Torna al Catalogo</a>
        </nav>
    </header>

    <div class="cart-container">
        <h2 class="cart-title">Il tuo Carrello</h2>

        <%
            /* Recuperiamo il carrello dallo "zaino" della sessione */
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
            /* Controlliamo se è vuoto o non esiste ancora */
            if (carrello == null || carrello.getItems().isEmpty()) {
        %>
            <div class="empty-msg">Il tuo carrello attualmente è vuoto.</div>
        <%
            } else {
        %>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Nome</th>
                        <th>Quantità</th>
                        <th>Prezzo</th>
                        <th>Totale</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /* Cicliamo su tutti i prodotti aggiunti e stampiamo le righe */
                        for (CarrelloItem item : carrello.getItems()) {
                    %>
                        <tr>
                            <td><img src="images/<%= item.getProdotto().getId() %>.jpg" class="cart-img" alt="Scarpa"></td>
                            <td style="font-weight: 600;"><%= item.getProdotto().getNome() %></td>
                            <td><%= item.getQuantita() %></td>
                            <td>€ <%= String.format("%.2f", item.getProdotto().getPrezzo()) %></td>
                            <td>€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                        </tr>
                    <%
                        }
                    %>
                    <tr class="cart-total-row">
                        <td colspan="4" style="text-align: right; padding-right: 20px;">TOTALE COMPLESSIVO:</td>
                        <td>€ <%= String.format("%.2f", carrello.getPrezzoTotale()) %></td>
                    </tr>
                </tbody>
            </table>

            <button class="btn-checkout">Procedi al Checkout</button>
        <%
            }
        %>
    </div>
</body>
</html>