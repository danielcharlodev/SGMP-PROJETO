<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class TicketController extends Controller
{
    public function store(Request $request)
    {
        $user = auth()->user();

        if ($user->tipo === 'funcionario') {
            return redirect('/dashboard')
                ->with('error', 'Funcionários não podem abrir chamados.')
                ->with('active_section', 'buscar-chamados');
        }

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|min:10',
            'tag' => 'required|in:eletrica,infraestrutura',
        ], [
            'title.required' => 'O título é obrigatório.',
            'description.required' => 'A descrição é obrigatória.',
            'description.min' => 'A descrição deve possuir pelo menos 10 caracteres.',
            'tag.required' => 'Selecione uma categoria.',
            'tag.in' => 'Categoria inválida.',
        ]);

        $ultimoNumero = Ticket::max('number') ?? 0;

        Ticket::create([
            'author_id' => $user->id,
            'number' => $ultimoNumero + 1,
            'title' => $request->title,
            'description' => $request->description,
            'tag' => $request->tag,
            'status' => 'pendente',
        ]);

        return redirect('/dashboard')
            ->with('success', 'Chamado aberto com sucesso!')
            ->with('active_section', 'novo-chamado');
    }

    public function atribuir(Request $request, Ticket $ticket)
    {
        $user = auth()->user();

        if (!in_array($user->tipo, ['admin', 'gerente'])) {
            return redirect('/dashboard')
                ->with('error', 'Você não tem permissão para atribuir chamados.')
                ->with('active_section', 'buscar-chamados');
        }

        $request->validate([
            'responsible_id' => [
                'required',
                Rule::exists('users', 'id')->where('tipo', 'funcionario'),
            ],
        ], [
            'responsible_id.required' => 'Selecione um funcionário.',
            'responsible_id.exists' => 'Funcionário inválido.',
        ]);

        $ticket->update([
            'responsible_id' => $request->responsible_id,
            'status' => 'em_analise',
        ]);

        return redirect('/dashboard')
            ->with('success', 'Chamado atribuído com sucesso!')
            ->with('active_section', 'buscar-chamados');
    }

    public function update(Request $request, Ticket $ticket)
    {
        $user = auth()->user();

        if ($user->tipo === 'solicitante' || $user->tipo === 'user') {
            if ($ticket->author_id !== $user->id) {
                abort(403);
            }
        }

        if ($user->tipo === 'funcionario') {
            if ($ticket->responsible_id !== $user->id) {
                abort(403);
            }
        }

        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string|min:10',
            'tag' => 'required|in:eletrica,infraestrutura',
            'status' => 'required|in:pendente,em_analise,aguardando_material,em_andamento,negado,finalizado,cancelado',
        ]);

        $ticket->update([
            'title' => $request->title,
            'description' => $request->description,
            'tag' => $request->tag,
            'status' => $request->status,
        ]);

        if ($request->status === 'finalizado') {
            $ticket->update([
                'finished_at' => now(),
            ]);
        }

        return redirect('/dashboard')
            ->with('success', 'Chamado atualizado com sucesso!')
            ->with('active_section', 'buscar-chamados');
    }

    public function updateStatus(Request $request, Ticket $ticket)
    {
        $user = auth()->user();

        if (!in_array($user->tipo, ['admin', 'gerente', 'funcionario'])) {
            abort(403);
        }

        if ($user->tipo === 'funcionario' && $ticket->responsible_id !== $user->id) {
            abort(403);
        }

        $request->validate([
            'status' => 'required|in:pendente,em_analise,aguardando_material,em_andamento,negado,finalizado,cancelado',
        ]);

        $ticket->update([
            'status' => $request->status,
            'finished_at' => $request->status === 'finalizado' ? now() : $ticket->finished_at,
        ]);

        return redirect('/dashboard')
            ->with('success', 'Status do chamado atualizado!')
            ->with('active_section', 'buscar-chamados');
    }

    public function destroy(Ticket $ticket)
    {
        $user = auth()->user();

        if ($user->tipo !== 'admin') {
            abort(403);
        }

        $ticket->delete();

        return redirect('/dashboard')
            ->with('success', 'Chamado removido com sucesso!')
            ->with('active_section', 'buscar-chamados');
    }
}