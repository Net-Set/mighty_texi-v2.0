<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Coupon extends Model
{
    use HasFactory;

    protected $fillable = [
        'code', 'title', 'coupon_type', 'usage_limit_per_rider', 'discount_type', 'discount', 'start_date', 'end_date', 'minimum_amount', 'maximum_discount', 'status', 'description', 'service_ids', 'region_ids' 
    ];
    
    protected $casts = [
        'discount'  => 'double',
        'status'    => 'integer',
        'minimum_amount' => 'double',
        'maximum_discount' => 'double',
    ];

    public function getStartDateAttribute($value)
    {
        return $this->attributes['start_date'] = Carbon::parse($value)->format('Y-m-d');
    }

    public function getEndDateAttribute($value)
    {
        return $this->attributes['end_date'] = Carbon::parse($value)->format('Y-m-d');
    }
    
    public function getRegionIdsAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        
        return $val;
    }

    public function setRegionIdsAttribute($value)
    {
        $this->attributes['region_ids'] = isset($value) ? json_encode($value) : null;
    }

    public function getServiceIdsAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        return $val;
    }

    public function setServiceIdsAttribute($value)
    {
        $this->attributes['service_ids'] = isset($value) ? json_encode($value) : null;
    }

    public static function isValidCoupon( $coupon_data )
    {
        $service_id = request('service_id');
        $start_date = Carbon::parse($coupon_data->start_date);
        $end_date = Carbon::parse($coupon_data->end_date);

        $today = Carbon::now();
        
        if( $today->format('Y-m-d') > $end_date->format('Y-m-d') )
        {
            return 400; // coupon expire
        } elseif ($start_date->format('Y-m-d') > $today->format('Y-m-d') || $end_date->format('Y-m-d') < $today->format('Y-m-d')) {
            return 405;
        }
        
        switch ($coupon_data->coupon_type) {
            case 'first_ride':
                $total = RideRequest::where('rider_id',request('rider_id'))->count();
                return $total < $coupon_data->usage_limit_per_rider ? 200 : 406 ;
                break;
            case 'region_wise':
                if(isset($coupon_data->region_ids)) {
                    $data = Service::whereIn('region_id', $coupon_data->region_ids)->where('id', $service_id)->first();
                    if(!$data) {
                        return 404;
                    }
                }
                break;
            case 'service_wise':
                if(isset($coupon_data->service_ids)) {
                    return !in_array($service_id, $coupon_data->service_ids) ? 200 : 400 ;
                }
                break;
            default:
                # code...
                break;
        }

        $total = RideRequest::where('rider_id', request('rider_id'))->where('coupon_code',$coupon_data->code)->count();
        if ($total < $coupon_data->usage_limit_per_rider) {
            return 200;
        } else {
            return 407;// Limited  
        }

        return 404; // not found
    }
}
