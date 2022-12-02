<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Sos;
use Illuminate\Database\Eloquent\Builder;
class DriverDashboardResource extends JsonResource
{
    public function toArray($request)
    {
        $on_ride_request = $this->driverRideRequestDetail()->whereNotIn('status', ['canceled'])->where('is_driver_rated',false)
                        // ->whereHas('payment',function ($q) {
                        //     $q->whereNull('payment_status')->orWhere('payment_status', 'pending');
                        // })
                        ->first();
        
        $pending_payment_ride_request = $this->driverRideRequestDetail()->where('status', 'completed')->where('is_driver_rated',true)
                        ->whereHas('payment',function ($q) {
                            $q->where('payment_status', 'pending');
                        })
                        ->first();
        $rider = isset($on_ride_request) && optional($on_ride_request->rider) ? $on_ride_request->rider :  null;
        $payment = isset($pending_payment_ride_request) && optional($pending_payment_ride_request->payment) ? $pending_payment_ride_request->payment : null;
        
        return [
            'id'                => $this->id,
            'display_name'      => $this->display_name,
            'email'             => $this->email,
            'username'          => $this->username,
            'user_type'         => $this->user_type,
            'profile_image'     => getSingleMedia($this, 'profile_image',null),
            'status'            => $this->status,
            'latitude'          => $this->latitude,
            'longitude'         => $this->longitude,
            // 'sos'               => Sos::mySOs()->get(),
            'on_ride_request'   => isset($on_ride_request) ? new RideRequestResource($on_ride_request) : null,
            'rider'             => isset($rider) ? new UserResource($rider) : null,
            'payment'           => isset($payment) ? new PaymentResource($payment) : null,
        ];
    }
}