<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Ordine Completato - UrbanStep</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="margin: 0; padding: 0; font-family: sans-serif; background-color: #f8f9fa;">

    <header style="background-color: #fff; padding: 20px; text-align: center; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
        <h1 style="margin: 0; color: #111; letter-spacing: 2px; text-transform: uppercase;">UrbanStep</h1>
    </header>

    <main style="display: flex; justify-content: center; align-items: center; min-height: 80vh; padding: 20px;">
        <div style="background: white; padding: 50px 40px; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.08); text-align: center; max-width: 500px; width: 100%;">
            
            <div style="background-color: #eafaf1; color: #27ae60; width: 80px; height: 80px; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 40px; margin: 0 auto 20px auto;">
                &#10003;
            </div>
            
            <h2 style="color: #2c3e50; font-size: 2rem; margin-bottom: 10px;">Pagamento Riuscito!</h2>
            
            <p style="color: #7f8c8d; font-size: 1.1rem; margin-bottom: 30px; line-height: 1.6;">
                Grazie per il tuo ordine. Abbiamo registrato tutto con successo e stiamo già preparando la tua spedizione.
            </p>
            
            <a href="${pageContext.request.contextPath}/catalogo?categoria=Tutte"  style="display: inline-block; padding: 14px 30px; background-color: #111; color: #fff; text-decoration: none; font-weight: bold; text-transform: uppercase; border-radius: 6px; letter-spacing: 1px;">
                Torna allo Shopping
            </a>
        </div>
    </main>

</body>
</html>