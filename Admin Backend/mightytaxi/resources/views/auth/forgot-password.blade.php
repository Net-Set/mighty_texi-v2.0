<x-guest-layout>
    <section class="login-content">
        <div class="container h-100">
            <div class="row align-items-center justify-content-center h-100">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="auth-logo">
                                <img src="{{ getSingleMedia(appSettingData('get'),'site_logo',null) }}" class="img-fluid mode light-img rounded-normal" alt="logo">
                                <img src="{{ getSingleMedia(appSettingData('get'),'site_dark_logo',null) }}" class="img-fluid mode dark-img rounded-normal darkmode-logo site_dark_logo_preview" alt="dark-logo">
                            </div>
                            <h2 class="mb-2 text-center">{{ __('auth.reset_password') }}</h2>
                            <p>{{ __('auth.reset_password_description') }}</p>
                            <!-- Session Status -->
                            <x-auth-session-status class="mb-4" :status="session('status')" />

                            <!-- Validation Errors -->
                            <x-auth-validation-errors class="mb-4" :errors="$errors" />

                            <form method="POST" action="{{ route('password.email') }}">
                                {{csrf_field()}}
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            {{ Form::label('email',__('message.email').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                            {{ Form::email('email', old('email'), [ 'placeholder' => __('message.email'), 'class' => 'form-control', 'required' ]) }}
                                        </div>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block">{{ __('auth.email_password_reset_link') }}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</x-guest-layout>
