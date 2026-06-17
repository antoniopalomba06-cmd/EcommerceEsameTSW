<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Il mio Profilo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="font-family: sans-serif; background-color: #f8f9fa; margin: 0; padding: 0;">

    <header style="background-color: #fff; padding: 20px; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
        <h1 style="margin-bottom: 15px;">Benvenuto, ${utente.nome}!</h1>
        <nav style="display: flex; justify-content: center; gap: 20px;">
            <a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: #333; font-weight: 600; padding: 8px 16px; border: 2px solid #333; border-radius: 4px;">Home</a>
            
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte" style="text-decoration: none; color: #333; font-weight: 600; padding: 8px 16px; border: 2px solid #333; border-radius: 4px;">Catalogo</a>
            
            <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #fff; background-color: #d32f2f; font-weight: 600; padding: 8px 16px; border: 2px solid #d32f2f; border-radius: 4px;">Logout</a>
        </nav>
    </header>

    <main style="padding: 40px; max-width: 800px; margin: 0 auto;">
        <div style="background: white; padding: 20px; border-radius: 8px; margin-bottom: 30px; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
            <h3>I tuoi Dati</h3>
            <p><strong>Nome:</strong> ${utente.nome} ${utente.cognome}</p>
            <p><strong>Email:</strong> ${utente.email}</p>
            <p><strong>Indirizzo di spedizione:</strong> ${utente.indirizzo}</p>
        </div>

        <h3 style="color: #2c3e50;">Storico Acquisti</h3>
        <table style="width: 100%; border-collapse: collapse; background: #fff; box-shadow: 0 4px 8px rgba(0,0,0,0.05);">
            <thead>
                <tr style="background-color: #f2f2f2; border-bottom: 2px solid #ddd;">
                    <th style="padding: 12px; text-align: left;">ID Ordine</th>
                    <th style="padding: 12px; text-align: left;">Data</th>
                    <th style="padding: 12px; text-align: left;">Totale Speso</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty storicoOrdini}">
                        <tr><td colspan="3" style="padding: 15px; text-align: center;">Nessun ordine effettuato.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${storicoOrdini}" var="ordine">
                            <tr style="border-bottom: 1px solid #eee;">
                                <td style="padding: 12px;">#${ordine.id}</td>
                                <td style="padding: 12px;">${ordine.dataOrdine}</td>
                                <td style="padding: 12px; font-weight: bold;">&euro; ${ordine.totale}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </main>
</body>
</html>