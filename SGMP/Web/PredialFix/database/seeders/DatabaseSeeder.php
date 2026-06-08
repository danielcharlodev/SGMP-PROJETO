<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        User::factory()->admin()->create([
            'name' => 'Administrador',
            'email' => 'admin@sgmp.local',
            'cpf' => '000.000.000-00',
            'password' => 'admin1234',
        ]);

        User::factory()->create([
            'name' => 'Gerente Teste',
            'email' => 'gerente@sgmp.local',
            'cpf' => '111.111.111-11',
            'tipo' => 'gerente',
            'password' => 'gerente123',
        ]);

        User::factory()->create([
            'name' => 'Funcionário Teste',
            'email' => 'funcionario@sgmp.local',
            'cpf' => '222.222.222-22',
            'tipo' => 'funcionario',
            'password' => 'func1234',
        ]);
    }
}
