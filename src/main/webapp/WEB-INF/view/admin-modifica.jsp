<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanStep | Modifica Prodotto</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Modifica Prodotto | UrbanStep</h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/admin/prodotti">Torna al Catalogo</a>
        </nav>
    </header>

    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="login-container" style="max-width: 600px; margin: 0 auto;">
            <h2 class="login-title" style="font-size: 1.5rem;">Aggiorna Dati: ${prodotto.nome}</h2>
            
            <form action="${pageContext.request.contextPath}/admin/prodotti" method="POST" enctype="multipart/form-data" class="login-form">
                <input type="hidden" name="id" value="${prodotto.id}">
                
                <div class="form-group">
                    <label for="nome">Nome Scarpa</label>
                    <input type="text" id="nome" name="nome" value="${prodotto.nome}" required>
                </div>
                
                <div class="form-group">
                    <label for="descrizione">Descrizione</label>
                    <input type="text" id="descrizione" name="descrizione" value="${prodotto.descrizione}" required>
                </div>
                
                <div class="form-group" style="display: flex; gap: 15px;">
                    <div style="flex: 1;">
                        <label for="prezzo">Prezzo (€)</label>
                        <input type="number" id="prezzo" name="prezzo" step="0.01" value="${prodotto.prezzo}" required>
                    </div>
                    <div style="flex: 1;">
                        <label for="quantita">Quantità Stock</label>
                        <input type="number" id="quantita" name="quantita" value="${prodotto.quantita}" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="categoria">Categoria</label>
                    <input type="text" id="categoria" name="categoria" value="${prodotto.categoria}" required>
                </div>

                <div class="form-group" style="background-color: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #eee;">
                    <h3 style="font-size: 1rem; margin-bottom: 10px; margin-top: 0;">Aggiorna Foto (Opzionale)</h3>
                    <p style="font-size: 0.8rem; color: #666; margin-bottom: 15px;">Seleziona un file solo se vuoi sovrascrivere o aggiungere l'immagine.</p>
                    
                    <div style="display: flex; gap: 15px;">
                        <div style="flex: 1;">
                            <label for="immagine" style="font-size: 0.9rem;">Nuova Foto Principale</label>
                            <input type="file" id="immagine" name="immagine" accept="image/*" style="padding-top: 5px;">
                            
                            <c:if test="${not empty prodotto.base64Image}">
                                <div style="margin-top: 10px;">
                                    <span style="font-size: 0.75rem; color: #888; display: block; margin-bottom: 5px;">Attuale:</span>
                                    <img src="data:image/jpeg;base64,${prodotto.base64Image}" style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;">
                                </div>
                            </c:if>
                        </div>
                        <div style="flex: 1;">
                            <label for="immagine_alt" style="font-size: 0.9rem;">Nuova Foto Hover</label>
                            <input type="file" id="immagine_alt" name="immagine_alt" accept="image/*" style="padding-top: 5px;">
                            
                            <c:if test="${not empty prodotto.base64ImageAlt}">
                                <div style="margin-top: 10px;">
                                    <span style="font-size: 0.75rem; color: #888; display: block; margin-bottom: 5px;">Attuale:</span>
                                    <img src="data:image/jpeg;base64,${prodotto.base64ImageAlt}" style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;">
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn-login" style="background-color: #333;">Salva Modifiche</button>
            </form>
        </div>
    </div>
</body>
</html>