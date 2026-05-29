<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
    ];

    public function author()
    {
        return $this->belongsTo(User::class, 'author_id');
    }

    public function responsible()
    {
        return $this->belongsTo(User::class, 'responsible_id');
    }
}