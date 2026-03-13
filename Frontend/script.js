let senha_lgn=document.getElementById("senha-lgn");
let label_senha_lgn=document.getElementById("label-senha-lgn");

let email_lgn=document.getElementById("email-lgn");
let label_email_lgn=document.getElementById("label-email-lgn");

let senha=false;
let email=false;

senha_lgn.addEventListener("focus",()=>mostrarlabel('senha'));
email_lgn.addEventListener("focus",()=>mostrarlabel('email'));
senha_lgn.addEventListener("blur",()=>mostrarlabel('senha'));
email_lgn.addEventListener("blur",()=>mostrarlabel('email'));


function mostrarlabel(campo){
    if(campo=='senha' && senha==false){
        senha=true;
        label_senha_lgn.classList.remove("oculto");
        senha_lgn.placeholder="";
    }else if(campo=='senha' && senha==true){
        senha=false;
        label_senha_lgn.classList.add("oculto");
        senha_lgn.placeholder="Digite sua senha";
    }else if(campo=="email" && email==false){
        email=true;
        label_email_lgn.classList.remove("oculto");
        email_lgn.placeholder="";
    }else{
        email=false;
        label_email_lgn.classList.add("oculto");
        email_lgn.placeholder="Digite seu e-mail"
    }
}
