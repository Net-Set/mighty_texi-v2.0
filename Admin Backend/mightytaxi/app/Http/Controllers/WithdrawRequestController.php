<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\WithdrawRequest;
use App\DataTables\WithdrawRequestDataTable;
use App\Models\Wallet;
use App\Models\WalletHistory;
use App\Http\Requests\WithdrawRequestRequest;
use Illuminate\Support\Facades\DB;
use App\Notifications\CommonNotification;
use App\Models\User;

class WithdrawRequestController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(WithdrawRequestDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.withdrawrequest')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = ''; //'<a href="'.route('withdrawrequest.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.withdrawrequest')]).'</a>';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.withdrawrequest')]);
        
        return view('withdrawrequest.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(WithdrawRequestRequest $request)
    {
        $data = $request->all();
        $data['user_id'] = auth()->user()->id ?? $request->user_id;

        $withdrawrequest_exist = WithdrawRequest::where('user_id', $data['user_id'])->where('status', 0)->exists();
        if($withdrawrequest_exist) {
            $message = __('message.already_withdrawrequest');
            if(request()->is('api/*')){
                return json_message_response( $message, 400 );
            }
        }
        $withdrawrequest = WithdrawRequest::create($data);

        $message = __('message.save_form',['form' => __('message.withdrawrequest')]);
        
        if(request()->is('api/*')){
            return json_message_response( $message );
        }

        return redirect()->route('withdrawrequest.index')->withSuccess($message);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.withdrawrequest')]);
        $data = WithdrawRequest::findOrFail($id);
        
        return view('withdrawrequest.form', compact('data', 'pageTitle', 'id'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

    public function update(Request $request, $id)
    {

    }

    public function updateStatus(Request $request)
    {
        $withdrawrequest = WithdrawRequest::find($request->id);
        
        $data = $request->all();
        
        $data['user_id'] = $withdrawrequest->user_id;
        $user = User::find($withdrawrequest->user_id);
        if( $data['status'] == 1 )
        {
            $wallet = Wallet::where('user_id', $withdrawrequest->user_id)->first();
            if( $wallet != null ) {
                try 
                {
                    DB::beginTransaction();
                    $withdrawrequest->fill($data)->update();

                    $wallet->user_id           = $withdrawrequest->user_id;
                    $wallet->total_amount      = $wallet->total_amount - $withdrawrequest->amount;
                    $wallet->total_withdrawn   = $wallet->total_withdrawn + $withdrawrequest->amount;
                    $wallet->currency          = $withdrawrequest->currency;
                    
                    $wallet->save();
                    
                    $wallet_history_data = [
                        'user_id'           => $withdrawrequest->user_id,
                        'type'              => 'debit',
                        'transaction_type'  => 'withdraw',
                        'amount'            => $withdrawrequest->amount,
                        'balance'           => $wallet->total_amount,
                        'currency'          => $withdrawrequest->currency,
                        'datetime'          => date('Y-m-d H:i:s'),
                    ];
        
                    WalletHistory::create($wallet_history_data);
                    DB::commit();
                } catch(\Exception $e) {
                    DB::rollBack();
                    return json_custom_response($e);
                }
            }
        } else {
            // WithdrawRequest data...
            $withdrawrequest->fill($request->all())->update();
        }

        $status = 'decline';
        if( $withdrawrequest->status == 1 ) {
            $status = 'approved';
            $message = __('message.withdrawrequest_approved');
        }

        if( $withdrawrequest->status == 2 ) {
            $message = __('message.withdrawrequest_declined');
        }
        $notification_data = [
            'id'   => $withdrawrequest->id,
            'type' => $status,
            'subject' => __('message.withdrawrequest'),
            'message' => $message,
        ];
        $user->notify(new CommonNotification($notification_data['type'], $notification_data));
        $message = __('message.update_form',['form' => __('message.withdrawrequest')]);

        if(request()->is('api/*')){
            return json_message_response( $message );
        }

        if(request()->ajax()) {
            return json_custom_response(['status' => true, 'message' => $message ]);
        }

        if(auth()->check()){
            return redirect()->route('withdrawrequest.index')->withSuccess($message);
        }
        return redirect()->back()->withSuccess($message);
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
            return redirect()->route('withdrawrequest.index')->withErrors($message);
        }
        $withdrawrequest = WithdrawRequest::find($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.withdrawrequest')]);

        if($withdrawrequest != '') {
            $withdrawrequest->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.withdrawrequest')]);
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
