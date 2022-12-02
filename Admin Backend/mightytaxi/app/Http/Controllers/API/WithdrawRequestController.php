<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Wallet;
use App\Models\WithdrawRequest;
use App\Http\Resources\WithdrawRequestResource;

class WithdrawRequestController extends Controller
{
    public function getList(Request $request)
    {
        $withdraw = WithdrawRequest::myWithdrawRequest();

        $withdraw->when(request('user_id'), function ($q) {
            return $q->where('user_id', request('user_id'));
        });
        
        $per_page = config('constant.PER_PAGE_LIMIT');
        if( $request->has('per_page') && !empty($request->per_page)){
            
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }

            if($request->per_page == -1 ){
                $per_page = $withdraw->count();
            }
        }

        $withdraw = $withdraw->orderBy('id','desc')->paginate($per_page);
        $items = WithdrawRequestResource::collection($withdraw);

        $wallet_data = Wallet::where('user_id', auth()->user()->id)->first();
        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
            'wallet_balance' => $wallet_data
        ];
        
        return json_custom_response($response);
    }
}