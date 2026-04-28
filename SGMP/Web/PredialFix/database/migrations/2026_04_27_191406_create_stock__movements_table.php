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
        Schema::create('stock__movements', function (Blueprint $table) {
            $table->id();
            $table->string('descricao');
            $table->foreignId('item_id')->constrained();
            $table->integer('quantidade');
            $table->enum('tipo', ['Entrada', 'Saida'])->default('Entrada');
            $table->foreignId('user_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stock__movements');
    }
};
