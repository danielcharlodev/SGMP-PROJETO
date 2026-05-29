# PredialFix — SGMP Mobile

Aplicativo Flutter de **gestão predial** (chamados de manutenção) com três perfis de usuário, filtros e bloqueio por mau uso.

## Perfis

| Perfil | E-mail demo | Senha |
|--------|-------------|-------|
| Aluno / Funcionário | `aluno@senai.com` | `123456` |
| Responsável técnico | `tecnico@senai.com` | `123456` |
| Administrador | `admin@senai.com` | `123456` |

### Usuário comum
- Abrir chamados (título, descrição, local, tipo, prioridade)
- Acompanhar **apenas os próprios** chamados (filtro automático)
- Usuário bloqueado não consegue entrar nem abrir chamados

### Técnico
- Ver todos os chamados com filtros
- Filtro padrão: **Em aberto** + **Em execução**
- Iniciar execução, finalizar atendimento, registrar observações

### Administrador
- Tudo do técnico + gestão de usuários
- Alterar permissões (papel)
- Bloquear / desbloquear usuários
- Marcar chamado como **trote** (após 2 trotes o autor é bloqueado automaticamente)

## Filtros (simulam consulta à API)

- Status do chamado  
- Tipo de problema (elétrica, hidráulica, etc.)  
- Local (ex.: Bloco A)  
- Usuário que abriu (técnico/admin)  
- Prioridade  
- Busca por texto  

Os filtros são aplicados em `TicketService.fetchTickets()` — ao integrar com backend, envie os mesmos parâmetros na requisição HTTP.

## Executar

```bash
cd SGMP/Mobile/predialfix
flutter pub get
flutter run
```

## Estrutura

```
lib/
  app.dart
  main.dart
  core/          # tema e constantes
  models/        # usuário, chamado, filtros, enums
  services/      # auth, chamados, usuários (mock)
  screens/       # login, home, chamados, admin
  widgets/       # cards, filtros, app bar
```

## Integração com API

Substitua `MockDatabase` e os métodos em `AuthService`, `TicketService` e `UserService` por chamadas `http`/`dio` ao seu backend, mantendo os modelos e `TicketFilter` como contrato de query.
