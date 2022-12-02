<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Grimzy\LaravelMysqlSpatial\Eloquent\SpatialTrait;
class Region extends Model
{
    use HasFactory, SpatialTrait;
    
    protected $fillable = [ 'name', 'distance_unit', 'status', 'timezone' ];

    protected $spatialFields = [
        'coordinates'
    ];

    public function regionSos(){
        return $this->hasMany(regionSos::class, 'region_id', 'id');
    }

}
