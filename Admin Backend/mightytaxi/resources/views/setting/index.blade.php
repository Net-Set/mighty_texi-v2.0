<x-master-layout :assets="$assets ?? []">
    <div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card card-block card-stretch">
                    <div class="card-body p-0">
                        <div class="d-flex justify-content-between align-items-center p-3">
                            <h5 class="font-weight-bold">{{ $pageTitle ?? __('message.list') }}</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <ul class="nav nav-tabs" role="tablist">
                            @if(in_array( $page,['profile_form','password_form']))
                                <li class="nav-item">
                                    <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=profile_form" data-target=".paste_here" class="nav-link {{$page=='profile_form'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.profile')}} </a>
                                </li>
                                <li class="nav-item">
                                    <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=password_form" data-target=".paste_here" class="nav-link {{$page=='password_form'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.change_password') }} </a>
                                </li>
                            @else
                                @hasanyrole('admin|demo_admin')
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=general-setting" data-target=".paste_here" class="nav-link {{$page=='general-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.general_settings') }}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=mobile-config" data-target=".paste_here" class="nav-link {{$page=='mobile-config'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.mobile_config') }}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=wallet-setting" data-target=".paste_here" class="nav-link {{$page=='wallet-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.wallet_setting') }}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=ride-setting" data-target=".paste_here" class="nav-link {{$page=='ride-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.ride_setting') }}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=mail-setting" data-target=".paste_here" class="nav-link {{$page=='mail-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.mail_settings') }}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=language-setting" data-target=".paste_here" class="nav-link {{$page=='language-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.language_settings') }}</a>
                                    </li>
                                    {{-- <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=notification-setting" data-target=".paste_here" class="nav-link {{$page=='notification-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.notification_settings') }}</a>
                                    </li> --}}
                                    <li class="nav-item">
                                        <a href="javascript:void(0)" data-href="{{ route('layout_page') }}?page=payment-setting" data-target=".paste_here" class="nav-link {{$page=='payment-setting'?'active':''}}"  data-toggle="tabajax" rel="tooltip"> {{ __('message.payment_settings') }}</a>
                                    </li>
                                @endhasanyrole
                            @endif
                        </ul>
                        <div class="tab-content">
                            <div class="paste_here"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    @section('bottom_script')
        <script>
            $(document).ready(function(event)
            {
                var $this = $('.nav-item').find('a.active');
                loadurl = "{{route('layout_page')}}?page={{$page}}";

                targ = $this.attr('data-target');
                
                id = this.id || '';

                $.post(loadurl,{ '_token': $('meta[name=csrf-token]').attr('content') } ,function(data) {
                    $(targ).html(data);
                });

                $this.tab('show');
                return false;
            });
        </script>
    @endsection
</x-master-layout>