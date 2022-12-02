<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WithdrawRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id', 'amount', 'currency', 'status'
    ];

    protected $casts = [
        'user_id'   => 'integer',
        'amount'    => 'double',
        'status'    => 'integer',
    ];
    

    public function user() {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function scopemyWithdrawRequest($query)
    {
        $user = auth()->user();

        if($user->hasAnyRole(['admin'])){
            $query = $query;
        } else {
            $query = $query->where('user_id', $user->id);
        }

        return $query;
    }
}
