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

    $ticketsQuery = Ticket::with(['author', 'responsible'])
        ->latest();

    if (in_array($user->tipo, ['solicitante', 'user'])) {
        $ticketsQuery->where('author_id', $user->id);
    }

    if ($user->tipo === 'funcionario') {
        $ticketsQuery->where('responsible_id', $user->id);
    }

    $tickets = $ticketsQuery->get();

    $funcionarios = collect();

    if (in_array($user->tipo, ['admin', 'gerente'])) {
        $funcionarios = User::where('tipo', 'funcionario')
            ->orderBy('name')
            ->get();
    }

    $users = collect();

    if ($user->tipo === 'admin') {
        $users = User::orderBy('name')->get();
    }

    return view('Dashboard.index', compact('tickets', 'funcionarios', 'users'));
})->middleware('auth')->name('dashboard');

Route::post('/cadastro', [AuthController::class, 'cadastrar']);

Route::post('/login', [AuthController::class, 'logar']);

Route::post('/logout', [AuthController::class, 'logout']);

Route::post('/new_ticket', [TicketController::class, 'store'])
    ->middleware('auth');

Route::post('/tickets/{ticket}/atribuir', [TicketController::class, 'atribuir'])
    ->middleware('auth');

Route::put('/users/{user}', [UserController::class, 'update'])
    ->middleware('auth')
    ->name('users.update');

Route::delete('/users/{user}', [UserController::class, 'destroy'])
    ->middleware('auth')
    ->name('users.destroy');
