<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Coupon;
use App\Http\Resources\CouponResource;

class CouponController extends Controller
{
    public function getList(Request $request)
    {
        $coupon = Coupon::where('status',1);

        $coupon->when(request('region_id'), function ($q) {
            return $q->orWhereIn('region_ids', request('region_id'));
        });

        $coupon->when(request('region_id'), function ($q) {
            return $q->orWhereIn('service_ids', request('service_id'));
        });

        $coupon->when(request('code'), function ($q) {
            return $q->where('code', 'LIKE', '%' . request('code') . '%');
        });

        $per_page = config('constant.PER_PAGE_LIMIT');
        if( $request->has('per_page') && !empty($request->per_page)){
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }
            if($request->per_page == -1 ){
                $per_page = $coupon->count();
            }
        }

        $coupon = $coupon->orderBy('title','asc')->paginate($per_page);
        
        $items = CouponResource::collection($coupon);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }
}