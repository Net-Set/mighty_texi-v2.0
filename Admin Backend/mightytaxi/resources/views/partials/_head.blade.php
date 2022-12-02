<link rel="shortcut icon" class="site_favicon_preview" href="{{ getSingleMedia(appSettingData('get'), 'site_favicon', null) }}" />
<link rel="stylesheet" href="{{ asset('css/backend-bundle.min.css') }}"/>
<link rel="stylesheet" href="{{ asset('css/backend.css') }}"/>
<link rel="stylesheet" href="{{ asset('vendor/@fortawesome/fontawesome-free/css/all.min.css') }}"/>
<link rel="stylesheet" href="{{ asset('vendor/remixicon/fonts/remixicon.css') }}"/>
<link rel="stylesheet" href="{{ asset('css/vendor/select2.min.css')}}">
<link rel="stylesheet" href="{{ asset('vendor/confirmJS/jquery-confirm.min.css') }}"/>
<link rel="stylesheet" href="{{ asset('css/custom.css')}}">
@if(isset($assets) && in_array('phone', $assets))
    <link rel="stylesheet" href="{{ asset('vendor/intlTelInput/css/intlTelInput.css') }}">
@endif