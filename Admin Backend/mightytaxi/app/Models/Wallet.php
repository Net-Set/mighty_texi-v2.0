<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wallet extends Model
{
    use HasFactory;
    protected $fillable = [ 'user_id', 'total_amount', 'online_received', 'collected_cash', 'total_withdrawn', 'currency' ];

    protected $casts = [
        'user_id'           => 'integer',
        'total_amount'      => 'double',
        'online_received'   => 'double',
        'collected_cash'    => 'double',
        'total_withdrawn'   => 'double',
    ];

    public function user() {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
