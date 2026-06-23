<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanStep | ${prodotto.nome}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/main.js" defer></script>
    <style>
        .product-detail-container {
            display: flex;
            max-width: 1200px;
            margin: 60px auto;
            gap: 50px;
            padding: 0 20px;
            align-items: flex-start;
        }
        .product-gallery {
            flex: 1;
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            background-color: #f8f9fa;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            aspect-ratio: 1 / 1;
            display: flex;
            align-items: center;
        }
        .slide-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }
        .slide-img.active {
            display: block;
            animation: fadeIn 0.3s ease-in-out;
        }
        .slider-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(255, 255, 255, 0.8);
            color: #111;
            border: none;
            cursor: pointer;
            width: 40px;
            height: 40px;
            font-size: 1.2rem;
            border-radius: 50%;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
        }
        .slider-arrow:hover {
            background-color: #111;
            color: white;
        }
        .slider-arrow.prev { left: 15px; }
        .slider-arrow.next { right: 15px; }
        .product-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding-top: 10px;
        }
        .product-info h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            letter-spacing: -1px;
            text-transform: uppercase;
        }
        .product-price-large {
            font-size: 1.8rem;
            font-weight: 700;
            color: #d32f2f;
            margin-bottom: 20px;
        }
        .product-desc {
            font-size: 1.05rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 30px;
        }
        .size-selector {
            margin-bottom: 30px;
        }
        .size-selector select {
            width: 100%;
            padding: 15px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            cursor: pointer;
        }
        .btn-add-large {
            background-color: #111;
            color: white;
            border: none;
            padding: 18px;
            font-size: 1.1rem;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
            width: 100%;
        }
        .btn-add-large:hover {
            background-color: #d32f2f;
        }
        @keyframes fadeIn {
            from { opacity: 0.8; }
            to { opacity: 1; }
        }
        @media screen and (max-width: 768px) {
            .product-detail-container {
                flex-direction: column;
                margin: 20px auto;
                gap: 30px;
            }
            .product-gallery {
                width: 100%;
                aspect-ratio: auto;
            }
            .product-info h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><a href="${pageContext.request.contextPath}/home" style="color: inherit; text-decoration: none;">UrbanStep</a></h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte">Torna al Catalogo</a>
            <a href="${pageContext.request.contextPath}/carrello" style="font-weight: 700;">🛒 Carrello</a>
        </nav>
    </header>

    <div class="product-detail-container">
        <div class="product-gallery">
            <c:choose>
                <c:when test="${not empty prodotto.base64Image}">
                    <img src="data:image/jpeg;base64,${prodotto.base64Image}" alt="${prodotto.nome}" class="slide-img active">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/placeholder.jpg" alt="Nessuna immagine" class="slide-img active">
                </c:otherwise>
            </c:choose>
            <c:if test="${not empty prodotto.base64ImageAlt}">
                <img src="data:image/jpeg;base64,${prodotto.base64ImageAlt}" alt="${prodotto.nome} - Dettaglio" class="slide-img">
                <button class="slider-arrow prev" onclick="moveSlide(-1)">&#10094;</button>
                <button class="slider-arrow next" onclick="moveSlide(1)">&#10095;</button>
            </c:if>
        </div>

        <div class="product-info">
            <span style="color: #888; font-weight: 600; text-transform: uppercase; letter-spacing: 2px;">Categoria: ${prodotto.categoria}</span>
            <h1>${prodotto.nome}</h1>
            <div class="product-price-large">€ ${prodotto.prezzo}</div>
            
            <div class="product-desc">
                ${prodotto.descrizione}
            </div>

            <div class="size-selector">
                <label for="taglia" style="display: block; font-weight: 600; margin-bottom: 10px;">Seleziona la Taglia (EU):</label>
                <select id="taglia" name="taglia">
                    <option value="" disabled selected>Scegli una misura...</option>
                    <option value="38">38</option>
                    <option value="39">39</option>
                    <option value="40">40</option>
                    <option value="41">41</option>
                    <option value="42">42</option>
                    <option value="43">43</option>
                    <option value="44">44</option>
                    <option value="45">45</option>
                </select>
            </div>

            <button class="btn-add-large" onclick="aggiungiAlCarrello(${prodotto.id}, this)">
                Aggiungi al carrello
            </button>
            
            <p style="margin-top: 15px; font-size: 0.9rem; color: #27ae60; font-weight: 600;">
                ✓ Disponibilità: ${prodotto.quantita} pezzi in magazzino
            </p>
        </div>
    </div>

    <script>
        let currentSlideIndex = 0;
        const slides = document.querySelectorAll('.slide-img');
        function moveSlide(n) {
            if (slides.length <= 1) return;
            slides[currentSlideIndex].classList.remove('active');
            currentSlideIndex += n;
            if (currentSlideIndex >= slides.length) {
                currentSlideIndex = 0;
            } else if (currentSlideIndex < 0) {
                currentSlideIndex = slides.length - 1;
            }
            slides[currentSlideIndex].classList.add('active');
        }
    </script>
</body>
</html>