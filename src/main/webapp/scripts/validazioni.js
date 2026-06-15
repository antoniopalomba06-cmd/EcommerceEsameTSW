document.addEventListener("DOMContentLoaded", function() {
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const emailRegex = /^[^\s@]+@[^\s@]+\.[a-zA-Z]{2,}$/;
    const passwordRegex = /^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*]{8,}$/;

    if (emailInput) {
        emailInput.addEventListener("input", function() {
            const errorSpan = document.getElementById("email-error");
            
            if (emailInput.value.length === 0) {
                errorSpan.innerText = "";
                emailInput.style.borderColor = "#ccc";
            } else if (!emailRegex.test(emailInput.value)) {
                errorSpan.innerText = "Formato email non valido (es. mario@email.com)";
                emailInput.style.borderColor = "#d32f2f";
            } else {
                errorSpan.innerText = "";
                emailInput.style.borderColor = "#27ae60";
            }
        });
    }

    if (passwordInput) {
        passwordInput.addEventListener("input", function() {
            const errorSpan = document.getElementById("password-error");
            
            if (passwordInput.value.length === 0) {
                errorSpan.innerText = "";
                passwordInput.style.borderColor = "#ccc";
            } else if (!passwordRegex.test(passwordInput.value)) {
                errorSpan.innerText = "La password deve avere min 8 caratteri, 1 Maiuscola e 1 numero.";
                passwordInput.style.borderColor = "#d32f2f";
            } else {
                errorSpan.innerText = "";
                passwordInput.style.borderColor = "#27ae60";
            }
        });
    }
});