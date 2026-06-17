<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Storico Vendite Globale</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <style>
        .admin-container {
            max-width: 1100px;
            margin: 60px auto;
            padding: 0 20px;
        }
        .btn-back {
            display: inline-block;
            margin-bottom: 20px;
            color: #555;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: color 0.3s;
        }
        .btn-back:hover {
            color: #d32f2f;
        }
        .page-title {
            text-align: center;
            margin-bottom: 40px;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: -1px;
            color: #333;
        }
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        .admin-table th, .admin-table td {
            padding: 20px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .admin-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        .admin-table tr:last-child td {
            border-bottom: none;
        }
        .admin-table tr:hover {
            background-color: #fafafa;
        }
        .badge-id {
            font-weight: 700;
            color: #d32f2f;
        }
        .price-total {
            font-weight: 700;
            color: #27ae60;
        }
    </style>
</head>
<body>

    <header>
        <h1><a href="${pageContext.request.contextPath}/home" style="color: inherit; text-decoration: none;">UrbanStep | Admin</a></h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
            <a href="${pageContext.request.contextPath}/home">Torna al Sito</a>
            <a href="${pageContext.request.contextPath}/logout" style="font-weight: 700; color: #d32f2f;">Esci</a>
        </nav>
    </header>

    <div class="admin-container">
        <a href="${pageContext.request.contextPath}/admin" class="btn-back">← Torna al Menu Principale</a>
        
        <h2 class="page-title">Storico Vendite Globale</h2>
        
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID Ordine</th>
                    <th>ID Utente</th>
                    <th>Data Acquisto</th>
                    <th>Indirizzo Spedizione</th>
                    <th>Incasso Totale</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty ordini}">
                        <tr><td colspan="5" style="text-align: center; padding: 40px; color: #777;">Nessun ordine presente nel database.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${ordini}" var="o">
                            <tr>
                                <td class="badge-id">#${o.id}</td>
                                <td style="font-weight: 500;">Utente ${o.idUtente}</td>
                                <td>${o.dataOrdine}</td>
                                <td style="color: #666;">${o.indirizzoSpedizione}</td>
                                <td class="price-total">&euro; ${o.totale}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</body>
</html>