🏢 PredialFix — API de Gestão de Manutenção Predial

Plataforma de chamados para controle, organização e transparência da manutenção predial do SENAI

📌 Visão Geral

O PredialFix é uma API RESTful desenvolvida em Laravel para gerenciar solicitações de manutenção predial.

O sistema resolve:

❌ Falta de controle dos chamados

❌ Demora no atendimento

❌ Ausência de histórico técnico

❌ Pouca transparência para usuários

Cada chamado pode ser acompanhado do início até a conclusão.

🎯 Objetivo do Projeto

Criar um Back-End robusto e seguro para:

✅ Organizar chamados de manutenção

✅ Priorizar atendimentos

✅ Controlar usuários por nível

✅ Manter histórico por local

✅ Simular notificações de progresso

🛠 Tecnologias Utilizadas

PHP 8+

Laravel

MySQL

Eloquent ORM

API REST (JSON)

Request Validation

Laravel Sanctum/JWT

👥 Perfis de Usuário
Perfil	Permissões
Usuário	Abrir chamados e acompanhar status
Responsável Técnico	Atualizar e concluir chamados
🔄 Fluxo de Atendimento
Aberto → Em Análise → Em Execução → Concluído
📋 Funcionalidades
Gestão de Usuários

Cadastro e login

Controle de permissões

Abertura de Chamados

Tipo (Elétrica, Hidráulica, Outros)

Descrição

Local

Atualização de Status

Workflow padronizado

Histórico por Local

Consulta de serviços anteriores

Notificações

Progresso do chamado (simulado)

📡 Principais Endpoints
Autenticação
Método	Rota	Função
POST	/api/register	Criar usuário
POST	/api/login	Login
Chamados
Método	Rota	Função
POST	/api/tickets	Abrir chamado
GET	/api/tickets	Listar
GET	/api/tickets/{id}	Detalhar
PUT	/api/tickets/{id}/status	Atualizar status
GET	/api/history/{local}	Histórico
🗃 Banco de Dados (Resumo)
users
Campo	Tipo
id	bigint
name	string
email	string
password	string
role	enum
tickets
Campo	Tipo
id	bigint
type	string
description	text
location	string
status	string
user_id	foreign key
created_at	timestamp
⚙️ Como Executar
git clone https://github.com/seu-usuario/predialfix.git
cd predialfix
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
📄 Boas Práticas

API RESTful

Arquitetura MVC

Validação de dados

ORM Eloquent

Autenticação segura

🚀 Evoluções Futuras

Upload de imagens

Sistema de prioridade

Dashboard administrativo

Notificações em tempo real

Relatórios técnicos

📦 Entrega

Repositório GitHub

README documentado

Banco estruturado

API funcional

🏫 Projeto Acadêmico — SENAI

Sistema desenvolvido para modernizar a gestão de manutenção predial.
