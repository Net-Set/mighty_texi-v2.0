<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DocumentResource extends JsonResource
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
            'name'              => $this->name,
            'status'            => $this->status,
            'is_required'       => $this->is_required,
            'has_expiry_date'   => $this->has_expiry_date,
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at
        ];
    }
}