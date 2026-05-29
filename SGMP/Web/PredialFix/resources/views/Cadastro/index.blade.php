<!doctype html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SGMP - Cadastro</title>
  <link rel="stylesheet" href="css/Cadastro/style.css" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet" />
</head>

<body>
  <!-- HEADER -->
  <div id="separacoes1">
    <img id="logo" src="Imagens/senai.png" />
    <p class="mulish">Sistema de gestão <br />de manutenção predial</p>
    <div class="btns-nav">
      <a href="/login" class="btn-nav mulish" id="btn-nav1">Entrar</a>
      <a href="/cadastro" class="btn-nav mulish" id="btn-nav2">Cadastrar</a>
    </div>
  </div>

  <!-- CONTENT -->
  <div id="separacoes2">
    <div class="cadastro">

      <!-- STEPPER -->
      <div class="stepper">
        <div class="step active" id="step-dot-1">
          <div class="step__circle">
            <span class="step__num">1</span>
            <svg class="step__check" viewBox="0 0 16 16" fill="none">
              <path d="M3 8l3.5 3.5L13 5" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </div>
          <span class="step__label mulish">Dados</span>
        </div>
        <div class="step__line" id="line-1"></div>
        <div class="step" id="step-dot-2">
          <div class="step__circle">
            <span class="step__num">2</span>
            <svg class="step__check" viewBox="0 0 16 16" fill="none">
              <path d="M3 8l3.5 3.5L13 5" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </div>
          <span class="step__label mulish">Endereço</span>
        </div>
        <div class="step__line" id="line-2"></div>
        <div class="step" id="step-dot-3">
          <div class="step__circle">
            <span class="step__num">3</span>
            <svg class="step__check" viewBox="0 0 16 16" fill="none">
              <path d="M3 8l3.5 3.5L13 5" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </div>
          <span class="step__label mulish">Senha</span>
        </div>
      </div>

      <!-- ERRORS -->
      <div class="errors-container">
        @error('name')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('cpf')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('email')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('telefone')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('endereco')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('password')<span class="error-msg mulish">{{ $message }}</span>@enderror
        @error('password_confirmation')<span class="error-msg mulish">{{ $message }}</span>@enderror
      </div>

      <form class="form-cadastro" method="POST" action="/cadastro" id="form-cdt">
        @csrf

        <!-- PASSO 1: DADOS -->
        <div class="form-step" id="form-step-1">
          <p class="step-title mulish">Dados pessoais</p>

          <div class="form-group">
            <label class="mulish" for="nome_cdt">Nome completo</label>
            <input type="text" name="name" id="nome_cdt" class="input-cdt mulish"
              placeholder="Digite seu nome completo" value="{{ old('name') }}" />
          </div>

          <div class="form-group">
            <label class="mulish" for="cpf_cdt">CPF</label>
            <input type="text" name="cpf" id="cpf_cdt" class="input-cdt mulish"
              placeholder="000.000.000-00" value="{{ old('cpf') }}" maxlength="14" />
          </div>

          <div class="form-group">
            <label class="mulish" for="email_cdt">E-mail</label>
            <input type="email" name="email" id="email_cdt" class="input-cdt mulish"
              placeholder="seu@email.com" value="{{ old('email') }}" autocomplete="off" />
          </div>

          <div class="form-group">
            <label class="mulish" for="telefone_cdt">Telefone</label>
            <input type="text" name="telefone" id="telefone_cdt" class="input-cdt mulish"
              placeholder="(00) 00000-0000" value="{{ old('telefone') }}" maxlength="15" />
          </div>

          <div class="form-group">
            <label for="imagem-cadastro" class="mulish">Imagem</label>
            <input type="file" id="imagem-cadastro">
          </div>

          <button type="button" class="btn-proximo mulish" onclick="goToStep(2)">
            Próximo <span class="btn-arrow">→</span>
          </button>

        </div>

        <!-- PASSO 2: ENDEREÇO -->
        <div class="form-step hidden" id="form-step-2">
          <p class="step-title mulish">Endereço</p>

          <div class="form-group">
            <label class="mulish" for="cep_cdt">CEP</label>
            <input type="text" name="cep" id="cep_cdt" class="input-cdt mulish"
              placeholder="00000-000" maxlength="9" />
          </div>

          <div class="form-row">
            <div class="form-group form-group--grow">
              <label class="mulish" for="rua_cdt">Rua</label>
              <input type="text" name="rua" id="rua_cdt" class="input-cdt mulish" placeholder="Nome da rua" />
            </div>
            <div class="form-group form-group--short">
              <label class="mulish" for="num_cdt">Número</label>
              <input type="text" name="numero" id="num_cdt" class="input-cdt mulish" placeholder="Nº" />
            </div>
          </div>

          <div class="form-group">
            <label class="mulish" for="bairro_cdt">Bairro</label>
            <input type="text" name="bairro" id="bairro_cdt" class="input-cdt mulish" placeholder="Bairro" />
          </div>

          <div class="form-row">
            <div class="form-group form-group--grow">
              <label class="mulish" for="cidade_cdt">Cidade</label>
              <input type="text" name="cidade" id="cidade_cdt" class="input-cdt mulish" placeholder="Cidade" />
            </div>
            <div class="form-group form-group--short">
              <label class="mulish" for="uf_cdt">UF</label>
              <input type="text" name="uf" id="uf_cdt" class="input-cdt mulish" placeholder="SP" maxlength="2" />
            </div>
          </div>

          <!-- campo hidden para compatibilidade com backend -->
          <input type="hidden" name="endereco" id="endereco_hidden" />

          <div class="btn-group">
            <button type="button" class="btn-voltar mulish" onclick="goToStep(1)">
              <span class="btn-arrow">←</span> Voltar
            </button>
            <button type="button" class="btn-proximo mulish" onclick="goToStep(3)">
              Próximo <span class="btn-arrow">→</span>
            </button>
          </div>
        </div>

        <!-- PASSO 3: SENHA -->
        <div class="form-step hidden" id="form-step-3">
          <p class="step-title mulish">Crie sua senha</p>

          <div class="form-group">
            <label class="mulish" for="senha_cdt">Senha</label>
            <div class="input-wrapper">
              <input type="password" name="password" id="senha_cdt" class="input-cdt mulish"
                placeholder="Mínimo 8 caracteres" autocomplete="off" />
              <button type="button" class="toggle-pw" onclick="togglePw('senha_cdt', this)" tabindex="-1">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                  <circle cx="12" cy="12" r="3" />
                </svg>
              </button>
            </div>
          </div>

          <div class="pw-strength">
            <div class="pw-strength__bar">
              <div class="pw-strength__fill" id="pw-fill"></div>
            </div>
            <span class="pw-strength__label mulish" id="pw-label"></span>
          </div>

          <div class="form-group">
            <label class="mulish" for="confirmar_senha_cdt">Confirmar senha</label>
            <div class="input-wrapper">
              <input type="password" name="password_confirmation" id="confirmar_senha_cdt" class="input-cdt mulish"
                placeholder="Repita a senha" />
              <button type="button" class="toggle-pw" onclick="togglePw('confirmar_senha_cdt', this)" tabindex="-1">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                  <circle cx="12" cy="12" r="3" />
                </svg>
              </button>
            </div>
          </div>

          <div class="btn-group">
            <button type="button" class="btn-voltar mulish" onclick="goToStep(2)">
              <span class="btn-arrow">←</span> Voltar
            </button>
            <button type="submit" class="btn-proximo mulish" onclick="buildEndereco()">
              Criar conta ✓
            </button>
          </div>

          <div id="extras-cdt">
            <a href="/login" class="mulish">Já possui uma conta?</a>
          </div>
        </div>

      </form>
    </div>
  </div>

  <!-- FOOTER -->
  <div id="separacoes3">
    <p class="mulish">&copy; Todos os direitos reservados ao grupo 5</p>
  </div>

  <script src="js/Cadastro/cadastro.js"></script>
</body>

</html>