<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class PaymentGateway extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $fillable = [ 'title', 'type', 'status', 'is_test', 'test_value', 'live_value' ];

    protected $casts = [
        'status' => 'integer',
        'is_test' => 'integer',
    ];
    public function getTestValueAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        return $val;
    }

    public function setTestValueAttribute($value)
    {
        // $value = isset($value) ? json_decode($value,true) : null;
        $this->attributes['test_value'] = json_encode($value);
    }

    public function getLiveValueAttribute($value)
    {
        $val = isset($value) ? json_decode($value, true) : null;
        return $val;
    }

    public function setLiveValueAttribute($value)
    {
        // $value = isset($value) ? json_decode($value,true) : null;
        $this->attributes['live_value'] = json_encode($value);
    }
}
