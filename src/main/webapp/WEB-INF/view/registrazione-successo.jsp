<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Registrazione Completata</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1><a href="${pageContext.request.contextPath}/home" style="color: inherit; text-decoration: none;">UrbanStep</a></h1>
    </header>

    <div class="login-container" style="text-align: center;">
        <h2 class="login-title">Account Creato!</h2>
        <p style="margin-bottom: 30px; color: #555; line-height: 1.6; font-size: 0.95rem;">
            La registrazione è andata a buon fine. Il tuo account è attivo e pronto per essere utilizzato.
        </p>
        <a href="${pageContext.request.contextPath}/login" class="btn-login" style="display: block; text-decoration: none; text-align: center;">Accedi al Login</a>
    </div>
</body>
</html>