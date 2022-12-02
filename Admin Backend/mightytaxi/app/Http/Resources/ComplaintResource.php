<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ComplaintResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            'id'                => $this->id,
            'ride_request_id'   => $this->ride_request_id,
            'driver_id'         => $this->driver_id,
            'rider_id'          => $this->rider_id,
            'complaint_by'      => $this->complaint_by,
            'subject'           => $this->subject,
            'description'       => $this->description,
            'driver_name'       => optional($this->driver)->display_name,
            'rider_name'        => optional($this->rider)->display_name,
            'driver_profile_image' => getSingleMedia(optional($this->driver), 'profile_image',null),
            'rider_profile_image' => getSingleMedia(optional($this->rider), 'profile_image',null),
            'status'            => $this->status,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at
        ];
    }
}