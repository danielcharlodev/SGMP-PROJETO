// =========================
// PRIORIDADE (cores/classes)
// =========================
const prioridades = document.querySelectorAll(".prioridade");

prioridades.forEach((prioridade) => {
    const texto = prioridade.textContent
        .trim()
        .toLowerCase()
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "");

    if (texto === "alta") {
        prioridade.classList.add("alta");
    } 
    else if (texto === "media") {
        prioridade.classList.add("media");
    } 
    else if (texto === "baixa") {
        prioridade.classList.add("baixa");
    }
});


// =========================
// STATUS (data-status)
// =========================
const statusChamados = document.querySelectorAll(".status");

statusChamados.forEach((status) => {
    const tipo = status.dataset.status;

    if (tipo === "analise") {
        status.classList.add("analise");
    } 
    else if (tipo === "andamento") {
        status.classList.add("andamento");
    } 
    else if (tipo === "concluido") {
        status.classList.add("concluido");
    }
});


// =========================
// FILTRO (COM ANIMAÇÃO)
// =========================
const botoesFiltro = document.querySelectorAll(".filtros button");
const chamados = document.querySelectorAll(".chamado");

botoesFiltro.forEach((botao) => {
    botao.addEventListener("click", () => {

        const filtro = botao.dataset.filtro;

        chamados.forEach((chamado) => {

            const status = chamado.querySelector(".status").dataset.status;

            const mostrar = filtro === "todos" || status === filtro;

            if (mostrar) {
                chamado.classList.remove("escondido");
            } else {
                chamado.classList.add("escondido");
            }
        });
    });
});


// =========================
// MODAL
// =========================
const modal = document.querySelector("#modal");
const fecharModal = document.querySelector("#fechar-modal");

chamados.forEach((chamado) => {
    chamado.addEventListener("click", () => {
        modal.style.display = "flex";
    });
});

fecharModal.addEventListener("click", () => {
    modal.style.display = "none";
});

modal.addEventListener("click", (event) => {
    if (event.target === modal) {
        modal.style.display = "none";
    }
});