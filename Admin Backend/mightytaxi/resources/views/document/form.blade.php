<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['document.update', $id], 'method' => 'patch' ]) !!}
        @else
            {!! Form::open(['route' => ['document.store'], 'method' => 'post' ]) !!}
        @endif
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ $pageTitle }}</h4>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="new-user-info">
                            <div class="row">
                                <div class="form-group col-md-4">
                                    {{ Form::label('name', __('message.name').' <span class="text-danger">*</span>',['class' => 'form-control-label'], false ) }}
                                    {{ Form::text('name', old('name'),[ 'placeholder' => __('message.name'),'class' =>'form-control','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('is_required',__('message.is_required'), [ 'class'=>'form-control-label' ]) }}
                                    {{ Form::select('is_required',[ '0' => __('message.no'), '1' => __('message.yes') ], old('is_required'), [ 'class' =>'form-control select2js','required']) }}
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('has_expiry_date',__('message.has_expiry_date'), [ 'class' => 'form-control-label' ]) }}
                                    {{ Form::select('has_expiry_date',[ '0' => __('message.no'), '1' => __('message.yes') ], old('has_expiry_date'), [ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('status',__('message.status'), [ 'class'=>'form-control-label' ]) }}
                                    {{ Form::select('status',[ '1' => __('message.active'), '0' => __('message.inactive') ], old('status'), [ 'class' =>'form-control select2js','required']) }}
                                </div>
                            </div>
                            <hr>
                            {{ Form::submit( __('message.save'), ['class'=>'btn btn-md btn-primary float-right']) }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        {!! Form::close() !!}
    </div>
    @section('bottom_script')
    @endsection
</x-master-layout>
