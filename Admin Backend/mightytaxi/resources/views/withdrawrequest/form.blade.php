<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['withdrawrequest.update', $id], 'method' => 'patch' ]) !!}
        @else
            {!! Form::open(['route' => ['withdrawrequest.store'], 'method' => 'post' ]) !!}
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
                                @if(isset($id))
                                    <div class="form-group col-md-4">
                                        {{ Form::label('user_id',__('message.name'),[ 'class' => 'form-control-label' ]) }}
                                        <p>{{ optional($data->user)->display_name }}</p>
                                    </div>
                                @endif

                                <div class="form-group col-md-4">
                                    {{ Form::label('amount', __('message.amount').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    @if(!isset($id))
                                        {{ Form::number('amount', old('amount'), ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.amount') ]) }}
                                    @else
                                        <p>{{ $data->amount }}</p>
                                    @endif
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('status',__('message.status'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('status',[ '0' => __('message.requested'), '1' => __('message.approved'), '2' => __('message.decline') ], old('status') ,[ 'class' =>'form-control select2js','required']) }}
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
</x-master-layout>