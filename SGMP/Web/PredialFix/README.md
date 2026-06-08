# SGMP — Sistema de Gestão de Manutenção Predial

Sistema web para gestão de chamados de manutenção predial, desenvolvido como projeto acadêmico (grupo 5 — SENAI).

## Tecnologias

- PHP 8.2+ / Laravel 12
- MySQL (ou SQLite para desenvolvimento)
- Blade + CSS/JS estáticos em `public/`

## Instalação

```bash
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

Acesse `http://localhost:8000`.

## Usuários padrão (após seed)

| Perfil      | E-mail                  | Senha       |
|-------------|-------------------------|-------------|
| Admin       | admin@sgmp.local        | admin1234   |
| Gerente     | gerente@sgmp.local      | gerente123  |
| Funcionário | funcionario@sgmp.local  | func1234    |

## Perfis de acesso

| Tipo         | Permissões principais                                      |
|--------------|------------------------------------------------------------|
| Solicitante  | Abrir chamados e acompanhar os próprios                    |
| Funcionário  | Ver chamados atribuídos e atualizar status                 |
| Gerente      | Atribuir chamados a funcionários e atualizar status        |
| Admin        | Gerenciar usuários, chamados e todas as funções anteriores |

## Funcionalidades

- Cadastro e login de usuários
- Abertura e listagem de chamados com filtros
- Atribuição de responsáveis (gerente/admin)
- Atualização de status dos chamados
- Painel com estatísticas resumidas
- Edição de perfil do usuário logado
- Controle de acessos (admin)
