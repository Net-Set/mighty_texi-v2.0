<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class WalletHistoryResource extends JsonResource
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
            'type'              => $this->type,
            'transaction_type'  => $this->transaction_type,
            'currency'          => $this->currency,
            'amount'            => $this->amount,
            'balance'           => $this->balance,
            'wallet_balance'    => optional($this->wallet_user)->total_amount,
            'datetime'          => $this->datetime,
            'ride_request_id'   => $this->ride_request_id,
            'description'       => $this->description,
            'data'              => $this->data,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
        ];
    }
}