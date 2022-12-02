<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;


class ComplaintRequest extends FormRequest
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
                    'ride_request_id' => 'required',
                ];
                break;
            case 'patch':
                $rules = [
                    'ride_request_id' => 'required'
                ];
                break;
        }

        return $rules;
    }

    public function messages()
    {
        return [
            'rider_id'  => __('validation.required', [ 'attribute' => __('message.rider') ]),
            'driver_id'  => __('validation.required', [ 'attribute' => __('message.driver') ]),
        ];
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
