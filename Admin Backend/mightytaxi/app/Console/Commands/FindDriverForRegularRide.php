<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\RideRequest;
use App\Models\User;
use App\Models\Setting;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Notifications\CommonNotification;
use App\Jobs\NotifyViaMqtt;
use App\Http\Resources\RideRequestResource;
class FindDriverForRegularRide extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'find_driver:for_regular_ride';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Find Drivers for Regular Ride';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $current_time = Carbon::now()->format('Y-m-d H:i:s');
        $minus_5 = Carbon::now()->subMinutes(5)->format('Y-m-d H:i:s');

        $requested_ride = RideRequest::where('is_schedule',0)
                ->where('created_at', '<=', $current_time)->where('created_at', '>', $minus_5)
                // ->whereHas('rideRequestHistory',function ($q){
                //     $q->where('history_type','!=','completed')->where('history_type','!=','canceled')->where('history_type','!=','in_progress');
                // });
                ->where('status', 'new_ride_requested')
                ->get();

        if ( count($requested_ride) == 0 ) {
            return $this->info('regular-ride-not-found');
        }

        foreach ($requested_ride as $key => $ride_request) {
            $unit = $ride_request->distance_unit;
            $unit_value = convertUnitvalue($unit);
            
            $radius = Setting::where('type','DISTANCE')->where('key','DISTANCE_RADIUS')->pluck('value')->first() ?? 50;
            $latitude = $ride_request->start_latitude;
            $longitude = $ride_request->start_longitude;

            $driver = User::selectRaw("id, user_type, player_id, latitude, longitude, ( $unit_value * acos( cos( radians($latitude) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians($longitude) ) + sin( radians($latitude) ) * sin( radians( latitude ) ) ) ) AS distance")
                        ->where('status', 'active')->where('is_online',1)->where('is_available',1)
                        ->where('service_id', $ride_request->service_id )
                        ->whereNotIn('id', $ride_request->cancelled_driver_ids)
                        ->having('distance', '<=', $radius)->orderBy('distance','asc')
                        ->first();

            if( $driver != null) {
                $notification_data = [
                    'id'        => $ride_request->id,
                    'type'      => 'new_ride_requested',
                    'subject'   => __('message.new_ride_requested'),
                    'message'   => __('message.ride.new_ride_requested'),
                ];
                $ride_request->update([
                    'riderequest_in_driver_id' => $driver->id,
                    'riderequest_in_datetime' => Carbon::now()->format('Y-m-d H:i:s'),
                ]);
                $driver->notify(new CommonNotification($notification_data['type'], $notification_data));

                $notify_data = new \stdClass();
                $notify_data->success = true;
                $notify_data->success_type = $ride_request->status;
                $notify_data->success_message = __('message.ride.new_ride_requested');
                $notify_data->result = new RideRequestResource($ride_request);

                dispatch(new NotifyViaMqtt('new_ride_request_'.$driver->id, json_encode($notify_data), $driver->id));
            } else {
                $this->info('no-driver-found');
                // Update ride_attempt
                $ride_request->ride_attempt += 1;
                $ride_request->save();
                if ($ride_request->ride_attempt > 5) {
                    $driver_not_available = [];
                    $driver_not_available[0] = $ride_request->id;
                    $ride_request->status = 'canceled';
                    $ride_request->cancel_by = 'auto';
                    $ride_request->riderequest_in_driver_id = null;
                    $ride_request->riderequest_in_datetime = null;
                    $ride_request->save();
                    // dispatch no driver found
                }
            }
            $this->info('success');
        }
    }
}
