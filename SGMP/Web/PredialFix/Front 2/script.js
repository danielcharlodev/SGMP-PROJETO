const modal = document.getElementById('modal-editar-perfil');
const abrir = document.getElementById('modal-abrir-edicao');
const fechar = document.getElementById("modal-cancelar-edicao");

abrir.onclick = function() {
    modal.style.display = "flex";
}

fechar.onclick = function() {
    modal.style.display = "none";
}