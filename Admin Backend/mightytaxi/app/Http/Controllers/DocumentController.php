<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Document;
use App\DataTables\DocumentDataTable;

class DocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(DocumentDataTable $dataTable)
    {
        $pageTitle = __('message.list_form_title',['form' => __('message.document')] );
        $auth_user = authSession();
        $assets = ['datatable'];
        $button = $auth_user->can('document add') ? '<a href="'.route('document.create').'" class="float-right btn btn-sm btn-primary"><i class="fa fa-plus-circle"></i> '.__('message.add_form_title',['form' => __('message.document')]).'</a>' : '';
        return $dataTable->render('global.datatable', compact('pageTitle','button','auth_user'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.document')]);
        
        return view('document.form', compact('pageTitle'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if(env('APP_DEMO')){
            $message = __('message.demo_permission_denied');
            return redirect()->route('document.index')->withErrors($message);
        }
        $document = Document::create($request->all());

        return redirect()->route('document.index')->withSuccess(__('message.save_form', ['form' => __('message.document')]));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $pageTitle = __('message.add_form_title',[ 'form' => __('message.document')]);
        $data = Document::findOrFail($id);

        return view('document.show', compact('data'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $pageTitle = __('message.update_form_title',[ 'form' => __('message.document')]);
        $data = Document::findOrFail($id);
        
        return view('document.form', compact('data', 'pageTitle', 'id'));
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
        if(env('APP_DEMO')){
            $message = __('message.demo_permission_denied');
            return redirect()->route('document.index')->withErrors($message);
        }
        $document = Document::findOrFail($id);

        // Document data...
        $document->fill($request->all())->update();

        if(auth()->check()){
            return redirect()->route('document.index')->withSuccess(__('message.update_form',['form' => __('message.document')]));
        }
        return redirect()->back()->withSuccess(__('message.update_form',['form' => __('message.document') ] ));
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
            return redirect()->route('document.index')->withErrors($message);
        }
        $document = Document::findOrFail($id);
        $status = 'errors';
        $message = __('message.not_found_entry', ['name' => __('message.document')]);

        if($document != '') {
            $document->delete();
            $status = 'success';
            $message = __('message.delete_form', ['form' => __('message.document')]);
        }

        if(request()->ajax()) {
            return response()->json(['status' => true, 'message' => $message ]);
        }

        return redirect()->back()->with($status,$message);
    }
}
