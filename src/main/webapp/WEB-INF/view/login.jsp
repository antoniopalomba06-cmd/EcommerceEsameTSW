<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Login</title>
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
        <h2 class="login-title">Accedi</h2>
        <form action="${pageContext.request.contextPath}/login" method="POST" class="login-form">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">Entra</button>
            <p class="register-link">Non hai un account? <a href="${pageContext.request.contextPath}/registrazione">Registrati qui</a></p>
        </form>
    </div>
</body>
</html>