<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Document;
use App\Http\Resources\DocumentResource;

class DocumentController extends Controller
{
    public function getList(Request $request){

        $document = new Document;
        
        if( $request->has('status') && isset($request->status) ) {
            $document = $document->where('status',request('status'));
        }
        
        if( $request->has('is_deleted') && isset($request->is_deleted) && $request->is_deleted) {
            $document = $document->withTrashed();
        }

        $per_page = config('constant.PER_PAGE_LIMIT');
        
        if( $request->has('per_page') && !empty($request->per_page)){
            if(is_numeric($request->per_page))
            {
                $per_page = $request->per_page;
            }
            if($request->per_page == -1 ){
                $per_page = $document->count();
            }
        }

        $document = $document->orderBy('id','desc')->paginate($per_page);
        $items = DocumentResource::collection($document);

        $response = [
            'pagination' => json_pagination_response($items),
            'data' => $items,
        ];
        
        return json_custom_response($response);
    }
}