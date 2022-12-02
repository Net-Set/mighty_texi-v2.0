<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Complaint;
use App\Models\RideRequest;
use App\DataTables\ComplaintDataTable;
use App\Http\Requests\ComplaintRequest;

class ComplaintController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(ComplaintDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.complaint')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('complaint add') ? '<a href="'.route('complaint.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.complaint')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.complaint')]);
        
        return view('complaint.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ComplaintRequest $request)
    {
        $data = $request->all();

        $riderequest = RideRequest::find($request->ride_request_id);
        
        if( $riderequest == null) {
            $message = __('message.not_found_entry', ['name' => __('message.riderequest')]);
            if(request()->is('api/*')) {
                return json_message_response($message);
            }
        }
        $data['rider_id'] = $riderequest->rider_id;
        $data['driver_id'] = $riderequest->driver_id;
        
        $complaint = Complaint::create($data);
        
        $message = __('message.save_form', ['form' => __('message.complaint')]);
        if(request()->is('api/*')) {
            return json_message_response($message);
		}
        return redirect()->route('complaint.index')->withSuccess($message);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.complaint')]);
        $data = Complaint::findOrFail($id);

        return view('complaint.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.complaint')]);
        $data = Complaint::findOrFail($id);
        
        return view('complaint.form', compact('data', 'pageTitle', 'id'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(ComplaintRequest $request, $id)
    {
        $complaint = Complaint::findOrFail($id);
        $data = $request->all();
        $riderequest = RideRequest::find($request->ride_request_id);
        if( $riderequest == null) {
            $message = __('message.not_found_entry', ['name' => __('message.riderequest')]);
            if(request()->is('api/*')) {
                return json_message_response($message);
            }
        }
        $data['rider_id'] = $riderequest->rider_id;
        $data['driver_id'] = $riderequest->driver_id;

        // Complaint data...
        $complaint->fill($data)->update();

        $message = __('message.update_form',['form' => __('message.complaint')]);
        if(request()->is('api/*')){
            return json_message_response( $message );
        }
        
        if(auth()->check()){
            return redirect()->route('complaint.index')->withSuccess($message);
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
        $complaint = Complaint::find($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.complaint')]);

        if($complaint != '') {
            $complaint->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.complaint')]);
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
