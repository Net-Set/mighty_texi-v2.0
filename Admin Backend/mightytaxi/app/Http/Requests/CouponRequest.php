<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;


class CouponRequest extends FormRequest
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
        $method = strtolower($this->method());
        
        $rules = [];
        switch ($method) {
            case 'post':
                $rules = [
                    'code' => 'required|unique:coupons',
                    'title' => 'required',
                    'discount' => 'required',
                    'coupon_type' => 'required|in:region_wise,service_wise,first_ride,all',
                    'region_ids' => 'required_if:coupon_type,region_wise',
                    'service_ids' => 'required_if:coupon_type,service_wise'
                ];
                break;
            case 'patch':
                $rules = [
                    'title' => 'required',
                    'discount' => 'required',
                    'coupon_type' => 'required|in:region_wise,service_wise,first_ride,all',
                    'region_ids' => 'required_if:coupon_type,region_wise',
                    'service_ids' => 'required_if:coupon_type,service_wise'
                ];
                break;
        }

        return $rules;
    }

    public function messages()
    {
        return [ ];
    }

     /**
     * @param Validator $validator
     */
    protected function failedValidation(Validator $validator) {
        $data = [
            'status' => true,
            'message' => $validator->errors()->first(),
            'all_message' =>  $validator->errors()
        ];

        if ( request()->is('api*')){
           throw new HttpResponseException( response()->json($data,422) );
        }

        if ($this->ajax()) {
            throw new HttpResponseException(response()->json($data,422));
        } else {
            throw new HttpResponseException(redirect()->back()->withInput()->with('errors', $validator->errors()));
        }
    }
}
