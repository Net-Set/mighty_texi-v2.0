<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class WithdrawRequestResource extends JsonResource
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
            'user_id'           => $this->user_id,
            'user_display_name' => optional($this->user)->display_name,
            'amount'            => $this->amount,
            'currency'          => $this->currency,
            'status'            => $this->status,            
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
        ];
    }
}