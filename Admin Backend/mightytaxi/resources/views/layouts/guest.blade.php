<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>
        <link rel="shortcut icon" class="site_favicon_preview" href="{{ getSingleMedia(appSettingData('get'), 'site_favicon', null) }}" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">

        <!-- Styles -->
        <link rel="stylesheet" href="{{ asset('css/backend.css') }}">


        @if(isset($assets) && in_array('phone', $assets))
            <link rel="stylesheet" href="{{ asset('vendor/intlTelInput/css/intlTelInput.css') }}">
        @endif
    </head>
    <body class=" " >

        <div class="wrapper">
            {{ $slot }}
        </div>
         @include('partials._scripts')
    </body>
    <script>
        @if(isset($assets) && in_array('phone', $assets))
            var input = document.querySelector("#phone"), 
            errorMsg = document.querySelector("#error-msg"),
            validMsg = document.querySelector("#valid-msg");

            if(input) {
                var iti = window.intlTelInput(input, {
                    hiddenInput: "contact_number",
                    separateDialCode: true,
                    utilsScript: "{{ asset('vendor/intlTelInput/js/utils.js') }}" // just for formatting/placeholders etc
                });

                input.addEventListener("countrychange", function() {
                  validate();
                });

                // // here, the index maps to the error code returned from getValidationError - see readme
                var errorMap = [ "Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];
                //
                // // initialise plugin
                const phone = $('#phone');
                const err = $('#error-msg');
                const succ = $('#valid-msg');
                var reset = function() {
                    err.addClass('d-none');
                    succ.addClass('d-none');
                    validate();
                };

                // on blur: validate
                $(document).on('blur, keyup','#phone',function () {
                    reset();
                    var val = $(this).val();
                    if (val.match(/[^0-9\.\+.\s.]/g)) {
                        $(this).val(val.replace(/[^0-9\.\+.\s.]/g, ''));
                    }
                    if(val === ''){
                        $('[type="submit"]').removeClass('disabled').prop('disabled',false);
                    }
                });

                // on keyup / change flag: reset
                input.addEventListener('change', reset);
                input.addEventListener('keyup', reset);

                var errorCode = '';

                function validate() {
                    if (input.value.trim()) {
                        if (iti.isValidNumber()) {
                            succ.removeClass('d-none');
                            err.html('');
                            err.addClass('d-none');
                            $('[type="submit"]').removeClass('disabled').prop('disabled',false);
                        } else {
                            errorCode = iti.getValidationError();
                            err.html(errorMap[errorCode]);
                            err.removeClass('d-none');
                            phone.closest('.form-group').addClass('has-danger');
                            $('[type="submit"]').addClass('disabled').prop('disabled',true);
                        }
                    }
                }
            }
        @endif
    </script>
</html>
