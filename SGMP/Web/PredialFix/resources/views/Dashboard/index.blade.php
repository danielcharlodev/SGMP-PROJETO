<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SGMP — Painel Administrativo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="css/Dashboard/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>

    @if(session('error'))
    <div class="toast toast-error">
        <i class="fa-solid fa-circle-exclamation"></i>
        <span>{{ session('error') }}</span>
    </div>
    @endif

    @if(session('success'))
    <div class="toast toast-success">
        <i class="fa-solid fa-circle-check"></i>
        <span>{{ session('success') }}</span>
    </div>
    @endif

    @if($errors->any())
    <div class="toast toast-error">
        <i class="fa-solid fa-circle-exclamation"></i>
        <div>
            <strong>Erro na operação</strong>
            <ul>
                @foreach($errors->all() as $error)
                <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    </div>
    @endif

    @php
        $user = auth()->user();
        $nameParts = explode(' ', trim($user->name));
        $userInitials = '';
        foreach ($nameParts as $part) {
            if ($part !== '') {
                $userInitials .= mb_substr($part, 0, 1);
            }
            if (mb_strlen($userInitials) >= 2) break;
        }
        if ($userInitials === '') $userInitials = 'US';
    @endphp

    <div class="layout">

        <aside class="sidebar">
            <div class="sidebar__top">
                <div class="sidebar__logo">
                    <img src="Imagens/senai.png" alt="Logo do Senai">
                </div>

                <nav class="sidebar__nav">
                    <button class="sidebar__button" type="button" onclick="trocarSecao('painel')">
                        <i class="fa-solid fa-house"></i>
                        <span>Home</span>
                    </button>

                    @if($user->tipo !== 'funcionario')
                    <button class="sidebar__button" type="button" onclick="trocarSecao('novo-chamado')">
                        <i class="fa-solid fa-plus"></i>
                        <span>Novo Chamado</span>
                    </button>
                    @endif

                    <button class="sidebar__button" type="button" onclick="trocarSecao('buscar-chamados')">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Buscar Chamados</span>
                    </button>

                    @if($user->tipo === 'admin')
                    <button class="sidebar__button" type="button" onclick="trocarSecao('controle-acessos')">
                        <i class="fa-solid fa-users-gear"></i>
                        <span>Controle de Acessos</span>
                    </button>
                    @endif

                    <form action="/logout" method="post">
                        @csrf
                        <button type="submit" class="sidebar__logout">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span>Sair</span>
                        </button>
                    </form>
                </nav>
            </div>

            <div class="sidebar__bottom">
                <button class="sidebar__button" type="button" onclick="trocarSecao('perfil')">
                    <i class="fa-solid fa-circle-user"></i>
                    <span>Perfil</span>
                </button>
            </div>
        </aside>

        <header class="header">
            <div class="header__user">
                <div class="header__avatar">{{ strtoupper($userInitials) }}</div>
                <div class="header__user-info">
                    <span class="header__user-name">{{ $user->name }}</span>
                    <span class="header__user-role">{{ $tipoLabels[$user->tipo] ?? ucfirst($user->tipo) }}</span>
                </div>
            </div>
            <h1 class="header__title">Painel Administrativo</h1>
            <button class="theme-toggle" id="theme-toggle" type="button" aria-label="Alternar tema">🌙</button>
        </header>

        <main class="content">

            <section class="section {{ session('active_section') ? 'hidden' : '' }}" id="painel">
                <div class="dash-welcome">
                    <div>
                        <p class="dash-welcome__greeting">Olá, {{ explode(' ', $user->name)[0] }} 👋</p>
                        <h2 class="dash-welcome__title">Visão geral dos chamados</h2>
                        <p class="dash-welcome__sub">Acompanhe o status das manutenções e tome decisões com base nos indicadores abaixo.</p>
                    </div>
                    @if($user->tipo !== 'funcionario')
                    <button type="button" class="btn-primary" onclick="trocarSecao('novo-chamado')">
                        <i class="fa-solid fa-plus"></i> Novo chamado
                    </button>
                    @endif
                </div>

                <div class="kpi-grid">
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--blue"><i class="fa-solid fa-ticket"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['total'] }}</span>
                            <span class="kpi-card__label">Total de chamados</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--yellow"><i class="fa-solid fa-clock"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['pendentes'] }}</span>
                            <span class="kpi-card__label">Pendentes</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--purple"><i class="fa-solid fa-screwdriver-wrench"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['em_andamento'] }}</span>
                            <span class="kpi-card__label">Em andamento</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--green"><i class="fa-solid fa-circle-check"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['finalizados'] }}</span>
                            <span class="kpi-card__label">Finalizados</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--red"><i class="fa-solid fa-chart-line"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['taxa_resolucao'] }}%</span>
                            <span class="kpi-card__label">Taxa de resolução</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--blue"><i class="fa-solid fa-calendar"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['mes_atual'] }}</span>
                            <span class="kpi-card__label">Abertos este mês</span>
                        </div>
                    </article>
                    @if($user->tipo === 'admin')
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--purple"><i class="fa-solid fa-users"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['usuarios'] }}</span>
                            <span class="kpi-card__label">Usuários cadastrados</span>
                        </div>
                    </article>
                    <article class="kpi-card">
                        <div class="kpi-card__icon kpi-card__icon--green"><i class="fa-solid fa-hard-hat"></i></div>
                        <div class="kpi-card__body">
                            <span class="kpi-card__value">{{ $stats['funcionarios'] }}</span>
                            <span class="kpi-card__label">Funcionários ativos</span>
                        </div>
                    </article>
                    @endif
                </div>

                <div class="dash-panels">
                    <div class="dash-panel">
                        <div class="dash-panel__header">
                            <h3><i class="fa-solid fa-list"></i> Chamados recentes</h3>
                            <button type="button" class="btn-link" onclick="trocarSecao('buscar-chamados')">Ver todos →</button>
                        </div>
                        @if($recentTickets->isNotEmpty())
                        <div class="dash-table-wrap">
                            <table class="dash-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Título</th>
                                        <th>Status</th>
                                        <th>Data</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($recentTickets as $rt)
                                    <tr>
                                        <td><span class="dash-table__code">#{{ $rt->number }}</span></td>
                                        <td>{{ \Illuminate\Support\Str::limit($rt->title, 40) }}</td>
                                        <td><span class="ticket-status ticket-status--{{ $rt->status }}">{{ $statusLabels[$rt->status] ?? $rt->status }}</span></td>
                                        <td class="dash-table__date">{{ $rt->created_at->format('d/m/Y') }}</td>
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                        @else
                        <div class="dash-empty">
                            <i class="fa-regular fa-folder-open"></i>
                            <p>Nenhum chamado registrado ainda.</p>
                        </div>
                        @endif
                    </div>

                    <div class="dash-panel">
                        <div class="dash-panel__header">
                            <h3><i class="fa-solid fa-chart-pie"></i> Por categoria</h3>
                        </div>
                        @php
                            $catTotal = max($stats['eletrica'] + $stats['infraestrutura'], 1);
                            $pctElet = round(($stats['eletrica'] / $catTotal) * 100);
                            $pctInfra = round(($stats['infraestrutura'] / $catTotal) * 100);
                        @endphp
                        <div class="category-bars">
                            <div class="category-bar">
                                <div class="category-bar__top">
                                    <span><i class="fa-solid fa-bolt"></i> Elétrica</span>
                                    <strong>{{ $stats['eletrica'] }} ({{ $pctElet }}%)</strong>
                                </div>
                                <div class="category-bar__track"><div class="category-bar__fill category-bar__fill--eletrica" style="width:{{ $pctElet }}%"></div></div>
                            </div>
                            <div class="category-bar">
                                <div class="category-bar__top">
                                    <span><i class="fa-solid fa-building"></i> Infraestrutura</span>
                                    <strong>{{ $stats['infraestrutura'] }} ({{ $pctInfra }}%)</strong>
                                </div>
                                <div class="category-bar__track"><div class="category-bar__fill category-bar__fill--infra" style="width:{{ $pctInfra }}%"></div></div>
                            </div>
                        </div>
                        @if($stats['aguardando'] > 0)
                        <div class="dash-alert">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                            <span>{{ $stats['aguardando'] }} chamado(s) aguardando material</span>
                        </div>
                        @endif
                    </div>
                </div>
            </section>

            <section class="section {{ session('active_section') === 'novo-chamado' ? '' : 'hidden' }}" id="novo-chamado">
                <div class="ticket-page">
                    <div class="ticket-intro">
                        <span class="ticket-badge">
                            <i class="fa-solid fa-plus"></i>
                            Novo chamado
                        </span>
                        <h2>Abrir chamado</h2>
                        <p>Informe o problema encontrado. Quanto mais detalhes você colocar, mais fácil será para a equipe resolver.</p>
                    </div>

                    <form class="ticket-card" method="POST" action="/new_ticket">
                        @csrf
                        <div class="form-group">
                            <label for="title">Título</label>
                            <input type="text" id="title" name="title" class="input"
                                placeholder="Ex: Lâmpada queimada no laboratório"
                                value="{{ old('title') }}" required>
                        </div>

                        <div class="form-group">
                            <label for="tag">Categoria</label>
                            <select id="tag" name="tag" class="input" required>
                                <option value="">Selecione uma categoria</option>
                                <option value="eletrica" {{ old('tag') == 'eletrica' ? 'selected' : '' }}>Elétrica</option>
                                <option value="infraestrutura" {{ old('tag') == 'infraestrutura' ? 'selected' : '' }}>Infraestrutura</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="priority">Prioridade</label>
                            <select id="priority" name="priority" class="input">
                                <option value="">Selecione uma prioridade</option>
                                <option value="minima" {{ old('priority') == 'minima' ? 'selected' : '' }}>Mínima</option>
                                <option value="muito_baixa" {{ old('priority') == 'muito_baixa' ? 'selected' : '' }}>Muito Baixa</option>
                                <option value="baixa" {{ old('priority') == 'baixa' ? 'selected' : '' }}>Baixa</option>
                                <option value="moderada" {{ old('priority') == 'moderada' ? 'selected' : '' }}>Moderada</option>
                                <option value="media_alta" {{ old('priority') == 'media_alta' ? 'selected' : '' }}>Média Alta</option>
                                <option value="alta" {{ old('priority') == 'alta' ? 'selected' : '' }}>Alta</option>
                                <option value="critica" {{ old('priority') == 'critica' ? 'selected' : '' }}>Crítica</option>
                                <option value="emergencial" {{ old('priority') == 'emergencial' ? 'selected' : '' }}>Emergencial</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="description">Descrição</label>
                            <textarea id="description" name="description" class="input textarea"
                                placeholder="Descreva o local, o problema e qualquer detalhe importante..."
                                required>{{ old('description') }}</textarea>
                        </div>

                        <div class="ticket-actions">
                            <button class="btn-secondary" type="reset">Limpar</button>
                            <button class="btn-primary" type="submit">
                                <i class="fa-solid fa-paper-plane"></i>
                                Enviar chamado
                            </button>
                        </div>
                    </form>
                </div>
            </section>

            <section class="section {{ session('active_section') === 'buscar-chamados' ? '' : 'hidden' }}" id="buscar-chamados">
                <div class="tickets-page">
                    <div class="tickets-intro">
                        <span class="tickets-badge">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            Chamados
                        </span>
                        <h2>Buscar chamados</h2>
                        <p>Consulte os chamados cadastrados no sistema, acompanhe o status e veja os detalhes de cada solicitação.</p>
                    </div>

                    <div class="tickets-toolbar">
                        <div class="tickets-search">
                            <i class="fa-solid fa-search"></i>
                            <input type="text" id="search-ticket" placeholder="Buscar por título, número ou categoria...">
                        </div>

                        <div class="tickets-filters">
                            <button class="ticket-filter active" type="button" data-filter="todos">Todos</button>
                            <button class="ticket-filter" type="button" data-filter="pendente">Pendentes</button>
                            <button class="ticket-filter" type="button" data-filter="em_analise">Em análise</button>
                            <button class="ticket-filter" type="button" data-filter="em_andamento">Em andamento</button>
                            <button class="ticket-filter" type="button" data-filter="aguardando_material">Aguardando material</button>
                            <button class="ticket-filter" type="button" data-filter="finalizado">Finalizados</button>
                        </div>
                    </div>

                    <div class="tickets-list">
                        @forelse($tickets as $ticket)
                        @php
                        $tagLabels = [
                            'eletrica' => 'Elétrica',
                            'infraestrutura' => 'Infraestrutura',
                        ];
                        $statusText = $statusLabels[$ticket->status] ?? $ticket->status;
                        $priorityText = $ticket->priority ? $priorityLabels[$ticket->priority] : 'Não definida';
                        $tagText = $tagLabels[$ticket->tag] ?? $ticket->tag;
                        $authorName = $ticket->author->name ?? 'Usuário';
                        $responsibleName = $ticket->responsible->name ?? 'Não atribuído';
                        $nameParts = explode(' ', trim($authorName));
                        $initials = '';
                        foreach ($nameParts as $part) {
                            if ($part !== '') $initials .= mb_substr($part, 0, 1);
                            if (mb_strlen($initials) >= 2) break;
                        }
                        if ($initials === '') $initials = 'US';
                        $searchText = strtolower(
                            $ticket->number . ' ' . $ticket->title . ' ' . $ticket->description . ' ' .
                            $tagText . ' ' . $statusText . ' ' . $priorityText . ' ' . $authorName . ' ' . $responsibleName
                        );
                        $canUpdateStatus = in_array($user->tipo, ['admin', 'gerente', 'funcionario'])
                            && ($user->tipo !== 'funcionario' || $ticket->responsible_id === $user->id);
                        @endphp

                        <article class="ticket-list-card" data-status="{{ $ticket->status }}" data-search="{{ $searchText }}">
                            <div class="ticket-list-card__top">
                                <div>
                                    <span class="ticket-code">#{{ $ticket->number }}</span>
                                    <span class="ticket-date">Aberto em {{ $ticket->created_at->format('d/m/Y') }}</span>
                                </div>
                                <span class="ticket-status ticket-status--{{ $ticket->status }}">{{ $statusText }}</span>
                            </div>

                            <h3>{{ $ticket->title }}</h3>
                            <p>{{ \Illuminate\Support\Str::limit($ticket->description, 120) }}</p>

                            <div class="ticket-list-card__footer">
                                <div class="ticket-user">
                                    <div class="ticket-avatar">{{ strtoupper($initials) }}</div>
                                    <span>{{ $authorName }}</span>
                                </div>

                                <div class="ticket-details">
                                    <div>
                                        <small>Categoria</small>
                                        <strong>{{ $tagText }}</strong>
                                    </div>
                                    <div>
                                        <small>Prioridade</small>
                                        <strong>{{ $priorityText }}</strong>
                                    </div>
                                    <div>
                                        <small>Responsável</small>
                                        <strong>{{ $responsibleName }}</strong>
                                    </div>
                                </div>

                                @if(in_array($user->tipo, ['admin', 'gerente']))
                                <form class="assign-form" method="POST" action="/tickets/{{ $ticket->id }}/atribuir">
                                    @csrf
                                    <select name="responsible_id" required>
                                        <option value="">Atribuir funcionário</option>
                                        @foreach($funcionarios as $funcionario)
                                        <option value="{{ $funcionario->id }}" {{ $ticket->responsible_id == $funcionario->id ? 'selected' : '' }}>
                                            {{ $funcionario->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                    <button type="submit">Atribuir</button>
                                </form>
                                @endif

                                @if($canUpdateStatus)
                                <form class="status-form" method="POST" action="{{ route('tickets.status', $ticket->id) }}">
                                    @csrf
                                    @method('PATCH')
                                    <select name="status" required>
                                        @foreach($statusLabels as $value => $label)
                                        <option value="{{ $value }}" {{ $ticket->status === $value ? 'selected' : '' }}>{{ $label }}</option>
                                        @endforeach
                                    </select>
                                    <select name="priority">
                                        <option value="">Prioridade</option>
                                        @foreach($priorityLabels as $value => $label)
                                        <option value="{{ $value }}" {{ $ticket->priority === $value ? 'selected' : '' }}>{{ $label }}</option>
                                        @endforeach
                                    </select>
                                    <button type="submit">Atualizar</button>
                                </form>
                                @endif

                                @if($user->tipo === 'admin')
                                <form class="status-form" method="POST" action="{{ route('tickets.destroy', $ticket->id) }}"
                                    onsubmit="return confirm('Tem certeza que deseja excluir este chamado?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn-danger" style="height:40px;padding:0 16px;">
                                        <i class="fa-solid fa-trash"></i> Excluir
                                    </button>
                                </form>
                                @endif
                            </div>
                        </article>
                        @empty
                        <div class="empty-tickets">
                            <i class="fa-regular fa-folder-open"></i>
                            <h3>Nenhum chamado encontrado</h3>
                            <p>Você ainda não possui chamados cadastrados.</p>
                            @if($user->tipo !== 'funcionario')
                            <button class="btn-primary" type="button" onclick="trocarSecao('novo-chamado')">
                                <i class="fa-solid fa-plus"></i>
                                Abrir chamado
                            </button>
                            @endif
                        </div>
                        @endforelse
                    </div>
                </div>
            </section>

            @if($user->tipo === 'admin')
            <section class="section {{ session('active_section') === 'controle-acessos' ? '' : 'hidden' }}" id="controle-acessos">
                <div class="users-page">
                    <div class="users-intro">
                        <span class="users-badge">
                            <i class="fa-solid fa-users-gear"></i>
                            Administração
                        </span>
                        <h2>Controle de Acessos</h2>
                        <p>Gerencie os usuários cadastrados, altere permissões e remova contas quando necessário.</p>
                    </div>

                    <div class="users-toolbar">
                        <div class="users-search">
                            <i class="fa-solid fa-search"></i>
                            <input type="text" id="search-user" placeholder="Buscar por nome, e-mail, CPF ou tipo...">
                        </div>
                    </div>

                    <div class="users-table-wrapper">
                        <table class="users-table">
                            <thead>
                                <tr>
                                    <th>Usuário</th>
                                    <th>E-mail</th>
                                    <th>CPF</th>
                                    <th>Tipo</th>
                                    <th class="text-right">Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($users as $userItem)
                                <tr class="user-row" data-search="{{ strtolower($userItem->name . ' ' . $userItem->email . ' ' . $userItem->cpf . ' ' . $userItem->tipo) }}">
                                    <td>
                                        <div class="table-user">
                                            <div class="table-avatar">{{ strtoupper(mb_substr($userItem->name, 0, 2)) }}</div>
                                            <div>
                                                <strong>{{ $userItem->name }}</strong>
                                                <span>ID #{{ $userItem->id }}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{{ $userItem->email }}</td>
                                    <td>{{ $userItem->cpf }}</td>
                                    <td>
                                        <span class="user-type user-type--{{ $userItem->tipo }}">{{ ucfirst($userItem->tipo) }}</span>
                                    </td>
                                    <td class="text-right">
                                        <button type="button" class="btn-table expand-user-btn" data-target="user-details-{{ $userItem->id }}">
                                            <i class="fa-solid fa-chevron-down"></i> Expandir
                                        </button>
                                    </td>
                                </tr>
                                <tr class="user-details-row hidden" id="user-details-{{ $userItem->id }}">
                                    <td colspan="5">
                                        <div class="user-details-box">
                                            <form method="POST" action="{{ route('users.update', $userItem->id) }}">
                                                @csrf
                                                @method('PUT')
                                                <div class="user-details-grid">
                                                    <div class="form-group">
                                                        <label>Nome</label>
                                                        <input type="text" name="name" class="input" value="{{ $userItem->name }}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>E-mail</label>
                                                        <input type="email" name="email" class="input" value="{{ $userItem->email }}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>CPF</label>
                                                        <input type="text" name="cpf" class="input" value="{{ $userItem->cpf }}" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Telefone</label>
                                                        <input type="text" name="telefone" class="input" value="{{ $userItem->telefone }}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Tipo</label>
                                                        <select name="tipo" class="input" required>
                                                            <option value="admin" {{ $userItem->tipo === 'admin' ? 'selected' : '' }}>Admin</option>
                                                            <option value="gerente" {{ $userItem->tipo === 'gerente' ? 'selected' : '' }}>Gerente</option>
                                                            <option value="funcionario" {{ $userItem->tipo === 'funcionario' ? 'selected' : '' }}>Funcionário</option>
                                                            <option value="solicitante" {{ $userItem->tipo === 'solicitante' ? 'selected' : '' }}>Solicitante</option>
                                                            <option value="user" {{ $userItem->tipo === 'user' ? 'selected' : '' }}>Usuário</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Endereço</label>
                                                        <input type="text" name="endereco" class="input" value="{{ $userItem->endereco }}">
                                                    </div>
                                                </div>
                                                <div class="user-details-actions">
                                                    <button type="submit" class="btn-primary">
                                                        <i class="fa-solid fa-floppy-disk"></i> Salvar alterações
                                                    </button>
                                                </div>
                                            </form>
                                            <form method="POST" action="{{ route('users.destroy', $userItem->id) }}"
                                                onsubmit="return confirm('Tem certeza que deseja excluir este usuário?');">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn-danger" {{ $userItem->id === auth()->id() ? 'disabled' : '' }}>
                                                    <i class="fa-solid fa-trash"></i> Excluir usuário
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="5">
                                        <div class="empty-users">
                                            <i class="fa-regular fa-folder-open"></i>
                                            <h3>Nenhum usuário encontrado</h3>
                                            <p>Ainda não existem usuários cadastrados.</p>
                                        </div>
                                    </td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
            @endif

            <section class="section {{ session('active_section') === 'perfil' ? '' : 'hidden' }}" id="perfil">
                <div class="perfil-page">
                    <div class="perfil-hero">
                        <div class="perfil-hero__avatar">{{ strtoupper($userInitials) }}</div>
                        <div class="perfil-hero__info">
                            <h2>{{ $user->name }}</h2>
                            <p>{{ $user->email }}</p>
                            <span class="perfil-role-badge perfil-role-badge--{{ $user->tipo }}">
                                <i class="fa-solid fa-shield-halved"></i>
                                {{ $tipoLabels[$user->tipo] ?? ucfirst($user->tipo) }}
                            </span>
                        </div>
                        <div class="perfil-hero__actions">
                            <button type="button" class="btn-primary" id="modal-abrir-edicao">
                                <i class="fa-solid fa-pen"></i> Editar perfil
                            </button>
                            <form action="/logout" method="post">
                                @csrf
                                <button type="submit" class="btn-secondary">
                                    <i class="fa-solid fa-right-from-bracket"></i> Sair
                                </button>
                            </form>
                        </div>
                    </div>

                    <div class="perfil-grid">
                        <div class="perfil-info-card">
                            <div class="perfil-info-card__icon"><i class="fa-solid fa-id-card"></i></div>
                            <div>
                                <label>CPF</label>
                                <p>{{ $user->cpf }}</p>
                            </div>
                        </div>
                        <div class="perfil-info-card">
                            <div class="perfil-info-card__icon"><i class="fa-solid fa-phone"></i></div>
                            <div>
                                <label>Telefone</label>
                                <p>{{ $user->telefone ?? 'Não informado' }}</p>
                            </div>
                        </div>
                        <div class="perfil-info-card perfil-info-card--wide">
                            <div class="perfil-info-card__icon"><i class="fa-solid fa-location-dot"></i></div>
                            <div>
                                <label>Endereço</label>
                                <p>{{ $user->endereco ?? 'Não informado' }}</p>
                            </div>
                        </div>
                        <div class="perfil-info-card">
                            <div class="perfil-info-card__icon"><i class="fa-solid fa-calendar"></i></div>
                            <div>
                                <label>Membro desde</label>
                                <p>{{ $user->created_at->format('d/m/Y') }}</p>
                            </div>
                        </div>
                        <div class="perfil-info-card">
                            <div class="perfil-info-card__icon"><i class="fa-solid fa-ticket"></i></div>
                            <div>
                                <label>Chamados</label>
                                <p>{{ $stats['total'] }} registrado(s)</p>
                            </div>
                        </div>
                    </div>

                    <div class="perfil-security">
                        <div class="perfil-security__header">
                            <i class="fa-solid fa-lock"></i>
                            <div>
                                <h3>Segurança da conta</h3>
                                <p>Altere sua senha periodicamente para manter sua conta protegida.</p>
                            </div>
                        </div>
                        <button type="button" class="btn-secondary" id="modal-abrir-senha">
                            <i class="fa-solid fa-key"></i> Alterar senha
                        </button>
                    </div>
                </div>

                <div class="modal-editar-perfil" id="modal-editar-perfil">
                    <div class="modal-content">
                        <div class="modal-content__header">
                            <h3 id="modal-titulo">Editar Perfil</h3>
                            <button type="button" class="modal-close" id="modal-cancelar-edicao" aria-label="Fechar">✕</button>
                        </div>
                        <form method="POST" action="{{ route('profile.update') }}" id="form-perfil">
                            @csrf
                            @method('PUT')
                            <div class="form-group" id="campo-nome">
                                <label for="perfil-nome">Nome completo</label>
                                <input type="text" id="perfil-nome" name="name" class="input" value="{{ $user->name }}" required>
                            </div>
                            <div class="form-group" id="campo-telefone">
                                <label for="perfil-telefone">Telefone</label>
                                <input type="text" id="perfil-telefone" name="telefone" class="input" value="{{ $user->telefone }}">
                            </div>
                            <div class="form-group" id="campo-endereco">
                                <label for="perfil-endereco">Endereço</label>
                                <input type="text" id="perfil-endereco" name="endereco" class="input" value="{{ $user->endereco }}">
                            </div>
                            <div class="form-group campo-senha hidden">
                                <label for="perfil-senha">Nova senha</label>
                                <input type="password" id="perfil-senha" name="password" class="input" placeholder="Mínimo 8 caracteres">
                            </div>
                            <div class="form-group campo-senha hidden">
                                <label for="perfil-senha-confirm">Confirmar nova senha</label>
                                <input type="password" id="perfil-senha-confirm" name="password_confirmation" class="input">
                            </div>
                            <div class="modal-actions">
                                <button type="button" class="btn-secondary" id="modal-cancelar-edicao-2">Cancelar</button>
                                <button type="submit" class="btn-primary">Salvar alterações</button>
                            </div>
                        </form>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <script src="js/Dashboard/dashboard.js"></script>

</body>

</html>
