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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
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
            Carrello carrello = (Carrello) session.getAttribute("carrello");
            
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
                        <th>Azione</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (CarrelloItem item : carrello.getItems()) {
                    %>
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/images/<%= item.getProdotto().getId() %>.jpg" class="cart-img" alt="Scarpa"></td>
                            <td style="font-weight: 600;"><%= item.getProdotto().getNome() %></td>
                            <td><%= item.getQuantita() %></td>
                            <td>€ <%= String.format("%.2f", item.getProdotto().getPrezzo()) %></td>
                            <td>€ <%= String.format("%.2f", item.getPrezzoTotale()) %></td>
                            <td>
                                <form action="carrello" method="post" style="margin:0;">
                                    <input type="hidden" name="action" value="rimuovi">
                                    <input type="hidden" name="id" value="<%= item.getProdotto().getId() %>">
                                    <button type="submit" style="background:none; border:none; color:red; cursor:pointer; font-weight:bold; font-size:1.2rem;">X</button>
                                </form>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    <tr class="cart-total-row">
                        <td colspan="4" style="text-align: right; padding-right: 20px;">TOTALE COMPLESSIVO:</td>
                        <td colspan="2">€ <%= String.format("%.2f", carrello.getPrezzoTotale()) %></td>
                    </tr>
                </tbody>
            </table>

            <div style="display: flex; justify-content: flex-end; gap: 20px; margin-top: 30px;">
                <form action="carrello" method="post">
                    <input type="hidden" name="action" value="svuota">
                    <button type="submit" style="background-color: transparent; color: #000; border: 1px solid #000; padding: 15px 30px; text-transform: uppercase; cursor: pointer; font-weight: 600; transition: background-color 0.3s;">Svuota Carrello</button>
                </form>
                
                <button class="btn-checkout" style="margin-top: 0;">Procedi al Checkout</button>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>