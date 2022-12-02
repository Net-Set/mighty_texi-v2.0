<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Service;
use App\Models\Document;
use App\Models\AppSetting;
use App\Models\WithdrawRequest;
use App\Models\User;
use App\Models\Complaint;
use App\Models\Payment;
use App\Models\PaymentGateway;
use App\Models\RideRequest;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use PhpMqtt\Client\Facades\MQTT;
use Illuminate\Support\Facades\App;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->middleware('auth');
    }
    
    /*
     * Dashboard Pages Routs
     */
    public function index(Request $request)
    {
        $auth_user = auth()->user();
        
        $data['dashboard'] = [
            'pending_driver' => User::where('user_type','driver')->where('is_verified_driver',0)->count(),
            'total_driver' => User::getUser('driver')->count(),
            'total_rider' => User::getUser('rider')->count(),
            'total_ride' => RideRequest::count(),
            'today_earning' => Payment::where('payment_status','paid')->whereDate('datetime', Carbon::today())->sum('total_amount'),
            'monthly_earning' => Payment::where('payment_status','paid')->whereMonth('datetime', Carbon::now()->month)->sum('total_amount'),
            'total_earning' => Payment::where('payment_status','paid')->sum('total_amount'),
            'complaint' => Complaint::where('status','pending')->count()
        ];

        $chart_data = [];

        $cash_payment = Payment::selectRaw('sum(total_amount) as total , DATE_FORMAT(datetime , "%m") as month' )
                        ->myPayment()
                        ->where('payment_status', 'paid')
                        ->where('payment_type', 'cash')
                        ->whereYear('datetime',date('Y'))
                        ->groupBy('month')
                        ->get()->toArray();
            
        for($i = 1; $i <= 12; $i++ ) {
            $paymentData = 0;
            foreach($cash_payment as $payment){
                if((int) $payment['month'] == $i){
                    $data['cash_yearly'][] = (int) $payment['total'];
                    $paymentData++;
                }
            }
            if($paymentData == 0) {
                $data['cash_yearly'][] = 0 ;
            }
        }

        $wallet_payment = Payment::selectRaw('sum(total_amount) as total , DATE_FORMAT(datetime , "%m") as month' )
                    ->myPayment()
                    ->where('payment_status', 'paid')
                    ->where('payment_type', 'wallet')
                    ->whereYear('datetime',date('Y'))
                    ->groupBy('month')
                    ->get()->toArray();
        for($i = 1; $i <= 12; $i++ ) {
            $paymentData = 0;
            foreach($wallet_payment as $payment){
                if((int) $payment['month'] == $i){
                    $data['wallet_yearly'][] = (int) $payment['total'];
                    $paymentData++;
                }
            }
            if($paymentData == 0) {
                $data['wallet_yearly'][] = 0 ;
            }
        }

        $recent_riderequest = RideRequest::myRide()->where('created_at','<=', Carbon::now()->format('Y-m-d H:i:s'))->orderBy('id', 'desc')->take(10)->get();
        return view('dashboards.admin-dashboard',compact('data', 'auth_user','recent_riderequest'));
    }

    public function changeLanguage($locale)
    {
        App::setLocale($locale);
        session()->put('locale', $locale);
        return redirect()->back();
    }

    public function chartdata(Request $request)
    {
        $type = $request->type ?? 'daily';
        $series = [];
        if( $type == 'daily' )
        {
            $series = [
                [
                    'name' => __('message.cash') ,
                    'data' => 100,
                ],
                [
                    'name' => __('message.wallet') ,
                    'data' => 1000,
                ],
            ];
        }

        if( $type == 'yearly' ) 
        {
            $cash_payment = Payment::selectRaw('count(Date(datetime)) as total , DATE_FORMAT(datetime , "%m") as month' )
                        ->myPayment()
                        ->where('payment_status', 'paid')
                        ->where('payment_type', 'cash')
                        ->whereYear('datetime',date('Y'))
                        ->groupBy('month')
                        ->get()->toArray();
            
            for($i = 1; $i <= 12; $i++ ){
                $paymentData = 0;

                foreach($cash_payment as $payment){
                    if((int)$payment['month'] == $i){
                        $data['list'][] = (int)$payment['total'];
                        $paymentData++;
                    }
                }

                if($paymentData == 0){
                    $data['list'][] = 0 ;
                }
            }
        }

        return $series;
    }
    /*
     * Auth pages Routs
     */

     function authLogin()
    {
    return view('auth.login');
    }

    function authRegister()
    {
        $assets = ['phone'];
        return view('auth.register',compact('assets'));
    }

    function authRecoverPassword()
    {
        return view('auth.forgot-password');
    }

    function authConfirmEmail()
    {
        return view('auth.verify-email');
    }

    function authLockScreen()
    {
        return view();
    }

    public function changeStatus(Request $request)
    {
        if(env('APP_DEMO')){
            $message = __('message.demo_permission_denied');
            $response = [
                'status'    => false,
                'message'   => $message
            ];
            return json_custom_response($response);
        }

        $type = $request->type;
        $message_form = "";
        $message = __('message.update_form',['form' => __('message.status')]);
        switch ($type) {
            case 'role':
                    $role = \App\Models\Role::find($request->id);
                    $role->status = $request->status;
                    $role->save();
                    break;
            case 'service_status' :
                $service = \App\Models\Service::find($request->id);
                $service->status = $request->status;
                $service->save();
                break;
            case 'coupon_status' :
                $coupon = \App\Models\Coupon::find($request->id);
                $coupon->status = $request->status;
                $coupon->save();
                break;
            case 'document_status' :
                $document = Document::find($request->id);
                $document->status = $request->status;
                $document->save();
                break;
            case 'document_required' :
                $message_form = __('message.required');
                $document = Document::find($request->id);
                $document->is_required = $request->status;
                $document->save();
                break;
            case 'document_has_expiry_date' :
                $message_form = __('message.expire_date');
                $document = Document::find($request->id);
                $document->has_expiry_date = $request->status;
                $document->save();
                break;
            case 'driver_is_verified' :
                $message_form = __('message.driverdocument');
                $document = \App\Models\DriverDocument::find($request->id);
                $document->is_verified = $request->status;
                $document->save();
                break;
            default:
                    $message = 'error';
                break;
        }

        if($message_form != null){
            $message =  __('message.added_form',['form' => $message_form ]);
            if($request->status == 0){
                $message = __('message.remove_form',['form' => $message_form ]);
            }
        }
        
        return json_custom_response(['message'=> $message , 'status' => true]);
    }

    public function getAjaxList(Request $request)
    {
        $items = array();
        $value = $request->q;
        $auth_user = authSession();
        switch ($request->type) {
            case 'permission':
                $items = \App\Models\Permission::select('id','name as text')->whereNull('parent_id');
                if($value != ''){
                    $items->where('name', 'LIKE', $value.'%');
                }
                $items = $items->get();
                break;
            case 'fleet_driver':
                    if( $auth_user->hasRole('admin')) {
                        $user_type = ['driver','fleet'];
                    } else {
                        $user_type = $auth_user->user_type;
                    }
                    $items = User::select('id','display_name as text')
                        ->whereIn('user_type',$user_type)
                        ->where('status','active');
        
                        if($value != ''){
                            $items->where('display_name', 'LIKE', $value.'%');
                        }
        
                        $items = $items->get();
                break;
            case 'rider':
                $items = \App\Models\User::select('id','display_name as text')
                    ->where('user_type','rider')
                    ->where('status','active');
    
                    if($value != ''){
                        $items->where('display_name', 'LIKE', $value.'%');
                    }
    
                    $items = $items->get();
                    break;
            case 'fleet':
                $items = \App\Models\User::select('id','display_name as text')
                    ->where('user_type','fleet')
                    ->where('status','active');
    
                    if($value != ''){
                        $items->where('display_name', 'LIKE', $value.'%');
                    }
    
                    $items = $items->get();
                    break;
            case 'driver':
                $items = \App\Models\User::select('id','display_name as text')
                ->where('user_type','driver');
                

                if(isset($request->fleet_id)){
                    $items->where('fleet_id', $request->fleet_id);
                }

                if(isset($request->status)){
                    $items->where('status', $request->status);
                } else {
                    $items->where('status','active');
                }
                
                if($value != ''){
                    $items->where('display_name', 'LIKE', $value.'%');
                }

                $items = $items->get();
                break;


            case 'region' :
                $items = \App\Models\Region::select('id','name as text', 'distance_unit')->where('status',1);
                    if($value != ''){
                        $items->where('name', 'LIKE', '%'.$value.'%');
                    }
                            
                    $items = $items->get();

                break;
            case 'service':
                        $items = \App\Models\Service::select('id','name as text')->where('status',1);
        
                        if($value != ''){
                            $items->where('name', 'LIKE', '%'.$value.'%');
                        }
                                
                        $items = $items->get();
                        break;
            case 'coupon':
                        $items = \App\Models\Coupon::select('id','code as text')->where('status',1);
            
                        if($value != ''){
                            $items->where('code', 'LIKE', '%'.$value.'%');
                        }
                    
                        $items = $items->get();
                        break;

            case 'document':
                $items = Document::select('id','name','status' ,'is_required', 'has_expiry_date', DB::raw('(CASE WHEN is_required = 1 THEN CONCAT(name," * ") ELSE CONCAT(name,"") END) AS text'))->where('status',1);
                if($value != ''){
                    $items->where('name', 'LIKE', $value.'%');
                }
                $items = $items->get();
                break;
            case 'riderequest': 
                $id = __('message.ride_request_id');

                $items = \App\Models\RideRequest::select('id', DB::raw("CONCAT('#',id) as text"), 'rider_id','driver_id')->with(['rider','driver']);
                if($value != '') {
                    $items->where('id', 'LIKE', $value.'%');
                }
                $items = $items->get();
                break;
            case 'timezone':
                $items = timeZoneList();
                foreach ($items as $k => $v) {
                    if($value !=''){
                        if (strpos($v, $value) !== false) {

                        } else {
                            unset($items[$k]);
                        }
                    }
                }
                $data = [];
                $i = 0;
                foreach ($items as $key => $row) {
                    $data[$i] = [
                        'id'    => $key,
                        'text'  => $row,
                    ];
                    $i++;
                }
                $items=$data ;
                break;
            default :
                break;
        }
        return response()->json(['status' => true, 'results' => $items]);
    }

    public function removeFile(Request $request)
    {
        $type = $request->type;
        $data = null;

        if(env('APP_DEMO')){
            $message = __('message.demo_permission_denied');
            if(request()->ajax()) {
                return response()->json(['status' => true, 'message' => $message ]);
            }
        }
        switch ($type) {
            case 'service_image':
                $data = Service::find($request->id);
                $message = __('message.msg_removed',[ 'name' => __('message.service')]);
                break;
            
            case 'gateway_image':
                $data = PaymentGateway::find($request->id);
                $message = __('message.msg_removed',[ 'name' => __('message.paymentgateway')]);
                break;
            
            // case 'attachment':
            //     $media = Media::find($request->id);
            //     $media->delete();
            //     $message = __('message.msg_removed',[ 'name' => __('message.attachments')]);
            // break;

            default:
                $data = AppSetting::find($request->id);
                $message = __('message.msg_removed',[ 'name' => __('message.image')]);
            break;
        }

        if($data != null){
            $data->clearMediaCollection($type);
        }

        $response = [
                'status' => true,
                'id' => $request->id,
                'image' => getSingleMedia($data,$type),
                'preview' => $type."_preview",
                'message' => $message
        ];
        return json_custom_response($response);
    }

    // publish topic
    public function SendMsgViaMqtt($topic, $message) {
        MQTT::publish($topic, $message);
    }

    // subscribe topic
    public function SubscribetoTopic($topic) {
        $mqtt = MQTT::connection();
        $mqtt->subscribe($topic, function ($topic, $message) {
            echo sprintf("Received message on topic [%s]: %s\n", $topic, $message);
        }, 0);
    }
}
