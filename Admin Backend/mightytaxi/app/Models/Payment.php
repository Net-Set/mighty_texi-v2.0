<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;

    protected $fillable = [ 'rider_id', 'ride_request_id', 'datetime', 'total_amount', 'admin_commission', 'driver_commission', 'received_by', 'driver_fee', 'driver_tips', 'fleet_commission', 'payment_type', 'txn_id', 'payment_status', 'transaction_detail' ];

    protected $casts = [
        'rider_id'          => 'integer',
        'ride_request_id'   => 'integer',
        'total_amount'      => 'double',
        'admin_commission'   => 'double',
        'driver_fee'        => 'double',
        'driver_tips'       => 'double',
        'driver_commission' => 'double',
        'fleet_commission'   => 'double',
    ];

    public function rider() {
        return $this->belongsTo(User::class, 'rider_id', 'id');
    }

    public function riderequest(){
        return $this->belongsTo(RideRequest::class, 'ride_request_id', 'id');
    }

    public function scopeMyPayment($query)
    {
        $user = auth()->user();

        if($user->hasAnyRole(['admin','demo_admin']) ) {
            return $query;
        }

        if($user->hasRole('rider')) {
            return $query->where('rider_id', $user->id);
        }

        if($user->hasRole('driver')) {
            return $query->whereHas('riderequest',function ($q) use($user) {
                $q->where('driver_id',$user->id);
            });
        }

        return $query;
    }

    public function getDataAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        return $val;
    }

    public function setDataAttribute($value)
    {
        $this->attributes['data'] = isset($value) ? json_encode($value) : null;
    }

    public function walletTransfer($payment)
    {
        
    }
}
