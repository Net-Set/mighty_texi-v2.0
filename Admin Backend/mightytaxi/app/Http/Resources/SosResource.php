<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class SosResource extends JsonResource
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
            'title'         => $this->title,
            'region_id'     => $this->region_id,
            'region'        => new RegionResource($this->region),
            'status'        => $this->status,
            'contact_number'=> $this->contact_number,
            'added_by'      => $this->added_by,
            'created_at'    => $this->created_at,
            'updated_at'    => $this->updated_at,
        ];
    }
}