<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['complaint.update', $id], 'method' => 'patch' , 'enctype' => 'multipart/form-data']) !!}
        @else
            {!! Form::open(['route' => ['complaint.store'], 'method' => 'post', 'enctype' => 'multipart/form-data']) !!}
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
                                    {{ Form::label('subject',__('message.subject').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('subject',old('subject'),['placeholder' => __('message.subject'),'class' =>'form-control','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('ride_request_id', __('message.riderequest'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('ride_request_id', isset($id) ? [ $data->ride_request_id => '#'.$data->ride_request_id ] : [] , old('ride_request_id') , [
                                        'data-ajax--url' => route('ajax-list', [ 'type' => 'riderequest' ]),
                                        'data-placeholder' => __('message.select_field', [ 'name' => __('message.riderequest') ]),
                                        'class' =>'form-control select2js', 'required',
                                        'id' => 'ride_request_id'
                                        ])
                                    }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('rider_id', __('message.rider'), ['class' => 'form-control-label']) }}
                                    <p id="rider_name">{{ isset($id) ? optional($data->rider)->display_name : '-' }}</p>
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('driver_id', __('message.driver'), ['class' => 'form-control-label']) }}
                                    
                                    <p id="driver_name">{{ isset($id) ? optional($data->driver)->display_name : '-' }}</p>
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('complaint_by',__('message.complaint_by').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('complaint_by',[ 'rider' => __('message.rider') ,'driver' => __('message.driver') ], old('complaint_by') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('status',__('message.status'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('status',[ 'pending' => __('message.pending'), 'resolved' => __('message.resolved'), 'investigation' => __('message.investigation') ], old('status') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('description',__('message.description'), ['class' => 'form-control-label']) }}
                                    {{ Form::textarea('description', null, ['class'=>"form-control textarea" , 'rows'=>3  , 'placeholder'=> __('message.description') ]) }}
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
        <script>
            $(document).ready(function() {                
                $('#ride_request_id').on('select2:select', function (e) {
                    let data = e.params.data;
                    console.log(data);
                    $('#rider_name').text( data.rider['display_name'] )
                    if( data.driver_id != null ) {
                        $('#driver_name').text( data.driver['display_name'] )
                    } else {
                        $('#driver_name').text('-');
                    }
                });
            });
        </script>
    @endsection
</x-master-layout>
