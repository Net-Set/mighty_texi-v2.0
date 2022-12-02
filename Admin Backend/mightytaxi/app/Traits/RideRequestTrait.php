<?php

namespace App\Traits;

use Illuminate\Http\Request;
use App\Models\RideRequest;
use App\Models\User;
use App\Models\Setting;
use App\Notifications\CommonNotification;
use App\Jobs\NotifyViaMqtt;
use App\Http\Resources\RideRequestResource;
use Carbon\Carbon;

trait RideRequestTrait {

    public function acceptDeclinedRideRequest($ride_request,$request_data = null)
    {
        $unit = $ride_request->distance_unit ?? 'km';
        $unit_value = convertUnitvalue($unit);
        $radius = Setting::where('type','DISTANCE')->where('key','DISTANCE_RADIUS')->pluck('value')->first() ?? 50;
                    
        $latitude = $ride_request->start_latitude;
        $longitude = $ride_request->start_longitude;

        $unit_value = convertUnitvalue($unit);
        $cancelled_driver_ids = [];
        $cancelled_driver_ids = $ride_request->cancelled_driver_ids;
        if( request()->has('is_accept') && request('is_accept') == 0 ) {
            array_push($cancelled_driver_ids, auth()->user()->id);
        }
        $minumum_amount_get_ride = SettingData('wallet', 'min_amount_to_get_ride') ?? null;
        $nearby_driver = User::selectRaw("id, user_type, player_id, latitude, longitude, ( $unit_value * acos( cos( radians($latitude) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians($longitude) ) + sin( radians($latitude) ) * sin( radians( latitude ) ) ) ) AS distance")
                        ->where('user_type', 'driver')->where('status', 'active')->where('is_online',1)->where('is_available',1)
                        ->where('service_id', $ride_request->service_id )
                        ->whereNotIn('id', $cancelled_driver_ids)
                        ->having('distance', '<=', $radius)
                        ->orderBy('distance','asc');
        if( $minumum_amount_get_ride != null ) {
            $nearby_driver = $nearby_driver->whereHas('userWallet', function($q) use($minumum_amount_get_ride) {
                $q->where('total_amount', '>=', $minumum_amount_get_ride);
            });
        }
        $nearby_driver = $nearby_driver->first();
        
        // \Log::info('nearby_driver-'.$nearby_driver);

        if( $nearby_driver != null )
        {
            $data['riderequest_in_driver_id'] = $nearby_driver->id;
            $data['riderequest_in_datetime'] = Carbon::now()->format('Y-m-d H:i:s');
            $notification_data = [
                'id' => $ride_request->id,
                'type' => 'new_ride_requested',
                'data' => [
                    'rider_id' => $ride_request->rider_id,
                    'rider_name' => optional($ride_request->rider)->display_name ?? '',
                ],
                'message' => __('message.new_ride_requested'),
                'subject' => __('message.ride.new_ride_requested'),
            ];
            $notify_data = new \stdClass();
            $notify_data->success = true;
            $notify_data->success_type = $ride_request->status;
            $notify_data->success_message = __('message.ride.new_ride_requested');
            $notify_data->result = new RideRequestResource($ride_request);
            
            $nearby_driver->notify(new CommonNotification($notification_data['type'], $notification_data));
            dispatch(new NotifyViaMqtt('new_ride_request_'.$nearby_driver->id, json_encode($notify_data), $nearby_driver->id));
        } else {
            $data['riderequest_in_driver_id'] = null;
            $data['riderequest_in_datetime'] = null;
        }
        
        $data['cancelled_driver_ids'] = $cancelled_driver_ids;
        // $data['cancelled_driver_ids'] = array_key_exists('cancelled_driver_ids',$request_data) ? $request_data['cancelled_driver_ids'] : null;
        $ride_request->fill($data)->update();
        return $ride_request;
    }
}