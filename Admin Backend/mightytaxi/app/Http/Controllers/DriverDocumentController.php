<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DriverDocument;
use App\DataTables\DriverDocumentDataTable;
use App\Notifications\CommonNotification;

class DriverDocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(DriverDocumentDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.driver_document')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('driverdocument add') ? '<a href="'.route('driverdocument.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.driver_document')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.driver_document')]);
        
        return view('driver_document.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();
        $data['expire_date'] = request('expire_date')!= null ? date('Y-m-d',strtotime(request('expire_date'))) : null;
        $data['is_verified'] = request('is_verified') != null ? request('is_verified') : 0;
        $data['driver_id'] = request('driver_id') == null && auth()->user()->hasRole('driver') ? auth()->user()->id : request('driver_id');
        $driver_document = DriverDocument::create($data);

        uploadMediaFile($driver_document,$request->driver_document, 'driver_document');

        $message = __('message.save_form',['form' => __('message.driver_document')]);
        $is_verified = $driver_document->is_verified;
        if( in_array($is_verified, [ 0, 1, 2 ])  || $driver_document->driver->is_verified_driver == 0 ) {
            $is_verified_driver = (int) $driver_document->verifyDriverDocument($driver_document->driver->id);
            $driver_document->driver->update(['is_verified_driver' => $is_verified_driver ]);
        }

        if( in_array($is_verified, [ 1, 2 ]) )
        {
            $type = 'document_approved';
            $status = __('message.approved');
            if( $is_verified == 0 ) {
                $type = 'document_pending';
                $status = __('message.pending');
            }
    
            if( $is_verified == 2 ) {
                $type = 'document_rejected';
                $status = __('message.rejected');
            }
            $notification_data = [
                'id'   => $driver_document->driver->id,
                'is_verified_driver' => (int) $driver_document->driver->is_verified_driver,
                'type' => $type,
                'subject' => __('message.'.$type),
                'message' => __('message.approved_reject_form', [ 'form' => $driver_document->document->name, 'status' => $status ]),
            ];
    
            $driver_document->driver->notify(new CommonNotification($notification_data['type'], $notification_data));
        }
        
        if(request()->is('api/*')){
            return json_message_response( $message );
        }
        
        return redirect()->route('driverdocument.index')->withSuccess($message);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.driver_document')]);
        $data = DriverDocument::findOrFail($id);

        return view('driver_document.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.driver_document')]);
        $data = DriverDocument::findOrFail($id);
        
        return view('driver_document.form', compact('data', 'pageTitle', 'id'));
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
        $driver_document = DriverDocument::find($id);

        if($driver_document == '') {
            $message = __('message.not_found_entry', ['name' => __('message.driver_document')]);
            
            if(request()->is('api/*')){
                return json_message_response( $message );
            }

            return redirect()->route('driverdocument.index')->withErrors($message);
        }
        $old_is_verified = $driver_document->is_verified;
        // DriverDocument data...
        $driver_document->fill($request->all())->update();

        if (isset($request->driver_document) && $request->driver_document != null) {
            $driver_document->clearMediaCollection('driver_document');
            $driver_document->addMediaFromRequest('driver_document')->toMediaCollection('driver_document');
        }
        
        $message = __('message.update_form',['form' => __('message.driver_document') ] );

        $is_verified = $driver_document->is_verified;
        if( in_array($is_verified, [ 0, 1, 2 ])  || $driver_document->driver->is_verified_driver == 0 ) {
            $is_verified_driver = (int) $driver_document->verifyDriverDocument($driver_document->driver->id);
            $driver_document->driver->update(['is_verified_driver' => $is_verified_driver ]);            
        }
        
        if($old_is_verified != $is_verified && in_array($is_verified, [ 0, 1, 2 ] )) {
            
            $type = 'document_approved';
            $status = __('message.approved');
            if( $is_verified == 0 ) {
                $type = 'document_pending';
                $status = __('message.pending');
            }

            if( $is_verified == 2 ) {
                $type = 'document_rejected';
                $status = __('message.rejected');
            }
            $notification_data = [
                'id'   => $driver_document->driver->id,
                'is_verified_driver' => (int) $driver_document->driver->is_verified_driver,
                'type' => $type,
                'subject' => __('message.'.$type),
                'message' => __('message.approved_reject_form', [ 'form' => $driver_document->document->name, 'status' => $status ]),
            ];
    
            $driver_document->driver->notify(new CommonNotification($notification_data['type'], $notification_data));
        }
        if(request()->is('api/*')) {
            return json_message_response( $message );
        }

        if(auth()->check()){
            return redirect()->route('driverdocument.index')->withSuccess($message);
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
            return redirect()->route('driverdocument.index')->withErrors($message);
        }
        $driver_document = DriverDocument::find($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.driver_document')]);

        if($driver_document != '') {
            $driver_document->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.driver_document')]);
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
