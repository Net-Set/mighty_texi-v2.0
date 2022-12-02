<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;

    protected $fillable = [ 'driver_id', 'rider_id', 'ride_request_id', 'driver_rating', 'rider_rating', 'driver_review', 'rider_review' ];
}
