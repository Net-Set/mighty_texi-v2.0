<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\DriverDocument;

class DriverResource extends JsonResource
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
            'first_name'        => $this->first_name,
            'last_name'         => $this->last_name,
            'display_name'      => $this->display_name,
            'email'             => $this->email,
            'username'          => $this->username,
            'status'            => $this->status,
            'user_type'         => $this->user_type,
            'address'           => $this->address,
            'contact_number'    => $this->contact_number,
            'gender'            => $this->gender,       
            'profile_image'     => getSingleMedia($this, 'profile_image',null),
            'login_type'        => $this->login_type,
            'latitude'          => $this->latitude,
            'longitude'         => $this->longitude,
            'uid'               => $this->uid,
            'player_id'         => $this->player_id,
            'is_online'         => $this->is_online,
            'is_available'      => $this->is_available,
            'timezone'          => $this->timezone,
            'fcm_token'         => $this->fcm_token,
            'user_detail'       => $this->userDetail,
            'user_bank_account' => $this->userBankAccount,
            'service_id'        => $this->service_id,
            'driver_service'    => $this->service ?? null,
            'is_verified_driver' => (int) $this->is_verified_driver,
            'last_notification_seen' => $this->last_notification_seen,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at,
            'rating'            => count($this->driverRating) > 0 ? (float) number_format(max($this->driverRating->avg('rating'),0), 2) : 0,
        ];
    }
}
