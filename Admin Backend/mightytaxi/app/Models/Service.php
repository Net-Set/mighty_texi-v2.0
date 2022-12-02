<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class Service extends Model implements HasMedia
{
    use HasFactory, InteractsWithMedia;

    protected $fillable = [ 'name', 'region_id', 'capacity', 'base_fare', 'minimum_fare', 'minimum_distance', 'per_distance', 'per_minute_drive', 'per_minute_wait', 'waiting_time_limit', 'payment_method', 'commission_type', 'admin_commission', 'fleet_commission', 'status', 'cancellation_fee' ];

    protected $casts = [
        'region_id'         => 'integer',
        'capacity'          => 'integer',
        'status'            => 'integer',
        'base_fare'         => 'double',
        'minimum_fare'      => 'double',
        'minimum_distance'  => 'double',
        'per_distance'      => 'double',
        'per_minute_drive'  => 'double',
        'per_minute_wait'   => 'double',
        'waiting_time_limit'=> 'double',
        'cancellation_fee'  => 'double',
        'admin_commission'  => 'double',
        'fleet_commission'  => 'double',
    ];
    public function region() {
        return $this->belongsTo( Region::class, 'region_id', 'id');
    }
}
