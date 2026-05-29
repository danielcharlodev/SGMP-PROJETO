<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class UserController extends Controller
{
    private function somenteAdmin()
    {
        if (auth()->user()->tipo !== 'admin') {
            abort(403, 'Acesso negado.');
        }
    }

    public function update(Request $request, User $user)
    {
        $this->somenteAdmin();

        $request->validate([
            'name' => 'required|string|max:255',

            'email' => [
                'required',
                'email',
                'max:255',
                Rule::unique('users', 'email')->ignore($user->id),
            ],

            'cpf' => [
                'required',
                'string',
                'max:14',
                Rule::unique('users', 'cpf')->ignore($user->id),
            ],

            'telefone' => 'nullable|string|max:15',

            'tipo' => 'required|in:admin,gerente,funcionario,solicitante,user',

            'endereco' => 'nullable|string|max:255',
        ], [
            'name.required' => 'O nome é obrigatório.',
            'email.required' => 'O e-mail é obrigatório.',
            'email.email' => 'Digite um e-mail válido.',
            'email.unique' => 'Este e-mail já está em uso.',
            'cpf.required' => 'O CPF é obrigatório.',
            'cpf.unique' => 'Este CPF já está em uso.',
            'tipo.required' => 'Selecione um tipo de usuário.',
            'tipo.in' => 'Tipo de usuário inválido.',
        ]);

        $user->update([
            'name' => $request->name,
            'email' => $request->email,
            'cpf' => $request->cpf,
            'telefone' => $request->telefone,
            'tipo' => $request->tipo,
            'endereco' => $request->endereco,
        ]);

        return redirect('/dashboard')
            ->with('success', 'Usuário atualizado com sucesso!')
            ->with('active_section', 'controle-acessos');
    }

    public function destroy(User $user)
    {
        $this->somenteAdmin();

        if ($user->id === auth()->id()) {
            return redirect('/dashboard')
                ->with('error', 'Você não pode excluir seu próprio usuário.')
                ->with('active_section', 'controle-acessos');
        }

        $user->delete();

        return redirect('/dashboard')
            ->with('success', 'Usuário excluído com sucesso!')
            ->with('active_section', 'controle-acessos');
    }
}