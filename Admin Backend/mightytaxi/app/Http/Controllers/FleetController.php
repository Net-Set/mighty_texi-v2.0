<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\DataTables\FleetDataTable;
use App\Models\Role;
use App\Http\Requests\FleetRequest;

class FleetController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(FleetDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.fleet')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('fleet add') ? '<a href="'.route('fleet.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.fleet')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('assets','pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.fleet')]);
        $assets = ['phone'];
        return view('fleet.form', compact('pageTitle','assets'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(FleetRequest $request)
    {
        $request['password'] = bcrypt($request->password);

        $request['username'] = $request->username ?? stristr($request->email, "@", true) . rand(100,1000);
        $request['display_name'] = $request->first_name.' '. $request->last_name;
        $request['user_type'] = 'fleet';
        $user = User::create($request->all());

        uploadMediaFile($user,$request->profile_image, 'profile_image');
        $user->assignRole('fleet');
        // Save Fleet detail...
        $user->userDetail()->create();

        return redirect()->route('fleet.index')->withSuccess(__('message.save_form', ['form' => __('message.fleet')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.fleet')]);
        $data = User::with('roles')->findOrFail($id);

        $profileImage = getSingleMedia($data, 'profile_image');

        return view('fleet.show', compact('data', 'profileImage'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.fleet')]);
        $data = User::with('userDetail')->findOrFail($id);

        $profileImage = getSingleMedia($data, 'profile_image');
        $assets = ['phone'];
        return view('fleet.form', compact('data', 'pageTitle', 'id', 'profileImage', 'assets'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(FleetRequest $request, $id)
    {
        $user = User::with('userDetail')->findOrFail($id);
        
        $request['password'] = $request->password != '' ? bcrypt($request->password) : $user->password;

        $request['display_name'] = $request->first_name.' '. $request->last_name;
        // User user data...
        $user->fill($request->all())->update();

        // Save user image...
        if (isset($request->profile_image) && $request->profile_image != null) {
            $user->clearMediaCollection('profile_image');
            $user->addMediaFromRequest('profile_image')->toMediaCollection('profile_image');
        }

        if($user->userDetail != null && request('userDetail') != null) {
            $user->userDetail->fill($request->userDetail)->update();
        }
        if( $user->userDetail == null && request('userDetail') != null ) {
            $user->userDetail()->create();
        }

        if(auth()->check()){
            return redirect()->route('fleet.index')->withSuccess(__('message.update_form',['form' => __('message.fleet')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.fleet') ] ));
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
            return redirect()->route('fleet.index')->withErrors($message);
        }
        $user = User::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.fleet')]);

        if($user!='') {
            $user->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.fleet')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
