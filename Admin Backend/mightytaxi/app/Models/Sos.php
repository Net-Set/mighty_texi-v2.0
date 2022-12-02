<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sos extends Model
{
    use HasFactory;

    protected $fillable = [ 'region_id', 'title', 'contact_number', 'added_by', 'status' ];

    protected $casts = [
        'region_id' => 'integer',
        'added_by' => 'integer',
        'status' => 'integer',
    ];
    public function region() {
        return $this->belongsTo( Region::class, 'region_id', 'id');
    }

    public function scopemySos($query)
    {
        $user = auth()->user();

        if($user->hasAnyRole(['driver','rider'])){
            $query = $query->where('added_by', $user->id)->orWhere('added_by', User::admin()->id);
        } else {
            $query = $query->where('added_by', $user->id);
        }

        return $query;
    }
}
