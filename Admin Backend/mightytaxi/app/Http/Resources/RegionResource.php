<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class RegionResource extends JsonResource
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
            'id'            => $this->id,
            'name'          => $this->name,
            'distance_unit' => $this->distance_unit,
            'status'        => $this->status,
            'timezone'      => $this->timezone,
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
        ];
    }
}