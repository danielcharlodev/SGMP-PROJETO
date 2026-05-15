<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
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
            'password' => 'required|min:6|confirmed',
            'password_confirmation' => 'required|min:6'
        ])->stopOnFirstFailure();

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator);
        } else {
            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'cpf' => $request->cpf,
                'telefone' => $request->telefone,
                'tipo' => 'user',
                'endereco' => $request->endereco,
                'password' => Hash::make($request->password)
            ]);
            return redirect('/login');
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
            $credencials = [
                'email' => $request->email,
                'password' => $request->password
            ];
            if (Auth::attempt($credencials)) {
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
}
