🏢 PredialFix — API de Gestão de Manutenção Predial

Plataforma de chamados para controle e transparência na manutenção predial do SENAI.

📌 Visão Geral

O PredialFix é uma API RESTful desenvolvida em Laravel para gerenciar solicitações de manutenção predial em instituições como o SENAI.

O sistema resolve problemas como:

❌ Falta de controle de chamados

❌ Demora no atendimento

❌ Ausência de histórico técnico

❌ Falta de transparência para usuários

Com o PredialFix é possível acompanhar todo o fluxo de manutenção — da abertura à conclusão.

🎯 Objetivo do Projeto

Criar uma infraestrutura Back-End robusta capaz de:

✔ Organizar chamados de manutenção
✔ Priorizar atendimentos
✔ Controlar usuários por nível
✔ Manter histórico por local
✔ Simular notificações de progresso

🛠 Tecnologias

PHP 8+

Laravel

MySQL

Eloquent ORM

API REST (JSON)

Request Validation

Laravel Sanctum/JWT

👥 Perfis de Usuário
Perfil	Ações
👤 Usuário	Criar chamados e acompanhar status
🧑‍🔧 Responsável	Gerenciar e atualizar chamados
🔄 Fluxo de Atendimento
Aberto → Em Análise → Em Execução → Concluído
📋 Funcionalidades
✅ Gestão de Usuários

Cadastro e autenticação

Controle de permissões

✅ Abertura de Chamados

Tipo do problema

Descrição

Local

✅ Atualização de Status

Workflow padronizado

✅ Histórico por Local

Consulta de serviços anteriores

✅ Notificações (simuladas)

Progresso do chamado

📡 Endpoints Principais
🔐 Autenticação
Método	Rota	Função
POST	/api/register	Criar conta
POST	/api/login	Autenticar
📝 Chamados
Método	Rota	Função
POST	/api/tickets	Abrir chamado
GET	/api/tickets	Listar
GET	/api/tickets/{id}	Detalhar
PUT	/api/tickets/{id}/status	Atualizar status
GET	/api/history/{local}	Histórico
🗃 Banco de Dados (Resumo)
📁 users
Campo	Tipo
id	bigint
name	string
email	string
password	string
role	enum
📁 tickets
Campo	Tipo
id	bigint
type	string
description	text
location	string
status	string
user_id	foreign key
created_at	timestamp
⚙️ Como Rodar o Projeto
git clone https://github.com/seu-usuario/predialfix.git
cd predialfix
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
📄 Padrões Aplicados

API RESTful

MVC Laravel

Validação de dados

ORM Eloquent

Autenticação segura

Código organizado

🚀 Possíveis Evoluções

📸 Upload de imagens do problema

⏱ Sistema de prioridade

📊 Dashboard administrativo

🔔 Notificações em tempo real

📑 Relatórios técnicos

📦 Entrega

✔ Repositório GitHub
✔ README documentado
✔ Migrations
✔ Controllers
✔ Rotas da API

🏫 Contexto Acadêmico

Projeto desenvolvido como solução para o controle de manutenção predial do SENAI.
