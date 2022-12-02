<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['driverdocument.update', $id], 'method' => 'patch', 'enctype' => 'multipart/form-data' ]) !!}
        @else
            {!! Form::open(['route' => ['driverdocument.store'], 'method' => 'post', 'enctype' => 'multipart/form-data' ]) !!}
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
                                @if(auth()->user()->hasAnyRole(['admin','demo_admin']))
                                    <div class="form-group col-md-4">
                                        {{ Form::label('driver_id', __('message.select_name',[ 'select' => __('message.driver') ]).' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                        {{ Form::select('driver_id', isset($id) ? [ optional($data->driver)->id => optional($data->driver)->display_name] : [], old('driver_id'), [
                                            'class' => 'select2js form-group driver',
                                            'required',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.driver') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'driver', 'status' => 'pending' ]),
                                        ]) }}
                                    </div>
                                @endif

                                @if(auth()->user()->hasRole('fleet'))
                                    <div class="form-group col-md-4">
                                        {{ Form::label('driver_id', __('message.select_name',[ 'select' => __('message.driver') ]).' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                        {{ Form::select('driver_id', isset($id) ? [ optional($data->driver)->id => optional($data->driver)->display_name] : [], old('driver_id'), [
                                            'class' => 'select2js form-group driver',
                                            'required',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.driver') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'driver', 'fleet_id' => auth()->user()->id, 'status' => 'pending'  ]),
                                        ]) }}
                                    </div>
                                @endif

                                @php
                                    $is_required = isset($id) && optional($data->document)->is_required == 1 ? '*' : '';
                                    $has_expiry_date = isset($id) && optional($data->document)->has_expiry_date == 1 ? 1 : '';
                                @endphp

                                <div class="form-group col-md-4">
                                    {{ Form::label('document_id', __('message.select_name',[ 'select' => __('message.document') ]).' <span class="text-danger">* </span>',['class' => 'form-control-label' ],false) }}
                                    {{ Form::select('document_id', isset($id) ? [optional($data->document)->id => optional($data->document)->name." ".$is_required] : [], old('document_id'), [
                                            'class' => 'select2js form-group document_id',
                                            'id' => 'document_id',
                                            'required',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.document') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'document']),
                                        ])
                                    }}
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="form-control-label" for="expire_date">{{ __('message.expire_date') }} <span class="text-danger" id="has_expiry_date">{{ $has_expiry_date == 1 ? '*' : ''  }}</span> </label>
                                    {{ Form::text('expire_date', old('expire_date'),[ 'class' =>'form-control min-datepicker', 'placeholder' => __('message.expire_date'), 'required' => $has_expiry_date == 1 ? 'required' : null ]) }}
                                </div>
                                
                                @if(auth()->user()->hasAnyRole(['admin','demo_admin']))
                                    <div class="form-group col-md-4">
                                        {{ Form::label('is_verified', __('message.is_verify').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                        {{ Form::select('is_verified',[ '0' => __('message.pending'), '1' => __('message.approved'), '2' => __('message.rejected') ], old('is_verified'), [ 'id' => 'is_verified', 'class' => 'form-control select2js', 'required']) }}
                                    </div>
                                @endif

                                <div class="form-group col-md-4">
                                    <label class="form-control-label" for="driver_document">{{ __('message.upload_document') }} <span class="text-danger" id="document_required"></span> </label>
                                    <div class="custom-file">
                                        <input type="file" id="driver_document" name="driver_document" class="custom-file-input" >
                                        <label class="custom-file-label">{{ __('message.choose_file', [ 'file' => __('message.document') ]) }}</label>
                                    </div>
                                    <span class="selected_file"></span>
                                </div>
                                @if( isset($id) && getMediaFileExit($data, 'driver_document'))
                                    <div class="col-md-2 mb-2">
                                        <?php
                                            $file_extention = config('constant.IMAGE_EXTENTIONS');
                                            $image = getSingleMedia($data,'driver_document');
                                            
                                            $extention = in_array(strtolower(imageExtention($image)),$file_extention);
                                        ?>
                                            @if($extention)   
                                                <img id="driver_document_preview" src="{{ $image }}" alt="#" class="attachment-image mt-1" >
                                            @else
                                                <img id="driver_document_preview" src="{{ asset('images/file.png') }}" class="attachment-file">
                                            @endif
                                            <a class="text-danger remove-file" href="{{ route('remove.file', ['id' => $data->id, 'type' => 'driver_document']) }}"
                                                data--submit="confirm_form"
                                                data--confirmation='true'
                                                data--ajax="true"
                                                title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                                data-title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                                data-message='{{ __("message.remove_file_msg") }}'>
                                                <i class="ri-close-circle-line"></i>
                                            </a>
                                            <a href="{{ $image }}" class="d-block mt-2" download target="_blank"><i class="fas fa-download "></i> {{ __('message.download') }}</a>
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
                    $(document).ready(function(){ 
                        $(document).on('change' , '#document_id' , function (){
                            var data = $('#document_id').select2('data')[0];

                            console.log(data);
                            if(data.is_required == 1)
                            {
                                $('#document_required').text('*');
                                $('#driver_document').attr('required');
                            } else {
                                $('#document_required').text('');
                                $('#driver_document').attr('required', false);
                            }

                            if(data.has_expiry_date == 1)
                            {
                                $('#has_expiry_date').text('*');
                                $('#expire_date').attr('required');
                            } else {
                                $('#has_expiry_date').text('');
                                $('#expire_date').attr('required', false);
                            }
                        })
                    })
            })(jQuery);
        </script>
    @endsection
</x-master-layout>
