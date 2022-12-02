<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;

class User extends Authenticatable implements HasMedia
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles, InteractsWithMedia;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'first_name', 'last_name', 'email', 'password', 'username', 'contact_number', 'gender', 'email_verified_at', 'address', 'user_type', 'player_id', 'fcm_token', 'fleet_id', 'latitude', 'longitude', 'last_notification_seen', 'status', 'is_online', 'is_available', 'uid', 'login_type', 'display_name', 'timezone', 'service_id', 'is_verified_driver'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'is_available'  => 'integer',
    ];

    public function userDetail() {
        return $this->hasOne(UserDetail::class, 'user_id', 'id');
    }

    public function userBankAccount() {
        return $this->hasOne(UserBankAccount::class, 'user_id', 'id');
    }

    public function fleet() {
        return $this->belongsTo(User::class, 'fleet_id', 'id');
    }

    public function userWallet() {
        return $this->hasOne(Wallet::class, 'user_id', 'id');
    }

    public function scopeAdmin($query) {
        return $query->where('user_type', 'admin')->first();
    }

    public function scopeGetUser($query, $user_type=null)
    {
        $auth_user = auth()->user();

        if( $auth_user->hasAnyRole(['admin']) ) {
            $query->where('user_type', $user_type)->where('status','active');
            return $query;
        }
        if( $auth_user->hasRole('fleet') ) {
            return $query->where('user_type', 'driver')->where('fleet_id', $auth_user->id);
        }
    }

    public function riderRideRequestDetail() {
        return $this->hasMany(RideRequest::class, 'rider_id', 'id');
    }

    public function driverRideRequestDetail() {
        return $this->hasMany(RideRequest::class, 'driver_id', 'id');
    }

    public function driverDocument(){
        return $this->hasMany(DriverDocument::class, 'driver_id', 'id');
    }

    public function service() {
        return $this->belongsTo(Service::class, 'service_id', 'id');
    }

    public function riderRating(){
        return $this->hasMany(RideRequestRating::class, 'rider_id', 'id');
    }

    public function driverRating(){
        return $this->hasMany(RideRequestRating::class, 'driver_id', 'id');
    }

    public function routeNotificationForOneSignal()
    {
        return $this->player_id;
    }

    public function routeNotificationForFcm($notification)
    {
        return $this->fcm_token;
    }

    public function userWithdraw(){
        return $this->hasMany(WithdrawRequest::class, 'user_id', 'id');
    }

    protected static function boot(){
        parent::boot();
        static::deleted(function ($row) {
            $row->userDetail()->delete();
            $row->userWithdraw()->delete();
            $row->userWallet()->delete();
            switch ($row->user_type) {
                case 'rider':
                    $row->riderRideRequestDetail()->delete();
                    break;
                case 'driver':
                    $row->userBankAccount()->delete();
                    $row->driverDocument()->delete();
                    $row->driverRideRequestDetail()->delete();
                    break;
                default:
                    # code...
                    break;
            }
        });
    }
}
