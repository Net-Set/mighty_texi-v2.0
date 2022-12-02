<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Sos;
use App\Http\Resources\SosResource;
use App\Notifications\RideNotification;
use App\Notifications\CommonNotification;
use App\Models\User;

class SosController extends Controller
{
    public function getList(Request $request)
    {
        $sos = Sos::mySos();

        $sos->when(request('region_id'), function ($q) {
            return $q->where('region_id', request('region_id'));
        });

        $sos->when(request('title'), function ($q) {
            return $q->where('title', 'LIKE', '%' . request('title') . '%');
        });

        if( $request->has('status') && isset($request->status) ) {
            $sos = $sos->where('status',request('status'));
        }
        
        $per_page = config('constant.PER_PAGE_LIMIT');
        if( $request->has('per_page') && !empty($request->per_page)){
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }
            if($request->per_page == -1 ){
                $per_page = $sos->count();
            }
        }

        $sos = $sos->orderBy('title','asc')->paginate($per_page);
        $items = SosResource::collection($sos);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }

    public function adminSosNotify(Request $request)
    {
        $admin = User::admin();
        $user = auth()->user();
        
        $data = $request->all();

        $notification_data = [
            'id'        => $request->ride_request_id,
            'created_by'=> $user->id,
            'type'      => 'sos',
            'subject'   => __('message.sos_request.title', [ 'id' => $request->ride_request_id ]),
            'message'   => __('message.sos_request.message', [ 'name' => __('message.'.$user->user_type)]),
            'latitude'  => $request->latitude,
            'longitude' => $request->longitude,
        ];

        // $admin->notify(new CommonNotification('sos',$notification_data));
        $admin->notify(new RideNotification($notification_data));
        return json_message_response( __('message.noify_admin') );
    }
}