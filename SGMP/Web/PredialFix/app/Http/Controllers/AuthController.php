<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    function cadastrar(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'name' => 'required|min:3',
            'cpf' => 'required|size:14',
            'email' => 'required|email|min:10|max:100',
            'telefone' => 'nullable|min:14|max:15',
            'endereco' => 'required|min:6',
            'password' => 'required|min:8|confirmed',
            'password_confirmation' => 'required|min:8'
        ])->stopOnFirstFailure();

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        } else {
            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'cpf' => $request->cpf,
                'telefone' => $request->telefone,
                'tipo' => 'solicitante',
                'endereco' => $request->endereco,
                'password' => $request->password
            ]);
            
            return redirect()
            ->route('login')
            ->with('success', 'Conta criada com sucesso!');
        }
    }

    function logar(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required'
        ])->stopOnFirstFailure();

        if ($validator->fails()) {
            return back()->withErrors($validator);
        } else {
            $credentials = [
                'email' => $request->email,
                'password' => $request->password
            ];
            if (Auth::attempt($credentials)) {
                $request->session()->regenerate();
                return redirect('/dashboard');
            } else {
                return back()->withErrors([
                    'email' => 'Email ou senha incorretos.'
                ]);
            }
        }
    }

    function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/login');
    }

    public function updateProfile(Request $request)
    {
        $user = auth()->user();

        $request->validate([
            'name' => 'required|string|max:255',
            'telefone' => 'nullable|string|max:15',
            'endereco' => 'nullable|string|max:255',
            'password' => 'nullable|min:8|confirmed',
        ], [
            'name.required' => 'O nome é obrigatório.',
            'password.min' => 'A senha deve ter pelo menos 8 caracteres.',
            'password.confirmed' => 'As senhas não coincidem.',
        ]);

        $data = [
            'name' => $request->name,
            'telefone' => $request->telefone,
            'endereco' => $request->endereco,
        ];

        if ($request->filled('password')) {
            $data['password'] = $request->password;
        }

        $user->update($data);

        return redirect('/dashboard')
            ->with('success', 'Perfil atualizado com sucesso!')
            ->with('active_section', 'perfil');
    }
}
