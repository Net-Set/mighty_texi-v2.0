<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ServiceResource extends JsonResource
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
            'name'              => $this->name,
            'region_id'         => $this->region_id,
            'region'            => new RegionResource($this->region),
            'capacity'          => $this->capacity,
            'base_fare'         => $this->base_fare,
            'minimum_fare'      => $this->minimum_fare,
            'minimum_distance'  => $this->minimum_distance,
            'per_distance'      => $this->per_distance,
            'per_minute_drive'  => $this->per_minute_drive,
            'per_minute_wait'   => $this->per_minute_wait,
            'waiting_time_limit'=> $this->waiting_time_limit,
            'cancellation_fee'  => $this->cancellation_fee,
            'payment_method'    => $this->payment_method,
            'commission_type'   => $this->commission_type,
            'admin_commission'  => $this->admin_commission,
            'fleet_commission'  => $this->fleet_commission,
            'service_image'     => getSingleMedia($this, 'service_image',null),
            'status'            => $this->status,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
        ];
    }
}