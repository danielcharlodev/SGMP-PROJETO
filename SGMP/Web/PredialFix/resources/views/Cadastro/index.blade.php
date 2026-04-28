<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SGMP - Cadastro</title>
    <link rel="stylesheet" href="css/Cadastro/style.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Iosevka+Charon+Mono:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&family=SN+Pro:ital,wght@0,200..900;1,200..900&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Iosevka+Charon+Mono:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&family=Mulish:ital,wght@0,200..1000;1,200..1000&family=SN+Pro:ital,wght@0,200..900;1,200..900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <div id="separacoes1">
      <img id="logo" src="Imagens/senai.png" />
      <p class="mulish">Sistema de gestão <br />de manutenção predial</p>
      <div class="btns-nav">
        <a href="/cadastro" class="btn-nav mulish" id="btn-nav1">Cadastrar</a>
        <a href="/login" class="btn-nav mulish" id="btn-nav2">Entrar</a>
      </div>
    </div>
    <div id="separacoes2">
      <div class="cadastro">
        <div class="texto-cadastro">
          <p class="mulish">Crie sua conta:</p>
        </div>
        <form class="form-cadastro">
            <label class="mulish" for="email-cdt" id="label-email-cdt"
            >Nome Completo:</label
          >
          <input
            type="text"
            name="nome"
            id="nome-cdt"
            class="input-cdt mulish"
            placeholder="Digite seu nome"
          />
          <label class="mulish" for="email-cdt" id="label-email-cdt"
            >CPF:</label
          >
          <input
            type="text"
            name="cpf"
            id="cpf-cdt"
            class="input-cdt mulish"
            placeholder="Digite seu CPF"
          />
          <label class="mulish" for="email-cdt" id="label-email-cdt"
            >E-mail:</label
          >
          <input
            type="text"
            name="e-mail"
            id="email-cdt"
            class="input-cdt mulish"
            placeholder="Digite seu e-mail"
          />
          <label class="mulish" for="telefone-cdt" id="label-telefone-cdt"
            >Telefone:</label
          >
          <input
            type="text"
            name="telefone"
            id="telefone-cdt"
            class="input-cdt mulish"
            placeholder="Digite seu telefone"
          />
          <label class="mulish" for="endereco-cdt" id="label-endereco-cdt"
            >Endereço:</label
          >
          <input
            type="text"
            name="endereco"
            id="endereco-cdt"
            class="input-cdt mulish"
            placeholder="Digite seu endereço"
          />
          <label class="mulish" for="senha-cdt" id="label-senha-cdt"
            >Senha:</label
          >
          <input
            type="password"
            name="senha"
            id="senha-cdt"
            class="input-cdt mulish"
            placeholder="Digite sua senha"
          />

          <!-- ainda tem q mudar aqui -->
          <label class="mulish" for="senha-cdt" id="label-senha-cdt"
            >Confirmar senha:</label
          >
          <input
            type="password"
            name="confirmar"
            id="confirmar-senha-cdt"
            class="input-cdt mulish"
            placeholder="Digite sua senha"
          />


          <button type="submit" class="mulish" id="conectar-btn">
            Criar conta
          </button>
          <div id="extras-cdt">
            <a id="cadastrar-a-cdt" href="/login">Já possui uma conta?</a>
          </div>
        </form>
      </div>
    </div>
    <div id="separacoes3">
      <p class="mulish">&copy;Todos os direitos reservados ao grupo 5</p>
    </div>

    <script src="js/cadastro.js"></script>
  </body>
</html>