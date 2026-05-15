<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->id();
            $table->foreignId('responsible_id')->nullable()->constrained('users');
            $table->foreignId('author_id')->constrained('users');
            $table->foreignId('budget_id')->nullable()->constrained('budgets');
            $table->unsignedInteger('number')->unique();
            $table->string('title');
            $table->text('description');
            $table->enum('status',['pendente','em_analise','aguardando_material', 'em_andamento', 'negado', 'finalizado','cancelado'])->default('pendente');
            $table->enum('tag',['eletrica', 'infraestrutura']);
            $table->enum('priority',['minima','muito_baixa','baixa','moderada','media_alta','alta','critica','emergencial'])->nullable();
            $table->timestamp('finished_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tickets');
    }
};
