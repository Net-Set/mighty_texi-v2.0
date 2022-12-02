<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\RideRequest;
use App\DataTables\RideRequestDataTable;
use App\Http\Requests\RideRequestRequest;
use App\Models\Coupon;
use App\Models\Payment;
use App\Models\Service;
use Illuminate\Support\Facades\DB;
use App\Traits\PaymentTrait;
use App\Traits\RideRequestTrait;
use App\Jobs\NotifyViaMqtt;
use App\Http\Resources\RideRequestResource;

class RideRequestController extends Controller
{
    use PaymentTrait, RideRequestTrait;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(RideRequestDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.riderequest')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.riderequest')]);
        
        return view('riderequest.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();

        // Check if the rider has registred a riderequest already
        $rider_exists_riderequest = RideRequest::whereNotIn('status', ['canceled', 'completed'])->where('rider_id', auth()->user()->id)->where('is_schedule', 0)->exists();
        
        if($rider_exists_riderequest) {
            return json_message_response(__('message.rider_already_in_riderequest'), 400);
        }
        
        $coupon_code = $request->coupon_code;

        if( $coupon_code != null ) {
            $coupon = Coupon::where('code', $coupon_code)->first();
            $status = isset($coupon_code) ? 400 : 200;
        
            if($coupon != null) {
                $status = Coupon::isValidCoupon($coupon);
            }
            if( $status != 200 ) {
                $response = couponVerifyResponse($status);
                return json_custom_response($response,$status);
            } else {
                $data['coupon_code'] = $coupon->id;
                $data['coupon_data'] = $coupon;
            }
        }

        $service = Service::with('region')->where('id',$request->service_id)->first();
        $data['distance_unit'] = $service->region->distance_unit ?? 'km';
        
        $result = RideRequest::create($data);

        $message = __('message.save_form', ['form' => __('message.riderequest')]);

        if( $result->status == 'new_ride_requested' ) {

            $history_data = [
                'ride_request_id'   => $result->id,
                'history_type'      => $result->status,
                'ride_request'      => $result,
            ];
            saveRideHistory($history_data);
            $this->acceptDeclinedRideRequest($result,$request->all());
        } else {
            $history_data = [
                'history_type'      => $result->status,
                'ride_request_id'   => $result->id,
                'ride_request'      => $result,
            ];
    
            saveRideHistory($history_data);
        }
        if($request->is('api/*')) {
            $response = [
                'riderequest_id' => $result->id,
                'message' => $message
            ];
            return json_custom_response($response);
		}

        return redirect()->route('riderequest.index')->withSuccess($message);
    }

    public function acceptRideRequest(Request $request)
    {
        $riderequest = RideRequest::find($request->id);

        if($riderequest == null) {
            $message = __('message.not_found_entry', ['name' => __('message.riderequest')]);
            return json_message_response($message);
        }

        if( request()->has('is_accept') && request('is_accept') == 1 ) {
            $riderequest->driver_id = request('driver_id');
            $riderequest->status = 'accepted';
            $riderequest->max_time_for_find_driver_for_ride_request = 0;
            $riderequest->otp = rand(1000, 9999);
            $riderequest->riderequest_in_driver_id = null;
            $riderequest->riderequest_in_datetime = null;
            $riderequest->save();
            $result = $riderequest;

            $history_data = [
                'history_type'      => 'accepted',
                'ride_request_id'   => $result->id,
                'ride_request'      => $result,
            ];
    
            saveRideHistory($history_data);
            $riderequest->driver->update(['is_available' => 0]);
        } else {
            $result = $this->acceptDeclinedRideRequest($riderequest, $request->all());
        }

        $message = __('message.updated');
        if( $result->driver_id == null ) {
            $message = __('message.save_form',[ 'form' => __('message.riderequest') ] );
        }
        if($request->is('api/*')) {
            $response = [
                'ride_request_id' => $result->id,
                'message' => $message
            ];
            return json_custom_response($response);
		}
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        if (!auth()->user()->can('riderequest show')) {
            abort(403, __('message.action_is_unauthorized'));
        }
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.riderequest')]);
        $data = RideRequest::findOrFail($id);

        return view('riderequest.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.riderequest')]);
        $data = RideRequest::findOrFail($id);
        
        return view('riderequest.form', compact('data', 'pageTitle', 'id'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(RideRequestRequest $request, $id)
    {
        $riderequest = RideRequest::findOrFail($id);

        if( $request->has('otp') ) {
            if($riderequest->otp != $request->otp) {
                return json_message_response(__('message.otp_invalid'), 400);
            }
        }
        // RideRequest data...
        $riderequest->fill($request->all())->update();
        $message = __('message.update_form',[ 'form' => __('message.riderequest') ] );
        if($riderequest->status == 'new_ride_requested') {
            if($riderequest->riderequest_in_driver_id == null) {
                $this->acceptDeclinedRideRequest($riderequest, $request->all());
            }
            if($request->is('api/*')) {
                return json_message_response($message);
            }
        }
        $payment = Payment::where('ride_request_id',$id)->first();

        if( $request->has('is_change_payment_type') && request('is_change_payment_type') == 1 )
        {
            $payment->update(['payment_type' => request('payment_type')]);

            $message = __('message.change_payment_type');
            $notify_data = new \stdClass();
            $notify_data->success = true;
            $notify_data->success_type = 'change_payment_type';
            $notify_data->success_message = $message;
            $notify_data->result = new RideRequestResource($riderequest);
            
            dispatch(new NotifyViaMqtt('ride_request_status_'.$riderequest->driver_id, json_encode($notify_data)));

            return json_message_response($message);
        }
        
        $history_data = [
            'history_type'      => request('status'),
            'ride_request_id'   => $id,
            'ride_request'      => $riderequest,
        ];

        saveRideHistory($history_data);

        if($request->is('api/*')) {
            return json_message_response($message);
		}

        if(auth()->check()){
            return redirect()->route('riderequest.index')->withSuccess(__('message.update_form',['form' => __('message.riderequest')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.riderequest') ] ));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if(env('APP_DEMO')){
            $message = __('message.demo_permission_denied');
            if(request()->ajax()) {
                return response()->json(['status' => true, 'message' => $message ]);
            }
            return redirect()->route('riderequest.index')->withErrors($message);
        }
        $riderequest = RideRequest::find($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.riderequest')]);

        if($riderequest != '') {
            $riderequest->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.riderequest')]);
        }

        if(request()->is('api/*')){
            return json_message_response( $message );
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
