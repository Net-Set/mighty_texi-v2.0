<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\DataTables\DriverDataTable;
use App\Models\Role;
use App\Http\Requests\DriverRequest;
use App\Models\DriverDocument;
class DriverController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(DriverDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.driver')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('driver add') ? '<a href="'.route('driver.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.driver')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('assets','pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.driver')]);
        $assets = ['phone'];
        // $selected_service = [];
        return view('driver.form', compact('pageTitle','assets'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(DriverRequest $request)
    {
        $request['password'] = bcrypt($request->password);

        $request['username'] = $request->username ?? stristr($request->email, "@", true) . rand(100,1000);
        $request['display_name'] = $request->first_name.' '. $request->last_name;
        $request['user_type'] = 'driver';

        if(auth()->user()->hasRole('fleet')) {
            $request['fleet_id'] = auth()->user()->id;
        }
        $user = User::create($request->all());

        uploadMediaFile($user,$request->profile_image, 'profile_image');
        $user->assignRole('driver');
        // Save Driver detail...
        $user->userDetail()->create($request->userDetail);
        
        $user->userWallet()->create(['total_amount' => 0 ]);
/*
        if($user->driverService()->count() > 0)
        {
            $user->driverService()->delete();
        }

        if($request->service_id != null) {
            foreach($request->service_id as $service) {
                $driver_services = [
                    'service_id'    => $service->id,
                    'driver_id'     => $user->id,
                ];
                $user->driverService()->insert($driver_services);
            }
        }
*/
        return redirect()->route('driver.index')->withSuccess(__('message.save_form', ['form' => __('driver')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.view_form_title',[ 'form' => __('message.driver')]);
        $data = User::with('roles')->findOrFail($id);
        $data->rating = count($data->driverRating) > 0 ? (float) number_format(max($data->driverRating->avg('rating'),0), 2) : 0;
        $profileImage = getSingleMedia($data, 'profile_image');

        return view('driver.show', compact('data', 'profileImage', 'pageTitle'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.driver')]);
        $data = User::with('userDetail')->findOrFail($id);

        $profileImage = getSingleMedia($data, 'profile_image');
        $assets = ['phone'];
/* 
        $selected_service = $data->driverService->mapWithKeys(function ($item) {
            return [ $item->service_id => optional($item->service)->name ];
        });
*/
        return view('driver.form', compact('data', 'pageTitle', 'id', 'profileImage', 'assets'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(DriverRequest $request, $id)
    {
        $user = User::with('userDetail')->findOrFail($id);
        
        $request['password'] = $request->password != '' ? bcrypt($request->password) : $user->password;

        $request['display_name'] = $request->first_name.' '. $request->last_name;

        if(auth()->user()->hasRole('fleet')) {
            $request['fleet_id'] = auth()->user()->id;
        }
        // User user data...
        $user->fill($request->all())->update();

        // Save user image...
        if (isset($request->profile_image) && $request->profile_image != null) {
            $user->clearMediaCollection('profile_image');
            $user->addMediaFromRequest('profile_image')->toMediaCollection('profile_image');
        }

        if($user->userDetail != null) {
            $user->userDetail->fill($request->userDetail)->update();
        } else {
            $user->userDetail()->create($request->userDetail);
        }

        /*
        if($user->driverService()->count() > 0)
        {
            $user->driverService()->delete();
        }

        if($request->service_id != null) {
            foreach($request->service_id as $service) {
                $driver_services = [
                    'service_id'    => $service,
                    'driver_id'     => $user->id,
                ];
                $user->driverService()->insert($driver_services);
            }
        }
        */

        if(auth()->check()){
            return redirect()->route('driver.index')->withSuccess(__('message.update_form',['form' => __('message.driver')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.driver') ] ));
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
            return redirect()->route('driver.index')->withErrors($message);
        }
        $user = User::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.driver')]);

        if($user!='') {
            $user->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.driver')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
