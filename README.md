# GestaoPredial-Projetos
🏢 PredialFix — Sistema de Gestão de Manutenção Predial (Back-End)
📌 Sobre o Projeto

O PredialFix é uma plataforma de chamados de manutenção predial desenvolvida para atender às demandas do SENAI, que lida diariamente com centenas de solicitações envolvendo:

Problemas elétricos

Manutenção hidráulica

Reparos estruturais diversos

Atualmente, a falta de transparência e o tempo de resposta são os principais problemas enfrentados por alunos e colaboradores.

Este projeto tem como foco o desenvolvimento do Back-End de uma API robusta, segura e escalável, responsável por:

✅ Organizar os chamados
✅ Priorizar atendimentos
✅ Registrar histórico de serviços
✅ Garantir transparência total do processo

🎯 Objetivo

Criar uma API RESTful em Laravel que permita:

Abertura de chamados de manutenção

Atualização de status pelos responsáveis técnicos

Consulta de histórico por local

Notificações de progresso

Controle de usuários com diferentes permissões

🛠 Tecnologias Utilizadas

PHP 8+

Laravel Framework

MySQL

Eloquent ORM

API RESTful (JSON)

Laravel Request Validation

Autenticação (JWT ou Laravel Sanctum)

👥 Tipos de Usuários
Tipo	Permissões
👤 Usuário	Abrir chamados, acompanhar status
🧑‍🔧 Responsável	Atualizar chamados, concluir serviços
📋 Funcionalidades
🔐 Gestão de Usuários

Cadastro e autenticação

Controle de níveis de acesso

📝 Abertura de Chamados

Tipo de problema (Elétrica, Hidráulica, Outros)

Descrição detalhada

Local da ocorrência

🔄 Workflow de Atendimento
Aberto → Em Análise → Em Execução → Concluído
📍 Histórico da Unidade

Consulta de serviços realizados por local ou área comum

🔔 Notificações (Simuladas)

Técnico a caminho

Serviço em execução

Chamado finalizado

📡 Estrutura da API (Exemplo de Endpoints)
🔑 Autenticação
Método	Rota	Descrição
POST	/api/register	Criar usuário
POST	/api/login	Login
📝 Chamados
Método	Rota	Ação
POST	/api/tickets	Abrir chamado
GET	/api/tickets	Listar chamados
GET	/api/tickets/{id}	Ver chamado
PUT	/api/tickets/{id}/status	Atualizar status
GET	/api/history/{local}	Histórico por local
🗃 Estrutura do Banco de Dados (Resumo)
📁 users

id

name

email

password

role (user/responsavel)

📁 tickets

id

type

description

location

status

user_id

created_at

⚙️ Requisitos do Sistema

PHP >= 8.0

Composer

MySQL

Laravel CLI

🚀 Como Executar o Projeto
git clone https://github.com/seu-usuario/predialfix.git
cd predialfix
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
📄 Boas Práticas Aplicadas

✔ API RESTful padronizada
✔ Validação rigorosa de dados
✔ Uso de ORM (Eloquent)
✔ Separação de responsabilidades
✔ Segurança nas rotas

📦 Entrega

O projeto será entregue via:

🔗 Repositório GitHub com:

Código-fonte completo

README.md documentado

Migrations do banco

Endpoints organizados

📚 Futuras Melhorias

Upload de fotos do problema

Sistema de prioridade automática

Dashboard administrativo

Relatórios mensais

Notificações em tempo real (WebSocket)

🏫 Projeto Acadêmico — SENAI

Sistema desenvolvido como proposta de solução para modernização da gestão de manutenção predial do SENAI.
