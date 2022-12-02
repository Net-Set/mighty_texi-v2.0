<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['service.update', $id], 'method' => 'patch' , 'enctype' => 'multipart/form-data']) !!}
        @else
            {!! Form::open(['route' => ['service.store'], 'method' => 'post', 'enctype' => 'multipart/form-data']) !!}
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
                                    {{ Form::label('name',__('message.name').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('name',old('name'),['placeholder' => __('message.name'),'class' =>'form-control','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    @if ( $id == null )
                                        <label class="form-control-label" for="region_id">{{ __('message.region') }} <span class="text-danger" id="distance_unit">* </span></label>
                                    @else
                                        <label class="form-control-label" for="region_id">{{ __('message.region') }} <span class="text-danger" id="distance_unit">* (<small>{{ __('message.distance_in_'.optional($data->region)->distance_unit )  }}</small>)</span> </label>
                                    @endif
                                    {{ Form::select('region_id', isset($id) ? [ optional($data->region)->id => optional($data->region)->name ] : [] , old('region_id') , [
                                        'data-ajax--url' => route('ajax-list', [ 'type' => 'region' ]),
                                        'data-placeholder' => __('message.select_field', [ 'name' => __('message.region') ]),
                                        'class' =>'form-control select2js', 'required',
                                        'data-distance-unit' => isset($id) ? optional($data->region)->distance_unit : '',
                                        'id' => 'region_id'
                                        ])
                                    }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('capacity', __('message.capacity').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('capacity', old('capacity'),[ 'min' => 1, 'placeholder' => __('message.capacity'),'class' =>'form-control','required']) }}
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('base_fare', __('message.base_fare').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('base_fare', old('base_fare'), ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.base_fare') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('minimum_fare', __('message.minimum_fare').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('minimum_fare', old('minimum_fare'), ['class' => 'form-control',  'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.minimum_fare') ]) }}
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('minimum_distance',__('message.minimum_distance').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('minimum_distance', old('minimum_distance'),  ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'placeholder' =>  __('message.minimum_distance') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('per_distance',__('message.per_distance').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('per_distance', old('per_distance'),[ 'min' => 0, 'step' => 'any', 'placeholder' => __('message.per_distance'), 'class' => 'form-control' ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('per_minute_drive',__('message.per_minute_drive').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::number('per_minute_drive', old('per_minute_drive'),[ 'min' => 0, 'step' => 'any', 'placeholder' => __('message.per_minute_drive'), 'class' => 'form-control' ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('waiting_time_limit',__('message.waiting_time_limit').'('.__('message.in_minutes').')<span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::number('waiting_time_limit', old('waiting_time_limit'),[ 'min' => 0, 'step' => 'any', 'placeholder' => __('message.waiting_time_limit'), 'class' => 'form-control' ]) }}
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('per_minute_wait',__('message.per_minute_wait').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::number('per_minute_wait', old('per_minute_wait'),[  'min' => 0, 'step' => 'any', 'placeholder' => __('message.per_minute_wait'), 'class' => 'form-control' ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('cancellation_fee', __('message.cancellation_fee').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('cancellation_fee', old('cancellation_fee'), ['class' => 'form-control',  'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.cancellation_fee') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('payment_method',__('message.payment_method').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('payment_method',[ 'cash' => __('message.cash') ,'wallet' => __('message.wallet') , 'cash_wallet' => __('message.cash_wallet') ], old('payment_method') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('commission_type',__('message.commission_type'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('commission_type',[ 'fixed' => __('message.fixed') ,'percentage' => __('message.percentage') ], old('commission_type') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('admin_commission', __('message.admin_commission').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false) }}
                                    {{ Form::number('admin_commission', old('admin_commission'),[  'min' => 0, 'step' => 'any', 'placeholder' => __('message.admin_commission'), 'class' => 'form-control' ]) }}
                                </div>

                            {{--<div class="form-group col-md-4">
                                    {{ Form::label('fleet_commission', __('message.fleet_commission').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false) }}
                                    {{ Form::number('fleet_commission', old('fleet_commission'),[ 'min' => 0, 'step' => 'any', 'placeholder' => __('message.fleet_commission'), 'class' => 'form-control' ]) }}
                                </div>--}}

                                <div class="form-group col-md-4">
                                    {{ Form::label('status',__('message.status').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('status',[ '1' => __('message.active'), '0' => __('message.inactive') ], old('status'), [ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="form-control-label" for="image">{{ __('message.image') }} </label>
                                    <div class="custom-file">
                                        <input type="file" name="service_image" class="custom-file-input" accept="image/*">
                                        <label class="custom-file-label">{{  __('message.choose_file',['file' =>  __('message.image') ]) }}</label>
                                    </div>
                                    <span class="selected_file"></span>
                                </div>

                                @if( isset($id) && getMediaFileExit($data, 'service_image'))
                                    <div class="col-md-2 mb-2">
                                        <img id="service_image_preview" src="{{ getSingleMedia($data,'service_image') }}" alt="service-image" class="attachment-image mt-1">
                                        <a class="text-danger remove-file" href="{{ route('remove.file', ['id' => $data->id, 'type' => 'service_image']) }}"
                                            data--submit='confirm_form'
                                            data--confirmation='true'
                                            data--ajax='true'
                                            data-toggle='tooltip'
                                            title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                            data-title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                            data-message='{{ __("message.remove_file_msg") }}'>
                                            <i class="ri-close-circle-line"></i>
                                        </a>
                                    </div>
                                @endif
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
    <script type="text/javascript">
        (function($) {
            "use strict";
            $(document).ready(function() {
                $(document).on('change', '#region_id' , function () {

                    var data = $(this).select2('data')[0];

                    var data_distance_unit = $('#region_id').attr('data-distance-unit',)
                    var distance_unit = data.distance_unit != undefined ? data.distance_unit : data_distance_unit;
                    
                    var text = "{{  __('message.distance_in_km') }}";
                    if ( distance_unit == 'mile' ) {
                        text = "{{  __('message.distance_in_mile') }}";
                    }
                    $('#distance_unit').html("* (<small>"+ text +"</small>)");
                });
            });
        })(jQuery);
    </script>
    @endsection
</x-master-layout>
