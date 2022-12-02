<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\AdditionalFees;
use App\Http\Resources\AdditionalFeesResource;

class AdditionalFeesController extends Controller
{
    public function getList(Request $request)
    {
        $additional_fees = AdditionalFees::query();

        $additional_fees->when(request('title'), function ($q) {
            return $q->where('title', 'LIKE', '%' . request('title') . '%');
        });

        if( $request->has('status') && isset($request->status) ) {
            $additional_fees = $additional_fees->where('status',request('status'));
        }
        
        $per_page = config('constant.PER_PAGE_LIMIT');
        if( $request->has('per_page') && !empty($request->per_page)){
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }
            if($request->per_page == -1 ){
                $per_page = $additional_fees->count();
            }
        }

        $additional_fees = $additional_fees->orderBy('title','asc')->paginate($per_page);
        $items = AdditionalFeesResource::collection($additional_fees);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }
}