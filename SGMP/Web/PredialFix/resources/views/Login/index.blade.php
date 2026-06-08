<!doctype html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SGMP — Login</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@400;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/auth.css" />
</head>

<body>
  <header id="separacoes1">
    <img id="logo" src="Imagens/senai.png" alt="Logo SENAI" />
    <p class="mulish">Sistema de gestão<br>de manutenção predial</p>
    <nav class="btns-nav">
      <a href="/login" class="btn-nav mulish" id="btn-nav1">Entrar</a>
      <a href="/cadastro" class="btn-nav mulish" id="btn-nav2">Cadastrar</a>
    </nav>
  </header>

  <main id="separacoes2">
    <div class="auth-box">
      <h1 class="auth-box__title mulish">Acesse sua conta</h1>

      @if(session('success'))
      <div class="alert-success mulish">{{ session('success') }}</div>
      @endif

      <form method="POST" action="/login">
        @csrf
        <div class="form-group">
          <label class="mulish" for="email-lgn">E-mail</label>
          <input type="email" name="email" id="email-lgn" class="form-input mulish"
            placeholder="seu@email.com" value="{{ old('email') }}" required />
          @error('email')<span class="error-msg mulish">{{ $message }}</span>@enderror
        </div>

        <div class="form-group">
          <label class="mulish" for="senha-lgn">Senha</label>
          <input type="password" name="password" id="senha-lgn" class="form-input mulish"
            placeholder="Digite sua senha" required />
        </div>

        <button type="submit" class="btn-submit mulish">Conectar-se</button>

        <div class="auth-links">
          <a href="/cadastro" class="mulish">Não possui uma conta?</a>
          <span class="mulish" title="Entre em contato com o administrador">Esqueceu sua senha?</span>
        </div>
      </form>
    </div>
  </main>

  <footer id="separacoes3">
    <p class="mulish">&copy; {{ date('Y') }} — Todos os direitos reservados ao grupo 5</p>
  </footer>
</body>

</html>
