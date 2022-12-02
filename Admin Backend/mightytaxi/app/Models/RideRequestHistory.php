<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RideRequestHistory extends Model
{
    use HasFactory;

    protected $fillable = [ 'ride_request_id', 'datetime', 'history_type', 'history_message', 'history_data' ];
    
    protected $casts = [
        'ride_request_id' => 'integer',
    ];
    public function rideRequest(){
        return $this->belongsTo(RideRequest::class, 'ride_request_id', 'id');
    }

    public function getHistoryDataAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        return $val;
    }
}
