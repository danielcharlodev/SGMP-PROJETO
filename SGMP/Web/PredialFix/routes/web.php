<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\TicketController;
use App\Models\Ticket;
use App\Models\User;
use App\Http\Controllers\UserController;

Route::get('/', function () {
    return view('Login.index');
});

Route::get('/cadastro', function () {
    return view('Cadastro.index');
});

Route::get('/login', function () {
    return view('Login.index');
})->name('login');

Route::get('/dashboard', function () {
    $user = auth()->user();

    $ticketsQuery = Ticket::with(['author', 'responsible'])->latest();

    if (in_array($user->tipo, ['solicitante', 'user'])) {
        $ticketsQuery->where('author_id', $user->id);
    }

    if ($user->tipo === 'funcionario') {
        $ticketsQuery->where('responsible_id', $user->id);
    }

    $tickets = $ticketsQuery->get();

    $statsQuery = Ticket::query();

    if (in_array($user->tipo, ['solicitante', 'user'])) {
        $statsQuery->where('author_id', $user->id);
    }

    if ($user->tipo === 'funcionario') {
        $statsQuery->where('responsible_id', $user->id);
    }

    $total = (clone $statsQuery)->count();
    $finalizados = (clone $statsQuery)->where('status', 'finalizado')->count();
    $pendentes = (clone $statsQuery)->where('status', 'pendente')->count();
    $emAndamento = (clone $statsQuery)->whereIn('status', ['em_analise', 'em_andamento', 'aguardando_material'])->count();

    $stats = [
        'total' => $total,
        'pendentes' => $pendentes,
        'em_andamento' => $emAndamento,
        'finalizados' => $finalizados,
        'taxa_resolucao' => $total > 0 ? round(($finalizados / $total) * 100) : 0,
        'mes_atual' => (clone $statsQuery)
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->count(),
        'eletrica' => (clone $statsQuery)->where('tag', 'eletrica')->count(),
        'infraestrutura' => (clone $statsQuery)->where('tag', 'infraestrutura')->count(),
        'aguardando' => (clone $statsQuery)->where('status', 'aguardando_material')->count(),
    ];

    if ($user->tipo === 'admin') {
        $stats['usuarios'] = User::count();
        $stats['funcionarios'] = User::where('tipo', 'funcionario')->count();
    }

    $recentTickets = $tickets->take(5);

    $tipoLabels = [
        'admin' => 'Administrador',
        'gerente' => 'Gerente',
        'funcionario' => 'Funcionário',
        'solicitante' => 'Solicitante',
        'user' => 'Usuário',
    ];

    $statusLabels = [
        'pendente' => 'Pendente',
        'em_analise' => 'Em análise',
        'aguardando_material' => 'Aguardando material',
        'em_andamento' => 'Em andamento',
        'negado' => 'Negado',
        'finalizado' => 'Finalizado',
        'cancelado' => 'Cancelado',
    ];

    $funcionarios = collect();

    if (in_array($user->tipo, ['admin', 'gerente'])) {
        $funcionarios = User::where('tipo', 'funcionario')->orderBy('name')->get();
    }

    $users = collect();

    if ($user->tipo === 'admin') {
        $users = User::orderBy('name')->get();
    }

    return view('Dashboard.index', compact(
        'tickets', 'funcionarios', 'users', 'stats',
        'recentTickets', 'tipoLabels', 'statusLabels'
    ));
})->middleware('auth')->name('dashboard');

Route::post('/cadastro', [AuthController::class, 'cadastrar']);

Route::post('/login', [AuthController::class, 'logar']);

Route::post('/logout', [AuthController::class, 'logout']);

Route::put('/profile', [AuthController::class, 'updateProfile'])
    ->middleware('auth')
    ->name('profile.update');

Route::post('/new_ticket', [TicketController::class, 'store'])
    ->middleware('auth');

Route::post('/tickets/{ticket}/atribuir', [TicketController::class, 'atribuir'])
    ->middleware('auth');

Route::patch('/tickets/{ticket}/status', [TicketController::class, 'updateStatus'])
    ->middleware('auth')
    ->name('tickets.status');

Route::delete('/tickets/{ticket}', [TicketController::class, 'destroy'])
    ->middleware('auth')
    ->name('tickets.destroy');

Route::put('/users/{user}', [UserController::class, 'update'])
    ->middleware('auth')
    ->name('users.update');

Route::delete('/users/{user}', [UserController::class, 'destroy'])
    ->middleware('auth')
    ->name('users.destroy');
