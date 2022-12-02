<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class RideRequestResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        
        return [
            'id'                => $this->id,
            'rider_id'          => $this->rider_id,
            'service_id'        => $this->service_id,
            'datetime'          => $this->datetime,
            'is_schedule'       => $this->is_schedule,
            'ride_attempt'      => $this->ride_attempt,
            'otp'               => $this->otp,
            'total_amount'      => $this->total_amount,
            'subtotal'          => $this->subtotal,
            'extra_charges_amount'  => $this->extra_charges_amount,
            'driver_id'         => $this->driver_id,
            'driver_name'       => optional($this->driver)->display_name,
            'rider_name'        => optional($this->rider)->display_name,
            'driver_email'       => optional($this->driver)->email,
            'rider_email'        => optional($this->rider)->email,
            'driver_contact_number' => optional($this->driver)->contact_number,
            'rider_contact_number'  => optional($this->rider)->contact_number,
            'driver_profile_image' => getSingleMedia(optional($this->driver), 'profile_image',null),
            'rider_profile_image' => getSingleMedia(optional($this->rider), 'profile_image',null),
            'start_latitude'    => $this->start_latitude,
            'start_longitude'   => $this->start_longitude,
            'start_address'     => $this->start_address,
            'end_latitude'      => $this->end_latitude,
            'end_longitude'     => $this->end_longitude,
            'end_address'       => $this->end_address,
            'distance_unit'     => $this->distance_unit,
            'start_time'        => $this->rideRequestStartTime() ?? null,
            'end_time'          => $this->rideRequestCompletedTime() ?? null,
            'riderequest_in_driver_id' => $this->riderequest_in_driver_id,
            'distance'          => $this->distance,
            'duration'          => $this->duration,
            'seat_count'        => $this->seat_count,
            'reason'            => $this->reason,
            'status'            => $this->status,
            'tips'              => $this->tips,
            'base_fare'         => $this->base_fare,
            'minimum_fare'      => $this->minimum_fare,
            'per_distance'      => $this->per_distance,
            'per_distance_charge' => $this->per_distance_charge,
            'per_minute_drive'  => $this->per_minute_drive,
            'per_minute_drive_charge' => $this->per_minute_drive_charge,
            'per_minute_waiting'=> $this->per_minute_waiting,
            'waiting_time'      => $this->waiting_time,
            'waiting_time_limit'    => $this->waiting_time_limit,
            'per_minute_waiting_charge'  => $this->per_minute_waiting_charge,
            'cancelation_charges'   => $this->cancelation_charges,
            'cancel_by'         => $this->cancel_by,
            'payment_id'        => optional($this->payment)->id,
            'payment_type'      => $this->payment_type,
            'payment_status'    => optional($this->payment)->payment_status ?? 'pending',
            'extra_charges'     => $this->extra_charges,
            'coupon_discount'   => $this->coupon_discount,
            'coupon_code'       => $this->coupon_code,
            'coupon_data'       => $this->coupon_data,
            'is_rider_rated'    => $this->is_rider_rated,
            'is_driver_rated'   => $this->is_driver_rated,
            'max_time_for_find_driver_for_ride_request' => $this->max_time_for_find_driver_for_ride_request,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
        ];
    }
}