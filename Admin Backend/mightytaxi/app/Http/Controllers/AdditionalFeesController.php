<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AdditionalFees;
use App\DataTables\AdditionalFeesDataTable;

class AdditionalFeesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(AdditionalFeesDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.additionalfees')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('additionalfees add') ? '<a href="'.route('additionalfees.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.additionalfees')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.additionalfees')]);
        
        return view('additional_fees.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $additionalfees = AdditionalFees::create($request->all());

        return redirect()->route('additionalfees.index')->withSuccess(__('message.save_form', ['form' => __('message.additionalfees')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.additionalfees')]);
        $data = AdditionalFees::findOrFail($id);

        return view('additional_fees.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.additionalfees')]);
        $data = AdditionalFees::findOrFail($id);
        
        return view('additional_fees.form', compact('data', 'pageTitle', 'id'));
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
        $additionalfees = AdditionalFees::findOrFail($id);

        // AdditionalFees data...
        $additionalfees->fill($request->all())->update();

        if(auth()->check()){
            return redirect()->route('additionalfees.index')->withSuccess(__('message.update_form',['form' => __('message.additionalfees')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.additionalfees') ] ));
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
            return redirect()->route('additionalfees.index')->withErrors($message);
        }
        $additionalfees = AdditionalFees::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.additionalfees')]);

        if($additionalfees != '') {
            $additionalfees->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.additionalfees')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
