const button = document.getElementById("theme-toggle");

const savedTheme = localStorage.getItem("theme");

if (savedTheme === "dark") {
    document.body.classList.add("dark-mode");
    button.innerHTML = "☀️";
}

button.addEventListener("click", () => {
    document.body.classList.toggle("dark-mode");

    const darkMode = document.body.classList.contains("dark-mode");

    localStorage.setItem("theme", darkMode ? "dark" : "light");

    button.innerHTML = darkMode ? "☀️" : "🌙";
});

const secoes = [
    document.getElementById("painel"),
    document.getElementById("novo-chamado"),
    document.getElementById("buscar-chamados"),
    document.getElementById("controle-acessos"),
    document.getElementById("perfil"),
].filter(Boolean);

const secaoParaNav = {
    painel: "painel",
    "novo-chamado": "novo-chamado",
    "buscar-chamados": "buscar-chamados",
    "controle-acessos": "controle-acessos",
    perfil: "perfil",
};

function marcarNavAtivo(secao) {
    document.querySelectorAll(".sidebar__button").forEach((btn) => {
        btn.classList.remove("active");
    });

    document.querySelectorAll(".sidebar__button").forEach((btn) => {
        const onclick = btn.getAttribute("onclick") || "";
        if (onclick.includes(`'${secao}'`)) {
            btn.classList.add("active");
        }
    });
}

function trocarSecao(secao) {
    secoes.forEach((s) => s.classList.add("hidden"));

    const target = document.getElementById(secao);

    if (target) {
        target.classList.remove("hidden");
    }

    marcarNavAtivo(secao);
}

function fecharModal() {
    const modal = document.getElementById("modal-editar-perfil");
    if (modal) modal.style.display = "none";
}

function abrirModalPerfil(somenteSenha = false) {
    const modal = document.getElementById("modal-editar-perfil");
    const titulo = document.getElementById("modal-titulo");
    const camposSenha = document.querySelectorAll(".campo-senha");
    const campoNome = document.getElementById("campo-nome");
    const campoTelefone = document.getElementById("campo-telefone");
    const campoEndereco = document.getElementById("campo-endereco");

    if (!modal) return;

    if (somenteSenha) {
        titulo.textContent = "Alterar senha";
        campoNome.classList.add("hidden");
        campoTelefone.classList.add("hidden");
        campoEndereco.classList.add("hidden");
        camposSenha.forEach((c) => c.classList.remove("hidden"));
    } else {
        titulo.textContent = "Editar perfil";
        campoNome.classList.remove("hidden");
        campoTelefone.classList.remove("hidden");
        campoEndereco.classList.remove("hidden");
        camposSenha.forEach((c) => c.classList.add("hidden"));
    }

    modal.style.display = "flex";
}

document.addEventListener("DOMContentLoaded", () => {
    const hash = window.location.hash.replace("#", "");

    if (hash && document.getElementById(hash)) {
        trocarSecao(hash);
    } else {
        const visible = secoes.find((s) => !s.classList.contains("hidden"));
        if (visible) {
            marcarNavAtivo(visible.id);
        } else {
            trocarSecao("painel");
        }
    }

    const toast = document.querySelector(".toast");

    if (toast) {
        setTimeout(() => {
            toast.style.opacity = "0";
            toast.style.transform = "translateX(100%)";
            setTimeout(() => toast.remove(), 300);
        }, 5000);
    }

    const filterButtons = document.querySelectorAll(".ticket-filter");
    const ticketCards = document.querySelectorAll(".ticket-list-card");
    const searchInput = document.getElementById("search-ticket");
    let currentFilter = "todos";

    function filterTickets() {
        const searchValue = searchInput ? searchInput.value.toLowerCase().trim() : "";

        ticketCards.forEach((card) => {
            const status = card.dataset.status;
            const searchableText = card.dataset.search.toLowerCase();
            const matchFilter = currentFilter === "todos" || status === currentFilter;
            const matchSearch = searchableText.includes(searchValue);
            card.style.display = matchFilter && matchSearch ? "block" : "none";
        });
    }

    filterButtons.forEach((btn) => {
        btn.addEventListener("click", () => {
            filterButtons.forEach((b) => b.classList.remove("active"));
            btn.classList.add("active");
            currentFilter = btn.dataset.filter;
            filterTickets();
        });
    });

    if (searchInput) searchInput.addEventListener("input", filterTickets);

    document.querySelectorAll(".expand-user-btn").forEach((btn) => {
        btn.addEventListener("click", () => {
            const targetId = btn.dataset.target;
            const detailsRow = document.getElementById(targetId);
            if (!detailsRow) return;

            detailsRow.classList.toggle("hidden");
            btn.classList.toggle("active");
            btn.innerHTML = detailsRow.classList.contains("hidden")
                ? '<i class="fa-solid fa-chevron-down"></i> Expandir'
                : '<i class="fa-solid fa-chevron-up"></i> Recolher';
        });
    });

    const searchUserInput = document.getElementById("search-user");
    const userRows = document.querySelectorAll(".user-row");

    if (searchUserInput) {
        searchUserInput.addEventListener("input", () => {
            const searchValue = searchUserInput.value.toLowerCase().trim();
            userRows.forEach((row) => {
                const text = row.dataset.search.toLowerCase();
                const detailsId = row.querySelector(".expand-user-btn")?.dataset.target;
                const detailsRow = detailsId ? document.getElementById(detailsId) : null;

                if (text.includes(searchValue)) {
                    row.style.display = "table-row";
                    if (detailsRow) detailsRow.style.display = "";
                } else {
                    row.style.display = "none";
                    if (detailsRow) detailsRow.style.display = "none";
                }
            });
        });
    }

    document.getElementById("modal-abrir-edicao")?.addEventListener("click", () => abrirModalPerfil(false));
    document.getElementById("modal-abrir-senha")?.addEventListener("click", () => abrirModalPerfil(true));
    document.getElementById("modal-cancelar-edicao")?.addEventListener("click", fecharModal);
    document.getElementById("modal-cancelar-edicao-2")?.addEventListener("click", fecharModal);

    const modal = document.getElementById("modal-editar-perfil");
    modal?.addEventListener("click", (e) => {
        if (e.target === modal) fecharModal();
    });
});
