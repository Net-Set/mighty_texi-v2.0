<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\RideRequest;
use App\Models\Setting;
use App\Models\Region;
use App\Models\User;
use App\Models\AppSetting;
use App\Http\Resources\SettingResource;
use App\Http\Resources\RegionResource;
use App\Http\Resources\UserResource;
use App\Http\Resources\RiderDashboardResource;
use App\Http\Resources\DriverDashboardResource;
use Grimzy\LaravelMysqlSpatial\Types\Point;

class DashboardController extends Controller
{
    public function adminDashboard(Request $request)
    {
        
        $dashboard_data = $this->commonDashboard($request);

        return json_custom_response($dashboard_data);
    }

    public function riderDashboard(Request $request)
    {

        $dashboard_data = $this->commonDashboard($request);

        return json_custom_response($dashboard_data);
    }

    public function commonDashboard($request)
    {
        $region = Region::where('status', 1);
        $region->when(request('region_id'), function ($q) {
            return $q->where('id', request('region_id'));
        });
        if( $request->has('latitude') && isset($request->latitude) && $request->has('longitude') && isset($request->longitude) )
        {
            $point = new Point($request->latitude, $request->longitude);
            $region->contains('coordinates', $point);
        }
        $region = $region->first();
        $data['region'] = new RegionResource($region);
        $data['app_seeting'] = AppSetting::first();
        
        $data['terms_condition'] = Setting::where('type','terms_condition')->where('key','terms_condition')->first();
        $data['privacy_policy'] = Setting::where('type','privacy_policy')->where('key','privacy_policy')->first();

        $ride_setting = Setting::where('type','ride')->get();
        $data['ride_setting'] = SettingResource::collection($ride_setting);

        $wallet_setting = Setting::where('type','wallet')->get();
        $data['Wallet_setting'] = SettingResource::collection($wallet_setting);

        $currency_code = SettingData('CURRENCY', 'CURRENCY_CODE') ?? 'USD';
        $currency = currencyArray($currency_code);
        
        $data['currency_setting'] = [
            'name' => $currency['name'] ?? 'United States (US) dollar',
            'symbol' => $currency['symbol'] ?? '$',
            'code' => strtolower($currency['code']) ?? 'usd',
            'position' => SettingData('CURRENCY', 'CURRENCY_POSITION') ?? 'left',
        ];
        return $data;
    }

    public function currentRideRequest(Request $request)
    {
        $auth_user = auth()->user();
        $user = User::find($auth_user->id);
        $response = null;

        if($user->hasRole('driver')) {
            $response = new DriverDashboardResource($user);
        } else {
            $response = new RiderDashboardResource($user);            
        }
        return json_custom_response($response);
    }
}
