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

<<<<<<< HEAD
const secoes = [
    document.getElementById("painel"),
    document.getElementById("novo-chamado"),
    document.getElementById("buscar-chamados")
=======
const secoes=[
    document.getElementById('painel'),
    document.getElementById('novo-chamado'),
    document.getElementById('perfil')
>>>>>>> da798ba6ddd6f5f8453c6ed0a8dcbb69f1b94b90
];

function trocarSecao(secao) {
    secoes.forEach((sec) => {
        sec.classList.add("hidden");
    });
    document.getElementById(secao).classList.remove("hidden");
}

<<<<<<< HEAD


document.addEventListener("DOMContentLoaded", () => {
    const hash = window.location.hash.replace("#", "");

    if (hash) {
        trocarSecao(hash);
    }

    const toast = document.querySelector(".toast");

    if (toast) {
        setTimeout(() => {
            toast.style.opacity = "0";
            toast.style.transform = "translateX(100%)";

            setTimeout(() => {
                toast.remove();
            }, 300);
        }, 5000);
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const filterButtons = document.querySelectorAll('.ticket-filter');
    const ticketCards = document.querySelectorAll('.ticket-list-card');
    const searchInput = document.getElementById('search-ticket');

    let currentFilter = 'todos';

    function filterTickets() {
        const searchValue = searchInput ? searchInput.value.toLowerCase().trim() : '';

        ticketCards.forEach((card) => {
            const status = card.dataset.status;
            const searchableText = card.dataset.search.toLowerCase();

            const matchFilter = currentFilter === 'todos' || status === currentFilter;
            const matchSearch = searchableText.includes(searchValue);

            if (matchFilter && matchSearch) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    filterButtons.forEach((button) => {
        button.addEventListener('click', () => {
            filterButtons.forEach((btn) => {
                btn.classList.remove('active');
            });

            button.classList.add('active');

            currentFilter = button.dataset.filter;

            filterTickets();
        });
    });

    if (searchInput) {
        searchInput.addEventListener('input', filterTickets);
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const expandButtons = document.querySelectorAll('.expand-user-btn');

    expandButtons.forEach((button) => {
        button.addEventListener('click', () => {
            const targetId = button.dataset.target;
            const detailsRow = document.getElementById(targetId);

            if (!detailsRow) {
                return;
            }

            detailsRow.classList.toggle('hidden');
            button.classList.toggle('active');

            if (detailsRow.classList.contains('hidden')) {
                button.innerHTML = '<i class="fa-solid fa-chevron-down"></i> Expandir';
            } else {
                button.innerHTML = '<i class="fa-solid fa-chevron-down"></i> Recolher';
            }
        });
    });

    const searchUserInput = document.getElementById('search-user');
    const userRows = document.querySelectorAll('.user-row');

    if (searchUserInput) {
        searchUserInput.addEventListener('input', () => {
            const searchValue = searchUserInput.value.toLowerCase().trim();

            userRows.forEach((row) => {
                const text = row.dataset.search.toLowerCase();
                const detailsId = row.querySelector('.expand-user-btn')?.dataset.target;
                const detailsRow = detailsId ? document.getElementById(detailsId) : null;

                if (text.includes(searchValue)) {
                    row.style.display = 'table-row';
                } else {
                    row.style.display = 'none';

                    if (detailsRow) {
                        detailsRow.style.display = 'none';
                    }
                }

                if (text.includes(searchValue) && detailsRow) {
                    detailsRow.style.display = '';
                }
            });
        });
    }
});
=======
const modal = document.getElementById('modal-editar-perfil');
const abrir = document.getElementById('modal-abrir-edicao');
const fechar = document.getElementById("modal-cancelar-edicao");

abrir.onclick = function() {
    modal.style.display = "flex";
}

fechar.onclick = function() {
    modal.style.display = "none";
}
>>>>>>> da798ba6ddd6f5f8453c6ed0a8dcbb69f1b94b90
