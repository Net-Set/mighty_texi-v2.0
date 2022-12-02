<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Coupon;
use App\DataTables\CouponDataTable;
use App\Http\Requests\CouponRequest;
use App\Models\Service;
use App\Models\Region;
class CouponController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(CouponDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.coupon')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('coupon add') ? '<a href="'.route('coupon.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.coupon')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.coupon')]);
        $selected_service = $selected_region = [];

        return view('coupon.form', compact('pageTitle', 'selected_service', 'selected_region'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CouponRequest $request)
    {
        $data = $request->all();

        if($request->coupon_type == 'first_ride') {
            $data['usage_limit_per_rider'] = 1;
        }
        $coupon = Coupon::create($request->all());

        return redirect()->route('coupon.index')->withSuccess(__('message.save_form', ['form' => __('coupon')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.coupon')]);
        $data = Coupon::findOrFail($id);

        return view('coupon.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.coupon')]);
        $data = Coupon::findOrFail($id);

        $selected_region = [];
        if( isset($data->region_ids)){
            $selected_region = Region::whereIn('id',$data->region_ids)->get()->mapWithKeys(function ($item) {
                return [ $item->id => $item->name ];
            });
        }

        $selected_service = [];
        if( isset($data->service_ids)){
            $selected_service = Service::whereIn('id',$data->service_ids)->get()->mapWithKeys(function ($item) {
                return [ $item->id => $item->name ];
            });
        }
        
        return view('coupon.form', compact('data', 'pageTitle', 'id', 'selected_service', 'selected_region'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(CouponRequest $request, $id)
    {
        $coupon = Coupon::findOrFail($id);
        // Coupon data...
        $data = $request->all();
        
        if($request->coupon_type == 'first_ride') {
            $data['usage_limit_per_rider'] = 1;
        }
        
        $coupon->fill($data)->update();

        if(auth()->check()){
            return redirect()->route('coupon.index')->withSuccess(__('message.update_form',['form' => __('message.coupon')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.coupon') ] ));
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
            return redirect()->route('coupon.index')->withErrors($message);
        }
        $coupon = Coupon::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.coupon')]);

        if($coupon != '') {
            $coupon->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.coupon')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
