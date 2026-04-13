<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/Login/style.css" />
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
        <a href="/login" class="btn-nav mulish" id="btn-nav1">Entrar</a>
        <a href="/criar" class="btn-nav mulish" id="btn-nav2">Cadastrar</a>
      </div>
    </div>
    <div id="separacoes2">
      <div class="login">
        <div class="texto-login">
          <p class="mulish">Acesse sua conta:</p>
        </div>
        <form class="form-login">
          <label class="mulish" for="email-lgn" id="label-email-lgn"
            >E-mail:</label
          >
          <input
            type="text"
            name="e-mail"
            id="email-lgn"
            class="input-lgn mulish"
            placeholder="Digite seu e-mail"
          />
          <label class="mulish" for="senha-lgn" id="label-senha-lgn"
            >Senha:</label
          >
          <input
            type="password"
            name="senha"
            id="senha-lgn"
            class="input-lgn mulish"
            placeholder="Digite sua senha"
          />
          <button type="submit" class="mulish" id="conectar-btn">
            Conectar-se
          </button>
          <div id="extras-lgn">
            <a id="cadastrar-a-lgn" href="/cadastro"
              >Não possui uma conta?</a
            >
            <a id="esqueceu-a-lgn" href="esqueceu.html">Esqueceu sua senha?</a>
          </div>
        </form>
      </div>
    </div>
    <div id="separacoes3">
      <p class="mulish">&copy;Todos os direitos reservados ao grupo 5</p>
    </div>

    <script src="js/login.js"></script>
  </body>
</html>
