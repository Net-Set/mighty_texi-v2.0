<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DriverDocument;
use App\Http\Resources\DriverDocumentResource;

class DriverDocumentController extends Controller
{
    public function getList(Request $request)
    {
        $driver_document = DriverDocument::myDocument();

        $driver_document->when(request('driver_id'), function ($q) {
            return $q->where('driver_id', request('driver_id'));
        });
        
        $per_page = config('constant.PER_PAGE_LIMIT');
        
        if( $request->has('per_page') && !empty($request->per_page)){
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }
            if($request->per_page == -1 ){
                $per_page = $driver_document->count();
            }
        }

        $driver_document = $driver_document->orderBy('id','desc')->paginate($per_page);
        $items = DriverDocumentResource::collection($driver_document);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }
}