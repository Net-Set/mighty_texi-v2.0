<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['driver.update', $id], 'method' => 'patch' , 'enctype' => 'multipart/form-data']) !!}
        @else
            {!! Form::open(['route' => ['driver.store'], 'method' => 'post', 'enctype' => 'multipart/form-data']) !!}
        @endif
        <div class="row">
            <div class="col-xl-3 col-lg-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ $pageTitle }}</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="crm-profile-img-edit position-relative">
                                <img src="{{ $profileImage ?? asset('images/user/1.jpg')}}" alt="User-Profile" class="crm-profile-pic rounded-circle avatar-100">
                                <div class="crm-p-image bg-primary">
                                    <svg class="upload-button" width="14" height="14" viewBox="0 0 24 24">
                                        <path fill="#ffffff" d="M14.06,9L15,9.94L5.92,19H5V18.08L14.06,9M17.66,3C17.41,3 17.15,3.1 16.96,3.29L15.13,5.12L18.88,8.87L20.71,7.04C21.1,6.65 21.1,6 20.71,5.63L18.37,3.29C18.17,3.09 17.92,3 17.66,3M14.06,6.19L3,17.25V21H6.75L17.81,9.94L14.06,6.19Z" />
                                    </svg>
                                    <input class="file-upload" type="file" accept="image/*" name="profile_image">
                                </div>
                            </div>
                            <div class="img-extension mt-3">
                                <div class="d-inline-block align-items-center">
                                    <span>{{ __('message.only') }}</span>

                                    @foreach(config('constant.IMAGE_EXTENTIONS') as $extention)
                                        <a href="javascript:void();">.{{ $extention }}</a>
                                    @endforeach
                                    <span>{{ __('message.allowed') }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">{{ __('message.status') }}</label>
                            <div class="grid" style="--bs-gap: 1rem">
                                <div class="form-check g-col-6">
                                    {{ Form::radio('status', 'active' , old('status') || true, ['class' => 'form-check-input', 'id' => 'status-active' ]) }}
                                    {{ Form::label('status-active', __('message.active'), ['class' => 'form-check-label' ]) }}
                                </div>
                                <div class="form-check g-col-6">
                                    {{ Form::radio('status', 'inactive', old('status') , ['class' => 'form-check-input', 'id' => 'status-inactive' ]) }}
                                    {{ Form::label('status-inactive', __('message.inactive'), ['class' => 'form-check-label' ]) }}
                                </div>
                                <div class="form-check g-col-6">
                                    {{ Form::radio('status', 'pending', old('status') , ['class' => 'form-check-input', 'id' => 'status-pending' ]) }}
                                    {{ Form::label('status-pending', __('message.pending'), ['class' => 'form-check-label' ]) }}
                                </div>
                                <div class="form-check g-col-6">
                                    {{ Form::radio('status', 'banned', old('status') , ['class' => 'form-check-input', 'id' => 'status-banned' ]) }}
                                    {{ Form::label('status-banned', __('message.banned'), ['class' => 'form-check-label' ]) }}
                                </div>
                                <div class="form-check g-col-6">
                                    {{ Form::radio('status', 'reject', old('status') , ['class' => 'form-check-input', 'id' => 'status-reject' ]) }}
                                    {{ Form::label('status-reject', __('message.reject'), ['class' => 'form-check-label' ]) }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-9 col-lg-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ $pageTitle }} {{ __('message.information') }}</h4>
                        </div>
                        <div class="card-action">
                            <a href="{{route('driver.index')}}" class="btn btn-sm btn-primary" role="button">{{ __('message.back') }}</a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="new-user-info">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    {{ Form::label('first_name',__('message.first_name').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('first_name',old('first_name'),['placeholder' => __('message.first_name'),'class' =>'form-control','required']) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('last_name',__('message.last_name').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('last_name',old('last_name'),['placeholder' => __('message.last_name'),'class' =>'form-control','required']) }}
                                </div>
                                
                                <div class="form-group col-md-6">
                                    {{ Form::label('email',__('message.email').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::email('email', old('email'), [ 'placeholder' => __('message.email'), 'class' => 'form-control', 'required' ]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('username',__('message.username').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('username', old('username'), ['class' => 'form-control', 'required', 'placeholder' => __('message.username') ]) }}
                                </div>

                                @if(!isset($id))
                                    <div class="form-group col-md-6">
                                        {{ Form::label('password',__('message.password').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                        {{ Form::password('password', ['class' => 'form-control', 'placeholder' =>  __('message.password') ]) }}
                                    </div>
                                @endif

                                <div class="form-group col-md-6">
                                    {{ Form::label('contact_number',__('message.contact_number').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('contact_number', old('contact_number'),[ 'placeholder' => __('message.contact_number'), 'class' => 'form-control', 'id' => 'phone' ]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('gender',__('message.gender').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('gender',[ 'male' => __('message.male') ,'female' => __('message.female') , 'other' => __('message.other') ], old('gender') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>
                                {{--
                                @if(auth()->user()->hasAnyRole(['admin','demo_admin']))
                                <div class="form-group col-md-6">
                                    {{ Form::label('fleet_id', __('message.fleet'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('fleet_id', isset($id) ? [ optional($data->fleet)->id => optional($data->fleet)->display_name ] : [] , old('fleet_id') , [
                                        'data-ajax--url' => route('ajax-list', [ 'type' => 'fleet' ]),
                                        'data-placeholder' => __('message.select_field', [ 'name' => __('message.fleet') ]),
                                        'class' =>'form-control select2js'
                                        ])
                                    }}
                                </div>
                                @endif
                                --}}

                                 <!-- Service List -->
                                <div class="form-group col-md-6">
                                    {{ Form::label('service_id', __('message.select_name',[ 'select' => __('message.service') ]),[ 'class' => 'form-control-label' ]) }} 
                                    {{ Form::select('service_id', isset($id) ? [ optional($data->service)->id => optional($data->service)->name ] : [], old('service_id'), [
                                            'class' => 'select2js form-group service',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.service') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'service']),
                                        ])
                                    }}
                                </div>
                                {{--
                                <div class="form-group col-md-6">
                                    {{ Form::label('service_id', __('message.select_name',[ 'select' => __('message.service') ]),[ 'class' => 'form-control-label' ]) }}
                                    <br />
                                    {{ Form::select('service_id[]', $selected_service, isset($id) ? $data->driverService->pluck('service_id') : null, [
                                            'class' => 'select2js form-group service',
                                            'multiple' => 'multiple',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.service') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'service']),
                                        ])
                                    }}
                                </div>
                                --}}
                                <div class="form-group col-md-6">
                                    {{ Form::label('car_model',__('message.car_model').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('userDetail[car_model]', old('userDetail[car_model]'), ['class' => 'form-control', 'placeholder' => __('message.car_model')]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('car_color',__('message.car_color').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('userDetail[car_color]', old('userDetail[car_color]'), ['class' => 'form-control', 'placeholder' => __('message.car_color')]) }}
                                </div>
                                
                                <div class="form-group col-md-6">
                                    {{ Form::label('car_plate_number',__('message.car_plate_number').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('userDetail[car_plate_number]', old('userDetail[car_plate_number]'), ['class' => 'form-control', 'placeholder' => __('message.car_plate_number')]) }}
                                </div>
                                
                                <div class="form-group col-md-6">
                                    {{ Form::label('car_production_year',__('message.car_production_year').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('userDetail[car_production_year]', old('userDetail[car_production_year]'), ['class' => 'form-control', 'placeholder' => __('message.car_production_year')]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('address',__('message.address'), ['class' => 'form-control-label']) }}
                                    {{ Form::textarea('address', null, ['class'=>"form-control textarea" , 'rows'=>3  , 'placeholder'=> __('message.address') ]) }}
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
