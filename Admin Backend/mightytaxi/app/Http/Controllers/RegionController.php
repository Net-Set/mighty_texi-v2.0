<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Region;
use App\DataTables\RegionDataTable;
use App\Http\Requests\RegionRequest;
use Grimzy\LaravelMysqlSpatial\Types\Point;
use Grimzy\LaravelMysqlSpatial\Types\Polygon;
use Grimzy\LaravelMysqlSpatial\Types\LineString;

class RegionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(RegionDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.region')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('region add') ? '<a href="'.route('region.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.region')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('assets','pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.region')]);
        $assets = ['map'];
        return view('region.form', compact('pageTitle','assets'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(RegionRequest $request)
    {
        if(env('APP_DEMO')){
            return redirect()->route('region.index')->withErrors(__('message.demo_permission_denied'));
        }
        $coordinates = $request->coordinates;
        foreach(explode('),(',trim($coordinates,'()')) as $index => $single_array){
            if($index == 0)
            {
                $last_latlong = explode(',', $single_array);
            }
            $latlong = explode(',', $single_array);
            $polygon[] = new Point($latlong[0], $latlong[1]);
        }
        $polygon[] = new Point($last_latlong[0], $last_latlong[1]);

        $region = new Region();
        $region->name = $request->name;
        $region->distance_unit = $request->distance_unit;
        $region->status = $request->status;
        $region->timezone = $request->timezone;
        $region->coordinates = new Polygon([new LineString($polygon)]);

        $region->save();

        return redirect()->route('region.index')->withSuccess(__('message.save_form', ['form' => __('message.region')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.region')]);
        $data = Region::findOrFail($id);

        return view('region.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.region')]);
        // $data = Region::findOrFail($id);

        $data = Region::selectRaw('* , ST_AsText(ST_Centroid(`coordinates`)) as center')->findOrFail($id);
        $assets = ['map'];
        return view('region.edit', compact('data', 'pageTitle', 'id', 'assets'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(RegionRequest $request, $id)
    {
        if(env('APP_DEMO')){
            return redirect()->route('region.index')->withErrors(__('message.demo_permission_denied'));
        }
        $region = Region::findOrFail($id);

        $coordinates = $request->coordinates;
        foreach(explode('),(',trim($coordinates,'()')) as $index => $single_array){
            if($index == 0)
            {
                $last_latlong = explode(',', $single_array);
            }
            $latlong = explode(',', $single_array);
            $polygon[] = new Point($latlong[0], $latlong[1]);
        }
        $polygon[] = new Point($last_latlong[0], $last_latlong[1]);
        
        $region->name = $request->name;
        $region->distance_unit = $request->distance_unit;
        $region->status = $request->status;
        $region->timezone = $request->timezone;
        $region->coordinates = new Polygon([new LineString($polygon)]);

        $region->save();
        if(auth()->check()){
            return redirect()->route('region.index')->withSuccess(__('message.update_form',['form' => __('message.region')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.region') ] ));
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
            return redirect()->route('region.index')->withErrors($message);
        }
        $region = Region::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.region')]);

        if($region != '') {
            $region->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.region')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
