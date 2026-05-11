<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use app\Models\User;

class AuthController extends Controller
{
    function cadastrar(Request $request){
        // $request->name;
        // $request->cpf;
        // $request->email;
        // $request->telefone;
        // $request->endereco;
        // $request->password;
        // $request->password_confirmation;

        $request->validate([
            'name'=>'required|min:3',
            'cpf'=>'required|size:14',
            'email'=>'required|email|min:10|max:100',
            'telefone'=>'nullable|size:15',
            'endereco'=>'required|min:6',
            'password'=>'required|min:6|confirmed',
            'password_confirmation'=>'required|min:6'
        ]);

        User::create([
            'name'=>$request->name,
            'email'=>$request->email,
            'cpf'=>$request->cpf,
            'telefone'=>$request->telefone,
            'tipo'=>'user',
            'endereco'=>$request->endereco,
            'password'=>Hash::make($request->password)
        ]);

    }
}
