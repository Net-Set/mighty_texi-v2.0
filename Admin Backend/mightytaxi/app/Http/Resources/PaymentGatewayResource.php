<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PaymentGatewayResource extends JsonResource
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
            'id'        => $this->id,
            'title'     => $this->title,
            'type'      => $this->type,
            'status'    => $this->status,
            'is_test'   => $this->is_test,
            'test_value'=> $this->test_value,
            'live_value'=> $this->live_value,
            'gateway_image' =>  getSingleMedia($this, 'gateway_image', null),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,            
        ];
    }
}
