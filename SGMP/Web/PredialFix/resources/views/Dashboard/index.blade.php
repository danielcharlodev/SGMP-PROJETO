<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Painel Administrativo</title>

    <link rel="stylesheet" href="css/dashboard/style.css">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
            <strong>Erro ao criar chamado</strong>

            <ul>
                @foreach($errors->all() as $error)
                <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    </div>
    @endif

    <div class="layout">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar__top">
                <div class="sidebar__logo">
                    <img src="Imagens/senai.png" alt="Logo do Senai">
                </div>

                <nav class="sidebar__nav">
                    <button class="sidebar__button" onclick="trocarSecao('painel')">
                        <i class="fa-solid fa-house"></i>
                        <span>Home</span>
                    </button>

                    @if(auth()->user()->tipo !== 'funcionario')
                    <button class="sidebar__button" onclick="trocarSecao('novo-chamado')">
                        <i class="fa-solid fa-plus"></i>
                        <span>Novo Chamado</span>
                    </button>
                    @endif

                    <button class="sidebar__button" onclick="trocarSecao('buscar-chamados')">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Buscar Chamados</span>
                    </button>

                    @if(auth()->user()->tipo === 'admin')
                    <button class="sidebar__button" onclick="trocarSecao('controle-acessos')">
                        <i class="fa-solid fa-users-gear"></i>
                        <span>Controle de Acessos</span>
                    </button>
                    @endif

                    <form action="/logout" method="post">
                        @csrf
                        <button type="submit">Sair</button>
                    </form>
                </nav>
            </div>

            <div class="sidebar__bottom">
                <button class="sidebar__button" onclick="trocarSecao('perfil')">
                    <i class="fa-solid fa-circle-user"></i>
                    <span>Perfil</span>
                </button>
            </div>
        </aside>

        <!-- HEADER -->
        <header class="header">
            <h1 class="header__title">
                Painel Administrativo
            </h1>

            <button class="theme-toggle" id="theme-toggle">
                🌙
            </button>
        </header>

        <!-- MAIN -->
        <main class="content">

            <!-- DASHBOARD -->
            <section class="section {{ session('active_section') ? 'hidden' : '' }}" id="painel">
                <h2 class="section__title">
                    Meu Painel
                </h2>

                <div class="cards-grid">
                    <article class="card">
                        <h3 class="card__title">
                            Chamados Criados
                        </h3>
                    </article>

                    <article class="card">
                        <h3 class="card__title">
                            Satisfação do Cliente
                        </h3>
                    </article>

                    <article class="card">
                        <h3 class="card__title">
                            Chamados Abertos
                        </h3>
                    </article>

                    <article class="card card--wide">
                        <h3 class="card__title">
                            Relatórios
                        </h3>
                    </article>

                    <article class="card">
                        <h3 class="card__title">
                            Estatísticas
                        </h3>
                    </article>
                </div>
            </section>

            <!-- NOVO CHAMADO -->
            <section class="section {{ session('active_section') === 'novo-chamado' ? '' : 'hidden' }}" id="novo-chamado">
                <div class="ticket-page">

                    <div class="ticket-intro">
                        <span class="ticket-badge">
                            <i class="fa-solid fa-plus"></i>
                            Novo chamado
                        </span>

                        <h2>Abrir chamado</h2>

                        <p>
                            Informe o problema encontrado. Quanto mais detalhes você colocar,
                            mais fácil será para a equipe resolver.
                        </p>
                    </div>

                    <form class="ticket-card" method="POST" action="/new_ticket">
                        @csrf

                        <div class="form-group">
                            <label for="title">Título</label>

                            <input
                                type="text"
                                id="title"
                                name="title"
                                class="input"
                                placeholder="Ex: Lâmpada queimada no laboratório"
                                value="{{ old('title') }}"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="tag">Categoria</label>

                            <select
                                id="tag"
                                name="tag"
                                class="input"
                                required>
                                <option value="">Selecione uma categoria</option>

                                <option value="eletrica" {{ old('tag') == 'eletrica' ? 'selected' : '' }}>
                                    Elétrica
                                </option>

                                <option value="infraestrutura" {{ old('tag') == 'infraestrutura' ? 'selected' : '' }}>
                                    Infraestrutura
                                </option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="description">Descrição</label>

                            <textarea
                                id="description"
                                name="description"
                                class="input textarea"
                                placeholder="Descreva o local, o problema e qualquer detalhe importante..."
                                required>{{ old('description') }}</textarea>
                        </div>

                        <div class="ticket-actions">
                            <button class="btn-secondary" type="reset">
                                Limpar
                            </button>

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

                        <p>
                            Consulte os chamados cadastrados no sistema, acompanhe o status
                            e veja os detalhes de cada solicitação.
                        </p>
                    </div>

                    <div class="tickets-toolbar">
                        <div class="tickets-search">
                            <i class="fa-solid fa-search"></i>

                            <input
                                type="text"
                                id="search-ticket"
                                placeholder="Buscar por título, número ou categoria...">
                        </div>

                        <div class="tickets-filters">
                            <button class="ticket-filter active" type="button" data-filter="todos">
                                Todos
                            </button>

                            <button class="ticket-filter" type="button" data-filter="pendente">
                                Pendentes
                            </button>

                            <button class="ticket-filter" type="button" data-filter="em_analise">
                                Em análise
                            </button>

                            <button class="ticket-filter" type="button" data-filter="em_andamento">
                                Em andamento
                            </button>

                            <button class="ticket-filter" type="button" data-filter="finalizado">
                                Finalizados
                            </button>
                        </div>
                    </div>

                    <div class="tickets-list">

                        @forelse($tickets as $ticket)
                        @php
                        $statusLabels = [
                        'pendente' => 'Pendente',
                        'em_analise' => 'Em análise',
                        'aguardando_material' => 'Aguardando material',
                        'em_andamento' => 'Em andamento',
                        'negado' => 'Negado',
                        'finalizado' => 'Finalizado',
                        'cancelado' => 'Cancelado',
                        ];

                        $tagLabels = [
                        'eletrica' => 'Elétrica',
                        'infraestrutura' => 'Infraestrutura',
                        ];

                        $statusText = $statusLabels[$ticket->status] ?? $ticket->status;
                        $tagText = $tagLabels[$ticket->tag] ?? $ticket->tag;

                        $authorName = $ticket->author->name ?? 'Usuário';
                        $responsibleName = $ticket->responsible->name ?? 'Não atribuído';

                        $nameParts = explode(' ', trim($authorName));
                        $initials = '';

                        foreach ($nameParts as $part) {
                        if ($part !== '') {
                        $initials .= mb_substr($part, 0, 1);
                        }

                        if (mb_strlen($initials) >= 2) {
                        break;
                        }
                        }

                        if ($initials === '') {
                        $initials = 'US';
                        }

                        $searchText = strtolower(
                        $ticket->number . ' ' .
                        $ticket->title . ' ' .
                        $ticket->description . ' ' .
                        $tagText . ' ' .
                        $statusText . ' ' .
                        $authorName . ' ' .
                        $responsibleName
                        );
                        @endphp

                        <article
                            class="ticket-list-card"
                            data-status="{{ $ticket->status }}"
                            data-search="{{ $searchText }}">

                            <div class="ticket-list-card__top">
                                <div>
                                    <span class="ticket-code">
                                        #{{ $ticket->number }}
                                    </span>

                                    <span class="ticket-date">
                                        Aberto em {{ $ticket->created_at->format('d/m/Y') }}
                                    </span>
                                </div>

                                <span class="ticket-status ticket-status--{{ $ticket->status }}">
                                    {{ $statusText }}
                                </span>
                            </div>

                            <h3>{{ $ticket->title }}</h3>

                            <p>
                                {{ \Illuminate\Support\Str::limit($ticket->description, 120) }}
                            </p>

                            <div class="ticket-list-card__footer">
                                <div class="ticket-user">
                                    <div class="ticket-avatar">
                                        {{ strtoupper($initials) }}
                                    </div>

                                    <span>{{ $authorName }}</span>
                                </div>

                                <div class="ticket-details">
                                    <div>
                                        <small>Categoria</small>
                                        <strong>{{ $tagText }}</strong>
                                    </div>

                                    <div>
                                        <small>Responsável</small>
                                        <strong>{{ $responsibleName }}</strong>
                                    </div>
                                </div>

                                @if(in_array(auth()->user()->tipo, ['admin', 'gerente']))
                                <form class="assign-form" method="POST" action="/tickets/{{ $ticket->id }}/atribuir">
                                    @csrf

                                    <select name="responsible_id" required>
                                        <option value="">Atribuir funcionário</option>

                                        @foreach($funcionarios as $funcionario)
                                        <option
                                            value="{{ $funcionario->id }}"
                                            {{ $ticket->responsible_id == $funcionario->id ? 'selected' : '' }}>
                                            {{ $funcionario->name }}
                                        </option>
                                        @endforeach
                                    </select>

                                    <button type="submit">
                                        Atribuir
                                    </button>
                                </form>
                                @endif
                            </div>
                        </article>
                        @empty
                        <div class="empty-tickets">
                            <i class="fa-regular fa-folder-open"></i>

                            <h3>Nenhum chamado encontrado</h3>

                            <p>
                                Você ainda não abriu nenhum chamado.
                            </p>

                            <button class="btn-primary" type="button" onclick="trocarSecao('novo-chamado')">
                                <i class="fa-solid fa-plus"></i>
                                Abrir chamado
                            </button>
                        </div>
                        @endforelse

                    </div>

                </div>
            </section>

            @if(auth()->user()->tipo === 'admin')
            <section class="section {{ session('active_section') === 'controle-acessos' ? '' : 'hidden' }}" id="controle-acessos">
                <div class="users-page">

                    <div class="users-intro">
                        <span class="users-badge">
                            <i class="fa-solid fa-users-gear"></i>
                            Administração
                        </span>

                        <h2>Controle de Acessos</h2>

                        <p>
                            Gerencie os usuários cadastrados, altere permissões e remova contas quando necessário.
                        </p>
                    </div>

                    <div class="users-toolbar">
                        <div class="users-search">
                            <i class="fa-solid fa-search"></i>

                            <input
                                type="text"
                                id="search-user"
                                placeholder="Buscar por nome, e-mail, CPF ou tipo...">
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
                                <tr
                                    class="user-row"
                                    data-search="{{ strtolower($userItem->name . ' ' . $userItem->email . ' ' . $userItem->cpf . ' ' . $userItem->tipo) }}">
                                    <td>
                                        <div class="table-user">
                                            <div class="table-avatar">
                                                {{ strtoupper(mb_substr($userItem->name, 0, 2)) }}
                                            </div>

                                            <div>
                                                <strong>{{ $userItem->name }}</strong>
                                                <span>ID #{{ $userItem->id }}</span>
                                            </div>
                                        </div>
                                    </td>

                                    <td>{{ $userItem->email }}</td>

                                    <td>{{ $userItem->cpf }}</td>

                                    <td>
                                        <span class="user-type user-type--{{ $userItem->tipo }}">
                                            {{ ucfirst($userItem->tipo) }}
                                        </span>
                                    </td>

                                    <td class="text-right">
                                        <button
                                            type="button"
                                            class="btn-table expand-user-btn"
                                            data-target="user-details-{{ $userItem->id }}">
                                            <i class="fa-solid fa-chevron-down"></i>
                                            Expandir
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
                                                        <input
                                                            type="text"
                                                            name="name"
                                                            class="input"
                                                            value="{{ $userItem->name }}"
                                                            required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>E-mail</label>
                                                        <input
                                                            type="email"
                                                            name="email"
                                                            class="input"
                                                            value="{{ $userItem->email }}"
                                                            required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>CPF</label>
                                                        <input
                                                            type="text"
                                                            name="cpf"
                                                            class="input"
                                                            value="{{ $userItem->cpf }}"
                                                            required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Telefone</label>
                                                        <input
                                                            type="text"
                                                            name="telefone"
                                                            class="input"
                                                            value="{{ $userItem->telefone }}">
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Tipo</label>
                                                        <select name="tipo" class="input" required>
                                                            <option value="admin" {{ $userItem->tipo === 'admin' ? 'selected' : '' }}>
                                                                Admin
                                                            </option>

                                                            <option value="gerente" {{ $userItem->tipo === 'gerente' ? 'selected' : '' }}>
                                                                Gerente
                                                            </option>

                                                            <option value="funcionario" {{ $userItem->tipo === 'funcionario' ? 'selected' : '' }}>
                                                                Funcionário
                                                            </option>

                                                            <option value="solicitante" {{ $userItem->tipo === 'solicitante' ? 'selected' : '' }}>
                                                                Solicitante
                                                            </option>
                                                        </select>
                                                    </div>

                                                    <div class="form-group">
                                                        <label>Endereço</label>
                                                        <input
                                                            type="text"
                                                            name="endereco"
                                                            class="input"
                                                            value="{{ $userItem->endereco }}">
                                                    </div>
                                                </div>

                                                <div class="user-details-actions">
                                                    <button type="submit" class="btn-primary">
                                                        <i class="fa-solid fa-floppy-disk"></i>
                                                        Salvar alterações
                                                    </button>
                                                </div>
                                            </form>

                                            <form
                                                method="POST"
                                                action="{{ route('users.destroy', $userItem->id) }}"
                                                onsubmit="return confirm('Tem certeza que deseja excluir este usuário?');">

                                                @csrf
                                                @method('DELETE')

                                                <button
                                                    type="submit"
                                                    class="btn-danger"
                                                    {{ $userItem->id === auth()->id() ? 'disabled' : '' }}>
                                                    <i class="fa-solid fa-trash"></i>
                                                    Excluir usuário
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

        </main>

    </div>

    <script src="js/Dashboard/dashboard.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const toast = document.querySelector('.toast');

            if (toast) {
                setTimeout(() => {
                    toast.style.opacity = '0';
                    toast.style.transform = 'translateX(100%)';

                    setTimeout(() => {
                        toast.remove();
                    }, 300);
                }, 5000);
            }
        });
    </script>

</body>

</html>