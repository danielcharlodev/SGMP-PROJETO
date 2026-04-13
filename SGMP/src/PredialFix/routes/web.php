<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('Login/index');
});

Route::get('/cadastro',function(){
    return view('Cadastro/index');
});

Route::get('/login',function(){
    return view('Login/index');
});