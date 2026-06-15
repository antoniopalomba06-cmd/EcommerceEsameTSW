<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Registrazione</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1><a href="${pageContext.request.contextPath}/home" style="color: inherit; text-decoration: none;">UrbanStep</a></h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte">Catalogo</a>
            <a href="${pageContext.request.contextPath}/carrello" style="font-weight: 700;">🛒 Carrello</a>
        </nav>
    </header>

    <div class="login-container">
        <h2 class="login-title">Crea Account</h2>
        <c:if test="${not empty errore}">
    <p style="color: red; text-align: center; font-weight: bold;">${errore}</p>
</c:if>
        <form action="${pageContext.request.contextPath}/registrazione" method="POST" class="login-form">
            <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            <div class="form-group">
                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>
            <div class="form-group">
    <label for="email">Email</label>
    <input type="email" id="email" name="email" required>
    <span id="email-error" style="color: #d32f2f; font-size: 0.85rem; font-weight: 600; display: block; margin-top: 5px;"></span>
</div>

<div class="form-group">
    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>
    <span id="password-error" style="color: #d32f2f; font-size: 0.85rem; font-weight: 600; display: block; margin-top: 5px;"></span>
</div>
            <button type="submit" class="btn-login">Registrati</button>
            <p class="register-link">Hai già un account? <a href="${pageContext.request.contextPath}/login">Accedi</a></p>
        </form>
    </div>
    <script src="${pageContext.request.contextPath}/scripts/validazioni.js"></script>
</body>
</html>