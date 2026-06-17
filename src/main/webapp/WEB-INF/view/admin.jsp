<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanStep | Pannello Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Pannello Amministrazione | UrbanStep</h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/home">Torna al Sito</a>
            <a href="${pageContext.request.contextPath}/logout" style="font-weight: 700; color: #d32f2f;">Esci</a>
        </nav>
    </header>

    <div class="container">
        <div class="admin-dashboard">
            <div class="admin-card">
                <h3>Gestione Prodotti</h3>
                <p>Aggiungi, modifica o elimina le scarpe dal catalogo.</p>
                <a href="${pageContext.request.contextPath}/admin/prodotti" class="btn-login" style="display: block; text-decoration: none; text-align: center; background-color: #d32f2f;">Gestisci Catalogo</a>
            </div>
            <div class="admin-card">
                <h3>Gestione Ordini</h3>
                <p>Visualizza e monitora gli ordini effettuati dai clienti.</p>
                <a href="${pageContext.request.contextPath}/adminOrdini" class="btn-login" style="display: block; text-decoration: none; text-align: center; background-color: #333;">Visualizza Ordini</a>
            </div>
        </div>
    </div>
</body>
</html>