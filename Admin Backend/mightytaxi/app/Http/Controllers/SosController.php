<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Sos;
use App\DataTables\SosDataTable;

class SosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(SosDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.sos')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('sos add') ? '<a href="'.route('sos.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.sos')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.sos')]);
        
        return view('sos.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request['added_by'] = auth()->user()->id;
        $sos = Sos::create($request->all());

        $message = __('message.save_form',['form' => __('message.sos')]);
        
        if(request()->is('api/*')){
            return json_message_response( $message );
        }

        return redirect()->route('sos.index')->withSuccess($message);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.sos')]);
        $data = Sos::findOrFail($id);
        
        return view('sos.form', compact('data', 'pageTitle', 'id'));
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
        $sos = Sos::findOrFail($id);

        $request['added_by'] = auth()->user()->id;
        // Sos data...
        $sos->fill($request->all())->update();

        $message = __('message.update_form',['form' => __('message.sos')]);

        if(request()->is('api/*')){
            return json_message_response( $message );
        }

        if(auth()->check()){
            return redirect()->route('sos.index')->withSuccess($message);
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
            return redirect()->route('sos.index')->withErrors($message);
        }
        $sos = Sos::find($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.sos')]);

        if($sos != '') {
            $sos->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.sos')]);
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
