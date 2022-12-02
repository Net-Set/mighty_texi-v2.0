<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class CouponResource extends JsonResource
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
            'id'            => $this->id,
            'code'          => $this->code,
            'title'         => $this->title,
            'coupon_type'   => $this->coupon_type,
            'discount_type' => $this->discount_type,
            'discount'      => $this->discount,
            'start_date'    => $this->start_date,
            'end_date'      => $this->end_date,
            'status'        => $this->status,
            'description'   => $this->description,
            'service_ids'   => $this->service_ids,
            'region_ids'    => $this->region_ids,
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
            'usage_limit_per_rider' => $this->usage_limit_per_rider,
        ];
    }
}
