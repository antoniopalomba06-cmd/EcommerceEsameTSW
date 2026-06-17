<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanStep | Gestione Catalogo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <h1>Gestione Catalogo | UrbanStep</h1>
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/admin">Torna alla Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" style="font-weight: 700; color: #d32f2f;">Esci</a>
        </nav>
    </header>

    <div class="container" style="margin-top: 30px;">
        <div class="login-container" style="max-width: 600px; margin: 0 auto 40px;">
            <h2 class="login-title" style="font-size: 1.5rem;">Aggiungi Nuovo Prodotto</h2>
            <form action="${pageContext.request.contextPath}/admin/prodotti" method="POST" enctype="multipart/form-data" class="login-form">
                <div class="form-group">
                    <label for="nome">Nome Scarpa</label>
                    <input type="text" id="nome" name="nome" required>
                </div>
                <div class="form-group">
                    <label for="descrizione">Descrizione</label>
                    <input type="text" id="descrizione" name="descrizione" required>
                </div>
                <div class="form-group" style="display: flex; gap: 15px;">
                    <div style="flex: 1;">
                        <label for="prezzo">Prezzo (€)</label>
                        <input type="number" id="prezzo" name="prezzo" step="0.01" required>
                    </div>
                    <div style="flex: 1;">
                        <label for="quantita">Quantità Stock</label>
                        <input type="number" id="quantita" name="quantita" required>
                    </div>
                </div>
                <div class="form-group" style="display: flex; gap: 15px;">
                    <div style="flex: 1;">
                        <label for="categoria">Categoria</label>
                        <input type="text" id="categoria" name="categoria" placeholder="Es. Sneakers" required>
                    </div>
                    <div style="flex: 1;">
                        <label for="immagine">Foto Principale</label>
                        <input type="file" id="immagine" name="immagine" accept="image/*" style="padding-top: 10px;">
                    </div>
                    <div style="flex: 1;">
                        <label for="immagine_alt">Foto Hover</label>
                        <input type="file" id="immagine_alt" name="immagine_alt" accept="image/*" style="padding-top: 10px;">
                    </div>
                </div>
                <button type="submit" class="btn-login" style="background-color: #d32f2f;">Inserisci nel Catalogo</button>
            </form>
        </div>

        <h2 style="margin-bottom: 20px; text-transform: uppercase; font-size: 1.3rem; letter-spacing: -0.5px;">Prodotti in Catalogo</h2>
        <div style="overflow-x: auto; background: white; border: 1px solid #eee; border-radius: 8px; padding: 10px;">
            <table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 0.95rem;">
                <thead>
                    <tr style="border-bottom: 2px solid #000; background: #fafafa;">
                        <th style="padding: 12px;">Foto</th>
                        <th style="padding: 12px;">ID</th>
                        <th style="padding: 12px;">Nome</th>
                        <th style="padding: 12px;">Categoria</th>
                        <th style="padding: 12px;">Prezzo</th>
                        <th style="padding: 12px;">Stock</th>
                        <th style="padding: 12px; text-align: center;">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${prodotti}">
                        <tr style="border-bottom: 1px solid #eee;">
                            <td style="padding: 12px;">
                                <c:if test="${not empty p.base64Image}">
                                    <img src="data:image/jpeg;base64,${p.base64Image}" alt="Foto" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                </c:if>
                            </td>
                            <td style="padding: 12px;">${p.id}</td>
                            <td style="padding: 12px; font-weight: 600;">${p.nome}</td>
                            <td style="padding: 12px;">${p.categoria}</td>
                            <td style="padding: 12px;">${p.prezzo} €</td>
                            <td style="padding: 12px;">${p.quantita}</td>
                            <td style="padding: 12px; text-align: center; display: flex; gap: 15px; justify-content: center; align-items: center; height: 50px;">
                                <a href="${pageContext.request.contextPath}/admin/prodotti?action=edit&id=${p.id}" 
                                   style="color: #27ae60; text-decoration: none; font-weight: 700;">
                                   ✏️ Modifica
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/prodotti?action=delete&id=${p.id}" 
                                   style="color: #d32f2f; text-decoration: none; font-weight: 700;"
                                   onclick="return confirm('Sicuro di voler eliminare questa scarpa?');">
                                   ❌ Elimina
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if var="vuoto" test="${empty prodotti}">
                        <tr>
                            <td colspan="7" style="padding: 20px; text-align: center; color: #999;">Nessun prodotto presente nel catalogo.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>