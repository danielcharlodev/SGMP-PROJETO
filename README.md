🏢 PredialFix — API de Gestão de Manutenção Predial

Plataforma de chamados para controle, organização e transparência da manutenção predial do SENAI

📌 Visão Geral

O PredialFix é uma API RESTful desenvolvida em Laravel para gerenciar solicitações de manutenção predial em instituições como o SENAI.

O sistema resolve problemas como:

❌ Falta de controle dos chamados

❌ Demora no atendimento

❌ Ausência de histórico técnico

❌ Baixa transparência para usuários

Com o PredialFix, cada chamado é acompanhado do início até a resolução.

🎯 Objetivo do Projeto

Criar um Back-End robusto e seguro capaz de:

✔ Organizar chamados de manutenção
✔ Priorizar atendimentos
✔ Controlar usuários por nível de acesso
✔ Manter histórico por local
✔ Simular notificações de progresso

🛠 Tecnologias Utilizadas

PHP 8+

Laravel Framework

MySQL

Eloquent ORM

API REST (JSON)

Request Validation

Laravel Sanctum/JWT

👥 Perfis de Usuário
Perfil	Permissões
👤 Usuário	Abrir chamados e acompanhar status
🧑‍🔧 Responsável Técnico	Atualizar e concluir chamados
🔄 Fluxo de Atendimento
Aberto → Em Análise → Em Execução → Concluído
📋 Funcionalidades Principais
✅ Gestão de Usuários

Cadastro

Login

Controle de permissões

✅ Abertura de Chamados

Tipo do problema (Elétrica, Hidráulica, Outros)

Descrição detalhada

Local da ocorrência

✅ Atualização de Status

Workflow padronizado

✅ Histórico por Local

Consulta de serviços anteriores

✅ Notificações (simuladas)

Progresso do chamado

📡 Endpoints Essenciais
🔐 Autenticação
Método	Rota	Função
POST	/api/register	Criar usuário
POST	/api/login	Autenticar
📝 Chamados
Método	Rota	Função
POST	/api/tickets	Abrir chamado
GET	/api/tickets	Listar chamados
GET	/api/tickets/{id}	Detalhar
PUT	/api/tickets/{id}/status	Atualizar status
GET	/api/history/{local}	Histórico
🗃 Estrutura do Banco de Dados (Resumo)
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
⚙️ Como Executar o Projeto
git clone https://github.com/seu-usuario/predialfix.git
cd predialfix
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
📄 Boas Práticas Aplicadas

✅ Arquitetura MVC

✅ API RESTful

✅ Validação rigorosa

✅ ORM Eloquent

✅ Autenticação segura

✅ Código organizado

🚀 Possíveis Evoluções Futuras

📸 Upload de fotos dos problemas

⏱ Sistema de prioridade automática

📊 Dashboard administrativo

🔔 Notificações em tempo real

📑 Relatórios técnicos

📦 Entrega do Projeto

✔ Repositório GitHub
✔ README documentado
✔ Banco estruturado
✔ Endpoints funcionais

🏫 Contexto Acadêmico

Projeto desenvolvido como solução tecnológica para a gestão de manutenção predial do SENAI.
