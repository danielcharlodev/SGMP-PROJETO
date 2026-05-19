const button = document.getElementById('theme-toggle');

const savedTheme = localStorage.getItem('theme');

if (savedTheme === 'dark') {

    document.body.classList.add('dark-mode');

    button.innerHTML = '☀️';

}

button.addEventListener('click', () => {

    document.body.classList.toggle('dark-mode');

    const darkMode =
        document.body.classList.contains('dark-mode');

    localStorage.setItem(
        'theme',
        darkMode ? 'dark' : 'light'
    );

    button.innerHTML = darkMode
        ? '☀️'
        : '🌙';

});

const secoes=[
    document.getElementById('painel'),
    document.getElementById('novo-chamado'),
    document.getElementById('perfil')
];

function trocarSecao(secao){
    secoes.forEach(sec => {
        sec.classList.add('hidden');
    });
    document.getElementById(secao).classList.remove('hidden');
}

const modal = document.getElementById('modal-editar-perfil');
const abrir = document.getElementById('modal-abrir-edicao');
const fechar = document.getElementById("modal-cancelar-edicao");

abrir.onclick = function() {
    modal.style.display = "flex";
}

fechar.onclick = function() {
    modal.style.display = "none";
}