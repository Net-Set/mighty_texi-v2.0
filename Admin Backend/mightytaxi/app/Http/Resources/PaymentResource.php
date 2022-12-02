<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PaymentResource extends JsonResource
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
            'id'                    => $this->id,
            'ride_request_id'       => $this->ride_request_id,
            'rider_id'              => $this->rider_id,
            'rider_name'            => optional($this->rider)->display_name,
            'datetime'              => $this->datetime,
            'total_amount'          => $this->total_amount,
            'received_by'           => $this->received_by,
            'admin_commission'       => $this->admin_commission,
            'fleet_commission'       => $this->fleet_commission,
            'driver_fee'            => $this->driver_fee,
            'driver_tips'           => $this->driver_tips,
            'driver_commission'     => $this->driver_commission,
            'txn_id'                => $this->txn_id,
            'payment_type'          => $this->payment_type,
            'payment_status'        => $this->payment_status,
            'transaction_detail'    => $this->transaction_detail,
            'created_at'            => $this->created_at,
            'updated_at'            => $this->updated_at,
        ];
    }
}