<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Complaint extends Model
{
    use HasFactory;

    protected $fillable = [ 'driver_id', 'rider_id', 'complaint_by', 'subject', 'description', 'ride_request_id', 'status' ];

    public function driver() {
        return $this->belongsTo( User::class, 'driver_id', 'id');
    }

    public function rider() {
        return $this->belongsTo( User::class, 'rider_id', 'id');
    }

    public function riderequest() {
        return $this->belongsTo( RideRequest::class, 'rider_id', 'id');
    }

}
