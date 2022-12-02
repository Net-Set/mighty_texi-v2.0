<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    use HasFactory;
    protected $fillable = [ 'name', 'type', 'status', 'is_required', 'has_expiry_date' ];

    protected $casts = [
        'status' => 'integer',
        'has_expiry_date' => 'integer',
        'is_required' => 'integer',
    ];

    public function driverDocument()
    {
        return $this->hasMany(DriverDocument::class, 'document_id', 'id' );
    }
}
