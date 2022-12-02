<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserBankAccount extends Model
{
    use HasFactory;
    protected $fillable = [ 'user_id', 'bank_name', 'bank_code', 'account_holder_name', 'account_number' ];

    protected $casts = [
        'user_id' => 'integer',
    ];
}
