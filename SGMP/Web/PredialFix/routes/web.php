<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

Route::get('/', function () {
    return view('Login.index');
});

Route::get('/cadastro',function(){
    return view('Cadastro.index');
});

Route::get('/login',function(){
    return view('Login.index');
})->name('login');

Route::get('/dashboard',function(){
    return view('Dashboard.index');
})->middleware('auth');

Route::post('/cadastro',[AuthController::class, 'cadastrar']);

Route::post('/login',[AuthController::class, 'logar']);

Route::post('/logout',[AuthController::class,'logout']);