<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="model.ProdottoBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catalogo E-commerce</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px; }
        h2 { text-align: center; color: #333; }
        table { width: 80%; margin: 0 auto; border-collapse: collapse; background-color: white; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background-color: #007bff; color: white; }
        tr:hover { background-color: #f1f1f1; }
    </style>
</head>
<body>

    <h2>Il nostro Catalogo Prodotti</h2>
    
    <table>
        <tr>
            <th>Nome Prodotto</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Disponibilità</th>
        </tr>
        
        <%
            /* Recupero della collezione di prodotti dalla request */
            Collection<?> prodotti = (Collection<?>) request.getAttribute("listaProdotti");
            
            if (prodotti != null && !prodotti.isEmpty()) {
                Iterator<?> it = prodotti.iterator();
                
                while (it.hasNext()) {
                    ProdottoBean p = (ProdottoBean) it.next();
        %>
                    <tr>
                        <td><strong><%= p.getNome() %></strong></td>
                        <td><%= p.getDescrizione() %></td>
                        <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                        <td><%= p.getQuantita() %> pz.</td>
                    </tr>
        <%
                }
            } else {
        %>
                <tr>
                    <td colspan="4">Nessun prodotto attualmente disponibile nel catalogo.</td>
                </tr>
        <%
            }
        %>
    </table>

</body>
</html>