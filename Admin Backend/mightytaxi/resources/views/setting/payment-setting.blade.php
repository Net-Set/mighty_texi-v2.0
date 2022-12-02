<div class="row">
    <div class="col-lg-12">
        <ul class="nav nav-pills nav-fill tabslink" id="tab-text" role="tablist">
            @foreach(config('constant.PAYMENT_GATEWAY_SETTING') as $key => $value)
                <li class="nav-item">
                    <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=payment-setting&type={{$key}}" data-target=".paste_here" data-value="{{$key}}" id="pills-{{$key}}-tab-fill" data-toggle="tabajax" role="tab" class="nav-link {{ $key == $type ? 'active' : '' }}" aria-controls="pills-{{$key}}" aria-selected="{{ $key == $type ? true : false }}"> {{ __('message.'.$key) }}</a>
                </li>
            @endforeach
        </ul>
        <div class="card">
            <div class="card-body">
                <div class="tab-content" id="pills-tabContent-1">
                    @foreach(config('constant.PAYMENT_GATEWAY_SETTING') as $key => $value)
                    <div class="tab-pane fade {{ $key == $type ? 'active show' : '' }}" id="pills-{{$key}}-fill" role="tabpanel" aria-labelledby="pills-{{$key}}-tab-fill">
                        {{ Form::model($payment_setting_data, [ 'method' => 'POST', 'route' => ['paymentSettingsUpdate'], 'enctype'=>'multipart/form-data', 'data-toggle' => 'validator' ]) }}
                            {{ Form::hidden('id', null, [ 'class' => 'form-control'] ) }}
                            {{ Form::hidden('type', $key , [ 'class' => 'form-control' ]) }}
                            <div class="row">
                                <div class="form-group col-md-4">
                                    {{ Form::label('title',__('message.title').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('title',old('title'),[ 'placeholder' => __('message.title'), 'class' => 'form-control', 'required' ]) }}
                                </div>

                                @if( $key != 'cash' )
                                    <div class="form-group col-md-4">
                                        <label class="d-block">{{ __('message.mode') }} </label>
                                        <div class="custom-control custom-radio custom-control-inline col-2">
                                            {{ Form::radio('is_test', '1' , old('is_test') || true, ['class' => 'custom-control-input', 'id' => 'is_test_test_'.$key ]) }}
                                            {{ Form::label('is_test_test_'.$key, __('message.test'), ['class' => 'custom-control-label' ]) }}
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline col-2">
                                            {{ Form::radio('is_test', '0' , old('is_test'), ['class' => 'custom-control-input', 'id' => 'is_test_live_'.$key ]) }}
                                            {{ Form::label('is_test_live_'.$key, __('message.live'), ['class' => 'custom-control-label' ]) }}
                                        </div>
                                    </div>
                                @endif
                            </div>
                            @if( $key != 'cash' )
                            <div class="row">
                                <div class="col-md-6">
                                    <h5 class="mb-3">{{ __('message.test') }}</h5>
                                    <hr>
                                    @if( is_array($value) )
                                        @foreach( $value as $val)
                                            <div class="form-group">
                                                {{ Form::label('test_value['.$val.']',__('message.'.$val),['class'=>'form-control-label'] ) }}
                                                {{ Form::text('test_value['.$val.']',null,[ 'placeholder' => __('message.'.$val), 'class' => 'form-control' ]) }}
                                            </div>
                                        @endforeach
                                    @endif
                                </div>
                                <div class="col-md-6">
                                    <h5 class="mb-3">{{ __('message.live') }}</h5>
                                    <hr>
                                    @if( is_array($value) )
                                        @foreach( $value as $val)
                                            <div class="form-group">
                                                {{ Form::label('live_value['.$val.']',__('message.'.$val),['class'=>'form-control-label'] ) }}
                                                {{ Form::text('live_value['.$val.']',null,[ 'placeholder' => __('message.'.$val), 'class' => 'form-control' ]) }}
                                            </div>
                                        @endforeach
                                    @endif
                                </div>
                            </div>
                            @endif
                            @if( $key != 'cash' )
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        {{ Form::label('status',__('message.status').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                        {{ Form::select('status',[ '1' => __('message.active'), '0' => __('message.inactive') ], old('status'), [ 'class' =>'form-control select2js','required']) }}
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label class="form-control-label" for="image">{{ __('message.image') }} </label>
                                        <div class="custom-file">
                                            <input type="file" name="gateway_image" class="custom-file-input" accept="image/*">
                                            <label class="custom-file-label">{{  __('message.choose_file',['file' =>  __('message.image') ]) }}</label>
                                        </div>
                                        <span class="selected_file"></span>
                                    </div>
        
                                    @if( isset($payment_setting_data) && getMediaFileExit($payment_setting_data, 'gateway_image'))
                                        <div class="col-md-2 mb-2">
                                            <img id="gateway_image_preview" src="{{ getSingleMedia($payment_setting_data,'gateway_image') }}" alt="gateway-image" class="attachment-image mt-1">
                                            <a class="text-danger remove-file" href="{{ route('remove.file', ['id' => $payment_setting_data->id, 'type' => 'gateway_image']) }}"
                                                data--submit='confirm_form' data--confirmation='true'
                                                data--ajax='true' data-toggle='tooltip'
                                                title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                                data-title='{{ __("message.remove_file_title" , ["name" =>  __("message.image") ]) }}'
                                                data-message='{{ __("message.remove_file_msg") }}'>
                                                <i class="ri-close-circle-line"></i>
                                            </a>
                                        </div>
                                        @else
                                        <div class="col-md-2 mb-2">
                                            <img src="{{ asset('images/'.$key.'.png') }}" alt="gateway-image" class="attachment-image mt-1">
                                        </div>
                                    @endif
                                </div>
                            @endif
                            <hr>
                        {{ Form::submit(__('message.save'), ['class'=>"btn btn-md btn-primary float-md-right"]) }}
                        {{ Form::close() }}
                    </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>