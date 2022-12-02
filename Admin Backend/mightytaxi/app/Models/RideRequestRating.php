<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RideRequestRating extends Model
{
    use HasFactory;
    
    protected $fillable = [ 'ride_request_id', 'rider_id', 'driver_id', 'rating', 'comment', 'rating_by' ];

    protected $casts = [
        'ride_request_id'   => 'integer',
        'rider_id'          => 'integer',
        'driver_id'         => 'integer',
        'rating'            => 'double',
    ];
    public function riderequest(){
        return $this->belongsTo(RideRequest::class, 'ride_request_id', 'id');
    }

    public function driver(){
        return $this->belongsTo(User::class, 'driver_id', 'id');
    }

    public function rider(){
        return $this->belongsTo(User::class, 'rider_id', 'id');
    }
}
