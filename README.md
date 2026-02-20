# 🏢 Gestão Predial 
### API de Gestão de Manutenção Predial — SENAI

> Plataforma de chamados para **controle, organização e transparência** da manutenção predial.

🔗 **Quadro do Projeto no Trello:**  
👉 [https://trello.com/b/seu-quadro-predialfix](https://trello.com/invite/b/69989460761b3d1ba6397f2c/ATTI2aceaed68ca2775c4167c82ebaed9b821CFCC419/gestao-predial)

---

## 📌 Visão Geral

O **PredialFix** é uma **API RESTful desenvolvida em Laravel** para gerenciar solicitações de manutenção predial de forma eficiente.

### 🚫 Problemas resolvidos pelo sistema:

- ❌ Falta de controle dos chamados  
- ❌ Demora no atendimento  
- ❌ Ausência de histórico técnico  
- ❌ Pouca transparência para usuários  

✅ Cada chamado pode ser acompanhado **do início até a conclusão**.

---

## 🎯 Objetivo do Projeto

Criar um **Back-End robusto e seguro** para:

- ✔ Organizar chamados de manutenção  
- ✔ Priorizar atendimentos  
- ✔ Controlar usuários por nível de acesso  
- ✔ Manter histórico por local  
- ✔ Simular notificações de progresso  

---

## 🛠 Tecnologias Utilizadas

- **PHP 8+**  
- **Laravel Framework**  
- **MySQL**  
- **Eloquent ORM**  
- **API REST (JSON)**  
- **Request Validation**  
- **Laravel Sanctum / JWT**

---

## 👥 Perfis de Usuário

| Perfil | Permissões |
|-------|-----------|
| **Usuário** | Abrir chamados e acompanhar status |
| **Responsável Técnico** | Atualizar e concluir chamados |

---

## 🔄 Fluxo de Atendimento
```text
📝 Aberto
   ↓
🔍 Em Análise
   ↓
🛠 Em Execução
   ↓
✅ Concluído


---

## 📋 Funcionalidades

### 👤 Gestão de Usuários
- Cadastro e login  
- Controle de permissões  

### 🧾 Abertura de Chamados
- Tipo (Elétrica, Hidráulica, Outros)  
- Descrição do problema  
- Local da ocorrência  

### 🔁 Atualização de Status
- Workflow padronizado  

### 📍 Histórico por Local
- Consulta de serviços anteriores  

### 🔔 Notificações
- Progresso do chamado (simulado)

---

## 📡 Principais Endpoints

### 🔐 Autenticação

| Método | Rota | Função |
|-------|------|-------|
| POST | `/api/register` | Criar usuário |
| POST | `/api/login` | Login |

### 🧾 Chamados

| Método | Rota | Função |
|-------|------|-------|
| POST | `/api/tickets` | Abrir chamado |
| GET | `/api/tickets` | Listar chamados |
| GET | `/api/tickets/{id}` | Detalhar chamado |
| PUT | `/api/tickets/{id}/status` | Atualizar status |
| GET | `/api/history/{local}` | Histórico por local |

---

## 🗃 Banco de Dados (Resumo)

### 📌 users

| Campo | Tipo |
|------|-----|
| id | bigint |
| name | string |
| email | string |
| password | string |
| role | enum |

### 📌 tickets

| Campo | Tipo |
|------|-----|
| id | bigint |
| type | string |
| description | text |
| location | string |
| status | string |
| user_id | foreign key |
| created_at | timestamp |

---

## ⚙️ Como Executar o Projeto

```bash
git clone https://github.com/seu-usuario/predialfix.git
cd predialfix
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
