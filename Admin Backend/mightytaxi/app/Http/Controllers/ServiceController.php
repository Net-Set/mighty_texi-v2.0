<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Service;
use App\DataTables\ServiceDataTable;
use App\Http\Requests\ServiceRequest;

class ServiceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(ServiceDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.service')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('service add') ? '<a href="'.route('service.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.service')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.service')]);
        
        return view('service.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ServiceRequest $request)
    {
        if(env('APP_DEMO')){
            return redirect()->route('service.index')->withErrors(__('message.demo_permission_denied'));
        }
        $service = Service::create($request->all());
        uploadMediaFile($service,$request->service_image, 'service_image');
        return redirect()->route('service.index')->withSuccess(__('message.save_form', ['form' => __('message.service')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.service')]);
        $data = Service::findOrFail($id);

        return view('service.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.service')]);
        $data = Service::findOrFail($id);
        
        return view('service.form', compact('data', 'pageTitle', 'id'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(ServiceRequest $request, $id)
    {
        if(env('APP_DEMO')){
            return redirect()->route('service.index')->withErrors(__('message.demo_permission_denied'));
        }
        $service = Service::findOrFail($id);

        // Service data...
        $service->fill($request->all())->update();

        // Save service service_image...
        if (isset($request->service_image) && $request->service_image != null) {
            $service->clearMediaCollection('service_image');
            $service->addMediaFromRequest('service_image')->toMediaCollection('service_image');
        }

        if(auth()->check()){
            return redirect()->route('service.index')->withSuccess(__('message.update_form',['form' => __('message.service')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.service') ] ));
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
            return redirect()->route('service.index')->withErrors($message);
        }
        $service = Service::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.service')]);

        if($service != '') {
            $service->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.service')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
