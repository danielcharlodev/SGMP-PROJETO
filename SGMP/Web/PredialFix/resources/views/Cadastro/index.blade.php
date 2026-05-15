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
    rel="stylesheet" />
  <link
    href="https://fonts.googleapis.com/css2?family=Iosevka+Charon+Mono:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&family=Mulish:ital,wght@0,200..1000;1,200..1000&family=SN+Pro:ital,wght@0,200..900;1,200..900&display=swap"
    rel="stylesheet" />
</head>

<body>
  <div id="separacoes1">
    <img id="logo" src="Imagens/senai.png" />
    <p class="mulish">Sistema de gestão <br />de manutenção predial</p>
    <div class="btns-nav">
      <a href="/login" class="btn-nav mulish" id="btn-nav1">Entrar</a>
      <a href="/cadastro" class="btn-nav mulish" id="btn-nav2">Cadastrar</a>
    </div>
  </div>
  <div id="separacoes2">
    <div class="cadastro">
      <div class="texto-cadastro">
        <p class="mulish">Crie sua conta:</p>
      </div>
      <div class="errors-container">
        @error('name')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('cpf')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('email')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('telefone')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('endereco')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('password')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
        @error('password_confirmation')
        <span class="error-msg mulish">{{ $message }}</span>
        @enderror
      </div>
      <form class="form-cadastro" method="POST" action="/cadastro">
        @csrf
        <label class="mulish label-email-cdt" for="nome_cdt">Nome Completo:</label>
        <input
          type="text"
          name="name"
          id="nome_cdt"
          class="input-cdt mulish"
          placeholder="Digite seu nome" />

        <label class="mulish label-email-cdt" for="cpf_cdt">CPF:</label>
        <input
          type="text"
          name="cpf"
          id="cpf_cdt"
          class="input-cdt mulish"
          placeholder="Digite seu CPF" />

        <label class="mulish label-email-cdt" for="email_cdt">E-mail:</label>
        <input
          type="text"
          name="email"
          id="email_cdt"
          class="input-cdt mulish"
          placeholder="Digite seu e-mail"
          autocomplete="off" />

        <label class="mulish label-telefone-cdt" for="telefone_cdt">Telefone:</label>
        <input
          type="text"
          name="telefone"
          id="telefone_cdt"
          class="input-cdt mulish"
          placeholder="Digite seu telefone" />

        <label class="mulish label-endereco-cdt" for="endereco_cdt">Endereço:</label>
        <input
          type="text"
          name="endereco"
          id="endereco_cdt"
          class="input-cdt mulish"
          placeholder="Digite seu endereço" />

        <label class="mulish label-senha-cdt" for="senha_cdt">Senha:</label>
        <input
          type="password"
          name="password"
          id="senha_cdt"
          class="input-cdt mulish"
          placeholder="Digite sua senha"
          autocomplete="off" />

        <label class="mulish label-senha-cdt" for="confirmar_senha_cdt">Confirmar senha:</label>
        <input
          type="password"
          name="password_confirmation"
          id="confirmar_senha_cdt"
          class="input-cdt mulish"
          placeholder="Digite sua senha" />

        <button type="submit" class="mulish" class="conectar-btn">
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

  <script src="js/cadastro/cadastro.js"></script>
</body>

</html>