<x-guest-layout :assets="$assets ?? []">
<section class="login-content">
    <div class="container h-100">
        <div class="row align-items-center justify-content-center h-100">
            <div class="col-md-7">
                <div class="card">
                    <div class="card-body">
                        <div class="auth-logo">
                            <img src="{{ getSingleMedia(appSettingData('get'),'site_logo',null) }}" class="img-fluid mode light-img rounded-normal" alt="logo">
                            <img src="{{ getSingleMedia(appSettingData('get'),'site_dark_logo',null) }}" class="img-fluid mode dark-img rounded-normal darkmode-logo site_dark_logo_preview" alt="dark-logo">
                        </div>
                        <h2 class="mb-2 text-center">{{ __('message.sign_up') }}</h2>
                        <!-- Session Status -->
                        <x-auth-session-status class="mb-4" :status="session('status')" />

                        <!-- Validation Errors -->
                        <x-auth-validation-errors class="mb-4" :errors="$errors" />
                        <form method="POST" action="{{ route('register') }}" data-toggle="validator">
                            {{csrf_field()}}
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
                                
                                <div class="form-group col-md-6">
                                    {{ Form::label('password',__('message.password').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::password('password', ['class' => 'form-control', 'placeholder' => __('message.password') ]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('password_confirmation',__('message.confirm_password').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::password('password_confirmation', ['class' => 'form-control', 'placeholder' => __('message.password') ]) }}
                                </div>

                                <div class="form-group col-md-6">
                                    {{ Form::label('contact_number',__('message.contact_number').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::text('contact_number', old('contact_number'),[ 'placeholder' => __('message.contact_number'), 'class' => 'form-control', 'id' => 'phone' ]) }}
                                </div>
                                
                                <div class="form-group col-md-6">
                                    {{ Form::label('gender',__('message.gender').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('gender',[ 'male' => __('message.male'), 'female' => __('message.female'), 'other' => __('message.other') ], old('gender'), [ 'class' => 'form-control select2js', 'required' ]) }}
                                </div>
                                <div class="col-lg-12">
                                    <div class="custom-control custom-checkbox mb-3 form-group">
                                        <input type="checkbox" class="custom-control-input" id="customCheck1" required>
                                        <label class="custom-control-label" for="customCheck1">{{ __('message.i_agree_terms') }}</label>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span> {{ __('message.already_have_an_account') }} <a href="{{route('auth.login')}}" class="text-primary">{{ __('message.sign_in') }}</a></span>
                                <button type="submit" class="btn btn-primary">{{ __('message.sign_up') }}</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</x-guest-layout>
