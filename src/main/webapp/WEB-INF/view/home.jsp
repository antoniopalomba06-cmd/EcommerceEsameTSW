<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>UrbanStep | Home</title>
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
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte">Catalogo</a>
            <a href="${pageContext.request.contextPath}/carrello" style="font-weight: 700;">🛒 Carrello</a>

            <c:choose>
                <c:when test="${not empty sessionScope.utente}">
                    <a href="${pageContext.request.contextPath}/ProfiloServlet">Il Mio Profilo</a>
                    <span style="color: #555; font-size: 0.9rem; text-transform: uppercase; font-weight: 600; align-self: center;">
                        👤 Ciao, ${sessionScope.utente.nome}!
                    </span>
                    <c:if test="${sessionScope.utente.ruolo == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin" style="color: #d32f2f; font-weight: 700;">⚙️ Admin</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/logout">Esci</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-nav-login">Login / Registrati</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <section class="parallax-hero">
        <div class="parallax-overlay"></div>
        <div class="parallax-content">
            <h2>Non seguire la moda.<br>Camminaci sopra.</h2>
            <p>Scopri l'ultima collezione in edizione limitata.</p>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Limited" class="btn-light">Vedi Limited Edition</a>
        </div>
    </section>

    <section class="split-section">
        <div class="split-text">
            <h3>Ispirate alla strada.<br>Create per te.</h3>
            <p>Ogni cucitura, ogni colore, ogni dettaglio è pensato per chi vive la città senza compromessi. Esplora le icone del momento e trova il paio che parla di te.</p>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte" class="btn-light">Esplora il catalogo</a>
        </div>
        <div class="split-image"></div>
    </section>

    <div class="container" style="margin-top: 80px; margin-bottom: 80px;">
        <h2 style="text-align: center; margin-bottom: 50px; font-size: 2.5rem; letter-spacing: -1px; text-transform: uppercase;">In Evidenza</h2>
        
        <div class="product-grid">
            <c:forEach items="${requestScope.prodottiInEvidenza}" var="p" begin="0" end="3">
                <div class="product-card">
                    <div class="image-wrapper">
                        <img src="${pageContext.request.contextPath}/images/${p.id}.jpg" alt="${p.nome}" class="product-img">
                        <img src="${pageContext.request.contextPath}/images/${p.id}_alt.jpg" alt="${p.nome} - Dettaglio" class="product-img-hover">
                    </div>
                    <div class="product-brand">Nike</div>
                    <div class="product-title">${p.nome}</div>
                    <div class="product-price">€ ${p.prezzo}</div>
                    <button class="btn-add" onclick="aggiungiAlCarrello(${p.id}, this)">Aggiungi al carrello</button>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>