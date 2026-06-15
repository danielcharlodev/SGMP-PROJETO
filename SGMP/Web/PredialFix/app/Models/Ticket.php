<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Ticket extends Model
{
    protected $fillable = [
        'responsible_id',
        'author_id',
        'budget_id',
        'number',
        'title',
        'description',
        'status',
        'tag',
        'priority',
        'finished_at',
        'caminho_imagem',
    ];

    public function author(): BelongsTo
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    public function responsible(): BelongsTo
    {
        return $this->belongsTo(User::class, 'responsible_id');
    }

    public function budget(): BelongsTo
    {
        return $this->belongsTo(Budget::class);
    }
}
