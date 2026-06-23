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
    <style>
        .carousel-wrapper {
            width: 100%;
            overflow: hidden;
            padding: 40px 0;
            background-color: #fafafa;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }
        .slider-track {
            display: flex;
            gap: 30px;
            animation: scrollTrack 20s linear infinite;
            width: max-content;
            padding: 15px 0;
        }
        .slider-track:hover {
            animation-play-state: paused;
        }
        .slider-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            text-align: center;
            transition: all 0.3s ease;
            width: 260px;
        }
        .slider-item:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }
        .slider-item a {
            text-decoration: none;
            color: inherit;
            display: block;
        }
        .slider-item img {
            width: 100%;
            height: 220px;
            object-fit: contain;
            margin-bottom: 15px;
            background: transparent;
        }
        .slider-item p {
            margin: 0;
            font-weight: 700;
            font-size: 1.05rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #111;
        }
        @keyframes scrollTrack {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
    </style>
</head>
<body style="margin: 0; padding: 0; overflow-x: hidden;">
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

    <section class="split-section" style="display: flex;">
        <div class="split-text" style="flex: 1;">
            <h3>Ispirate alla strada.<br>Create per te.</h3>
            <p>Ogni cucitura, ogni colore, ogni dettaglio è pensato per chi vive la città senza compromessi. Esplora le icone del momento e trova il paio che parla di te.</p>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte" class="btn-light">Esplora il catalogo</a>
        </div>
        <div class="split-image" style="flex: 1; display: flex; min-height: 400px;">
            <img src="${pageContext.request.contextPath}/images/strada.jpg" alt="UrbanStep Collection" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
    </section>

    <div class="container" style="margin-top: 80px; margin-bottom: 20px;">
        <h2 style="text-align: center; font-size: 2.5rem; letter-spacing: -1px; text-transform: uppercase;">In Evidenza</h2>
    </div>
    
    <div class="carousel-wrapper">
        <div class="slider-track">
            <c:forEach items="${requestScope.prodottiInEvidenza}" var="p">
                <c:if test="${not empty p.base64Image}">
                    <div class="slider-item">
                        <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}">
                            <img src="data:image/jpeg;base64,${p.base64Image}" alt="${p.nome}">
                            <p>${p.nome}</p>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
            
            <c:forEach items="${requestScope.prodottiInEvidenza}" var="p">
                <c:if test="${not empty p.base64Image}">
                    <div class="slider-item">
                        <a href="${pageContext.request.contextPath}/prodotto?id=${p.id}">
                            <img src="data:image/jpeg;base64,${p.base64Image}" alt="${p.nome}">
                            <p>${p.nome}</p>
                        </a>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
    
    <div style="height: 60px;"></div>

</body>
</html>