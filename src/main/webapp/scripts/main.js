function aggiungiAlCarrello(idProdotto, bottone) {
    let pathArray = window.location.pathname.split('/');
    let contextPath = "";
    if (pathArray.length > 1) {
        contextPath = "/" + pathArray[1];
    }
    
    fetch(contextPath + '/carrello?action=aggiungiAjax&id=' + idProdotto)
        .then(response => {
            if (!response.ok) {
                throw new Error("Errore 404 - Servlet non trovata");
            }
            return response.text();
        })
        .then(nuovoTotale => {
            if (!isNaN(nuovoTotale) && nuovoTotale.trim() !== "") {
                let badge = document.getElementById('cart-badge');
                if (badge) badge.innerText = nuovoTotale;
                
                let testoOriginale = bottone.innerText;
                bottone.innerText = "Aggiunto ✓";
                bottone.style.backgroundColor = "#27ae60";
                
                setTimeout(() => {
                    bottone.innerText = testoOriginale;
                    bottone.style.backgroundColor = "#000000"; 
                }, 2000);
            } else {
                console.error("Il server ha risposto con dati non validi:", nuovoTotale);
            }
        })
        .catch(error => console.error("Errore AJAX:", error));
}