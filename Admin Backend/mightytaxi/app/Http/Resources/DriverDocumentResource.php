<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DriverDocumentResource extends JsonResource
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
            'driver_id'         => $this->driver_id,
            'document_id'       => $this->document_id,
            'document_name'     => optional($this->document)->name,
            'driver_name'       => optional($this->driver)->display_name,
            'is_verified'       => $this->is_verified,
            'expire_date'       => $this->expire_date,
            'driver_document'   => getSingleMedia($this, 'driver_document',null),
            'created_at'        => $this->created_at,
            'updated_at'        => $this->updated_at
        ];
    }
}