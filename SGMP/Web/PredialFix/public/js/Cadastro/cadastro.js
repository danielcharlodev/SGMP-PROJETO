document.querySelectorAll(".input-cdt").forEach((input) => {
    const placeholder = input.placeholder;

    input.addEventListener("focus", () => (input.placeholder = ""));
    input.addEventListener("blur", () => (input.placeholder = placeholder));
});

let cpf = document.getElementById("cpf_cdt");
let telefone = document.getElementById("telefone_cdt");

cpf.addEventListener("input", function () {
    let valor = cpf.value;
    valor = valor.replace(/\D/g, "");

    if (valor.length > 3) {
        valor = valor.slice(0, 3) + "." + valor.slice(3);
    }
    if (valor.length > 7) {
        valor = valor.slice(0, 7) + "." + valor.slice(7);
    }
    if (valor.length > 11) {
        valor = valor.slice(0, 11) + "-" + valor.slice(11);
    }
    valor = valor.slice(0, 14);
    cpf.value = valor;
});

telefone.addEventListener("input", function () {
    let valor = telefone.value;
    valor = valor.replace(/\D/g, "");
    valor = valor.slice(0, 11);
    if (valor.length > 0) {
        valor = "(" + valor;
    }
    if (valor.length > 3) {
        valor = valor.slice(0, 3) + ") " + valor.slice(3);
    }
    if (valor.length > 10) {
        if (valor.replace(/\D/g, "").length == 11) {
            valor = valor.slice(0, 10) + "-" + valor.slice(10);
        } else {
            valor = valor.slice(0, 9) + "-" + valor.slice(9);
        }
    }
    telefone.value = valor;
});
