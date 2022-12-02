<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Payment;
use App\Models\RideRequest;
use App\Http\Resources\PaymentResource;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WalletHistory;
use Illuminate\Support\Facades\DB;
use App\Traits\PaymentTrait;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
class PaymentController extends Controller
{
    use PaymentTrait;
    public function paymentSave(Request $request)
    {
        $data = $request->all();
        $data['datetime'] = isset($request->datetime) ? date('Y-m-d H:i:s', strtotime($request->datetime)) : date('Y-m-d H:i:s');

        if( request('payment_type') == 'wallet' ) {
            $wallet = Wallet::where('user_id', request('rider_id'))->first();
            // Log::info('wallet'.json_encode($wallet));
            if($wallet != null) {
                if($wallet->total_amount <= request('total_amount')) {
                    $message = __('message.balance_insufficient');
                    return json_message_response($message,400);
                }
            } else {
                $message = __('message.not_found_entry',['name' => __('message.wallet')]);
                return json_message_response($message,400);
            }
        }
        
        try {
            DB::beginTransaction();
            $result = Payment::updateOrCreate(['id' => $request->id],$data);
            if( $result->payment_status == 'paid' ) {
                if( $result->payment_type == 'wallet') {
                    $wallet->decrement('total_amount', $result->total_amount );
                    $riderequest = $result->riderequest;
                
                    $currency_code = SettingData('CURRENCY', 'CURRENCY_CODE') ?? 'USD';
                    $currency_data = currencyArray($currency_code);
                    $currency = strtolower($currency_data['code']);
                    $rider_wallet = Wallet::where('user_id', $riderequest->rider_id)->first();
                    $rider_wallet_history = [
                        'user_id' => $riderequest->rider_id,
                        'type' => 'debit',
                        'currency' => $currency,
                        'transaction_type' => 'ride_fee',
                        'amount' => $result->total_amount,
                        'balance' => $rider_wallet->total_amount,
                        'ride_request_id' => $result->ride_request_id,
                    ];
                
                    WalletHistory::create($rider_wallet_history);
                }
            }
            DB::commit();
        } catch(\Exception $e) {
            DB::rollBack();
            return json_custom_response($e);
        }
        
        $ride_request = RideRequest::find($result->ride_request_id);
                
        $status_code = 200;
        $message = __('message.payment_completed');
        if($ride_request->status == 'completed' && $result->payment_status == 'paid')
        {
            $this->walletTransaction($ride_request->id);
        } else {
            $message = __('message.payment_status_message',[ 'id' => $result->ride_request_id, 'status' => __('message.'.$result->payment_status) ]);
        }

        if($result->payment_status == 'failed')
        {
            $status_code = 400;
        }
        
        $history_data = [
            'history_type' => 'payment_status_message',
            'payment_status'=> $result->payment_status,
            'ride_request_id' => $ride_request->id,
            'ride_request' => $ride_request,
        ];

        saveRideHistory($history_data);

        return json_message_response($message,$status_code);
    }

    public function getList(Request $request)
    {
        $payment = Payment::myPayment();

        $per_page = config('constant.PER_PAGE_LIMIT');
        if( $request->has('per_page') && !empty($request->per_page)){
            
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }

            if($request->per_page == -1 ){
                $per_page = $payment->count();
            }
        }

        $payment = $payment->orderBy('id','desc')->paginate($per_page);
        $items = PaymentResource::collection($payment);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }

    public function DriverEarningList(Request $request)
    {
        $type = $request->type;
        $today = Carbon::now();
        $today_ride_request = RideRequest::where('status','completed')
                    ->whereHas('payment', function ($query) {
                        $query->where('payment_status','paid');
                    })
                    ->whereHas('rideRequestHistory', function ($query) use($today) {
                        $query->where('history_type','completed')->whereDate('datetime',$today);
                    })->count();

        $total_ride_request = RideRequest::where('status','completed')
                    ->whereHas('payment', function ($query) {
                        $query->where('payment_status','paid');
                    })
                    ->whereHas('rideRequestHistory', function ($query) {
                        $query->where('history_type','completed');
                    })->count();
        
        if( $type == 'today' ) {
            // $total_earnings = Payment::myPayment()->where('payment_status','paid')->whereDate('datetime', $today)->sum('total_amount');
            
            $today_earnings = Payment::myPayment()->where('payment_status','paid')->whereDate('datetime', $today)->sum('total_amount');
            
            $total_cash_ride = Payment::myPayment()->where('payment_status','paid')->where('payment_type',' cash')->whereDate('datetime',$today)->sum('total_amount');
            $total_wallet_ride = Payment::myPayment()->where('payment_status','paid')->where('payment_type', 'wallet')->whereDate('datetime',$today)->sum(DB::raw(' driver_fee + driver_tips'));

            $response = [
                'total_ride_count'  => $total_ride_request,
                'total_cash_ride'   => $total_cash_ride,
                'total_wallet_ride' => $total_wallet_ride,
                'today_earnings'    => $total_cash_ride + $total_wallet_ride,
            ];
        }

        if( $type == 'week' ) {
            $from_date = Carbon::parse($today)->startOfWeek()->toDateTimeString();
            $to_date = Carbon::parse($today)->endOfWeek()->toDateTimeString();

            $total_ride_request = RideRequest::where('status','completed')
            ->whereHas('payment', function ($query) {
                $query->where('payment_status','paid');
            })
            ->whereHas('rideRequestHistory', function ($query) use($from_date,$to_date) {
                $query->where('history_type','completed')->whereBetween('datetime',[ $from_date, $to_date ]);
            })->count();

            $total_cash_ride = Payment::myPayment()->where('payment_status', 'paid')->where('payment_type', 'cash')->whereBetween('datetime',[ $from_date, $to_date ])->sum('total_amount');
            $total_wallet_ride = Payment::myPayment()->where('payment_status', 'paid')->where('payment_type', 'wallet')->whereBetween('datetime',[ $from_date, $to_date ])->sum('driver_commission');
            $total_card_ride = Payment::myPayment()->where('payment_status', 'paid')->whereNotIn('payment_type',[ 'cash', 'wallet'])->whereBetween('datetime',[ $from_date, $to_date ])->sum('driver_commission');

            $week_report = Payment::selectRaw('DATE_FORMAT(datetime , "%w") as days , DATE_FORMAT(datetime , "%Y-%m-%d") as date, driver_commission ' )
                            ->myPayment()->where('payment_status', 'paid')
                            ->whereBetween('datetime',[ $from_date, $to_date ])
                            ->get()->toArray();
            
            $payment_collection = collect($week_report);
            $data = [];
            for($i = 0; $i < 7 ; $i++) {

                $total_amount = $payment_collection->filter(function ($value, $key) use($from_date, $i){
                    return $value['date'] == date('Y-m-d',strtotime($from_date. ' + ' . $i . 'day'));
                })->sum('driver_commission');
                /*
                // payment type == cash ? total_amount + tips
                // payment type == wallet ? driver_fee + tips
                $total_amount = $payment_collection->filter(function ($value, $key) use($from_date, $i){
                    return $value['date'] == date('Y-m-d',strtotime($from_date. ' + ' . $i . 'day'));
                })->sum('total_amount');

                $wallet_total_amount = $payment_collection->where('payment_type', 'wallet')->filter(function ($value, $key) use($from_date, $i){
                    return $value['date'] == date('Y-m-d',strtotime($from_date. ' + ' . $i . 'day'));
                })->sum(DB::raw(' driver_fee + driver_tips'));

                $card_total_amount = $payment_collection->whereNotIn('payment_type',[ 'cash', 'wallet'])->filter(function ($value, $key) use($from_date, $i){
                    return $value['date'] == date('Y-m-d',strtotime($from_date. ' + ' . $i . 'day'));
                })->sum(DB::raw(' driver_fee + driver_tips'));
            */
                $data[] = [
                    'day' => date('l', strtotime($from_date . ' + ' . $i . 'day')),
                    'amount' => $total_amount,
                    'date' => date('Y-m-d',strtotime($from_date. ' + ' . $i . 'day')),    
                ];
            }

            $dashboard_data['weekly_payment_report'] = $data;
            
            $response = [
                'today_date'        => $today,
                'from_date'         => $from_date,
                'to_date'           => $to_date,
                'week_report'       => $data,
                'total_ride_count'  => $total_ride_request,
                'total_cash_ride'   => $total_cash_ride,
                'total_wallet_ride' => $total_wallet_ride,
                'total_card_ride'   => $total_card_ride,

                'total_earnings'    => $total_cash_ride + $total_wallet_ride + $total_card_ride,
            ];
        }

        if( $type == 'report' )
        {
            $from_date = isset($request->from_date) ? Carbon::parse($request->from_date) : Carbon::parse($today)->startOfMonth()->toDateTimeString();
            $to_date = isset($request->to_date) ? Carbon::parse($request->to_date)->endOfDay()->toDateTimeString() : Carbon::parse($today)->endOfDay()->toDateTimeString();
            $total_ride_request = RideRequest::where('status','completed')
                    ->whereHas('payment', function ($query) {
                        $query->where('payment_status','paid');
                    })
                    ->whereHas('rideRequestHistory', function ($query) use($from_date,$to_date) {
                        $query->where('history_type','completed')->whereBetween('datetime',[ $from_date, $to_date ]);
                    })->count();
    
            $total_cash_ride = Payment::myPayment()->where('payment_status', 'paid')->where('payment_type', 'cash')->whereBetween('datetime',[ $from_date, $to_date ])->sum('total_amount');
            $total_wallet_ride = Payment::myPayment()->where('payment_status', 'paid')->where('payment_type', 'wallet')->whereBetween('datetime',[ $from_date, $to_date ])->sum(DB::raw('driver_fee + driver_tips'));
            $total_earnings = Payment::myPayment()->where('payment_status','paid')->whereBetween('datetime',[ $from_date, $to_date ])->sum('total_amount');
            
            $response = [
                'today_date'        => $today,
                'from_date'         => $from_date,
                'to_date'           => $to_date,
                'total_ride_count'  => $total_ride_request,
                'total_cash_ride'   => $total_cash_ride,
                'total_wallet_ride' => $total_wallet_ride,
                'total_earnings'    => $total_cash_ride + $total_wallet_ride,
            ];
        }
        return json_custom_response($response);
    }
}
