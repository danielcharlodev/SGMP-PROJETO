<?php

use Illuminate\Support\Facades\Route;
use app\Http\Controllers\AuthController;

Route::get('/', function () {
    return view('Login.index');
});

Route::get('/cadastro',function(){
    return view('Cadastro.index');
});

Route::get('/login',function(){
    return view('Login.index');
});

Route::get('/dashboard',function(){
    return view('Dashboard.index');
});

Route::post('/cadastro',[AuthController::class, 'cadastrar']);