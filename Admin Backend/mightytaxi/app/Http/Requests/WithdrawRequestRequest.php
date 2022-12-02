<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\JsonResponse;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Request;
use Illuminate\Http\Exceptions\HttpResponseException;
use App\Models\User;
use App\Models\Wallet;

class WithdrawRequestRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $user_id = request()->user_id ?? auth()->user()->id;
        $user = User::find($user_id);
        
        if( $user == null )
        {
            $msg = __('message.not_found_entry', [ 'name' => __('message.user') ]);
            $message = [
                'message' => $msg
            ];
            throw new HttpResponseException(response()->json( $message, 422));
        }

        $wallet = Wallet::where('user_id', $user->id)->first();

        if( $wallet == null ) {
            $msg = __('message.not_found_entry', [ 'name' => __('message.wallet') ]);
            $message = [
                'message' => $msg
            ];
            throw new HttpResponseException(response()->json( $message, 422));
        }
        $total_amount = $wallet->total_amount;

        $user_request_amount = $user->userWithdraw->where('status',0)->sum('amount');
        $remaining_amount = $total_amount - $user_request_amount;
        
        $valid_rule = [];

        if( !isset(request()->id)) {
            $valid_rule['amount'] = 'required|numeric|min:1|max:'.$remaining_amount;
        }

        return $valid_rule;
    }
    
    public function messages()
    {
        return [
           'amount.max' => __('message.withdraw_amount_validation')
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        if ( request()->is('api*')){
            $data = [
                'status' => 'false',
                'message' => $validator->errors()->first(),
                'all_message' =>  $validator->errors()
            ];
            
            throw new HttpResponseException(response()->json($data,422));
        }

        throw new HttpResponseException(redirect()->back()->withInput()->with('errors', $validator->errors()));
    }
}
