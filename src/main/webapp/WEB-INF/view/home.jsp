<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Home</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>UrbanStep</h1>
        <nav class="navbar">
            <a href="catalogo?categoria=Tutte">Catalogo</a>
            <a href="carrello" style="font-weight: 700;">🛒 Carrello <span id="cart-badge" style="background-color: #e74c3c; color: white; border-radius: 50%; padding: 2px 8px; font-size: 0.75rem; margin-left: 5px;">${empty sessionScope.carrello ? '0' : sessionScope.carrello.items.size()}</span></a>
        </nav>
    </header>

    <main class="hero-section">
        <h2 class="hero-title">Step into the Future.</h2>
        <p class="hero-subtitle">Scopri la nostra collezione esclusiva di sneakers. Design iconici, edizioni limitate e le ultime release direttamente sul tuo schermo.</p>
        <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte" class="btn-hero">Scopri il Catalogo</a>
    </main>

</body>
</html>