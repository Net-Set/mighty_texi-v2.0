<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DriverService extends Model
{
    use HasFactory;

    protected $fillable = [ 'driver_id', 'service_id', 'status' ];

    public function driver() {
        return $this->belongsTo( User::class, 'driver_id', 'id');
    }

    public function service() {
        return $this->belongsTo( Service::class, 'service_id', 'id');
    }
}
