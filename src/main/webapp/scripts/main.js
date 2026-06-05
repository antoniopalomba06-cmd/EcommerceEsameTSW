function aggiungiAlCarrello(idProdotto, bottone) {
    fetch('carrello?action=aggiungiAjax&id=' + idProdotto)
        .then(response => response.text())
        .then(nuovoTotale => {
            document.getElementById('cart-badge').innerText = nuovoTotale;
            
            let testoOriginale = bottone.innerText;
            bottone.innerText = "Aggiunto ✓";
            bottone.style.backgroundColor = "#27ae60";
            
            setTimeout(() => {
                bottone.innerText = testoOriginale;
                bottone.style.backgroundColor = "#000000";
            }, 2000);
        })
        .catch(error => console.error(error));
}