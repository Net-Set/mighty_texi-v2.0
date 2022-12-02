@php
    $url = '';

    $MyNavBar = \Menu::make('MenuList', function ($menu) use($url){
        
        //Admin Dashboard
        $menu->add('<span>'.__('message.dashboard').'</span>', ['route' => 'home'])
            ->prepend('<i class="fas fa-home"></i>')            
            ->link->attr(['class' => '']); 
        
        $menu->add('<span>'.__('message.rider').'</span>', ['class' => ''])
            ->prepend('<i class="fas fa-user"></i>')
            ->nickname('rider')
            ->data('permission', 'rider list')
            ->link->attr(['class' => ''])
            ->href('#rider');

            $menu->rider->add('<span>'.__('message.list_form_title',['form' => __('message.rider')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'rider.index'])
                ->data('permission', 'rider list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->rider->add('<span>'.__('message.add_form_title',['form' => __('message.rider')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'rider.create'])
                ->data('permission', [ 'rider add', 'rider edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.region').'</span>', ['class' => ''])
            ->prepend('<i class="fas fa-globe"></i>')
            ->nickname('region')
            ->data('permission', 'region list')
            ->link->attr(['class' => ''])
            ->href('#region');

            $menu->region->add('<span>'.__('message.list_form_title',['form' => __('message.region')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'region.index'])
                ->data('permission', 'region list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->region->add('<span>'.__('message.add_form_title',['form' => __('message.region')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'region.create'])
                ->data('permission', [ 'region add', 'region edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.service').'</span>', [ 'class' => '', 'route' => 'service.index'])
            ->prepend('<i class="fas fa-taxi"></i>')
            ->nickname('service')
            ->data('permission', 'service list')
            ->link->attr(['class' => ''])
            ->href('#service');

            $menu->service->add('<span>'.__('message.list_form_title',['form' => __('message.service')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'service.index'])
                ->data('permission', 'service list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->service->add('<span>'.__('message.add_form_title',['form' => __('message.service')]).'</span>', ['class' => request()->is('service/*/edit') ? 'sidebar-layout active' : 'sidebar-layout','route' => 'service.create'])
                ->data('permission', [ 'service add', 'service edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.driver').'</span>', ['class' => ''])
            ->prepend('<i class="fas fa-id-card"></i>')
            ->nickname('driver')
            ->data('permission', 'driver list')
            ->link->attr(['class' => ''])
            ->href('#driver');
            
            $menu->driver->add('<span>'.__('message.list_form_title',['form' => __('message.driver')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'driver.index'])
                ->data('permission', 'driver list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->driver->add('<span>'.__('message.add_form_title',['form' => __('message.driver')]).'</span>', ['class' => request()->is('driver/*/edit') ? 'sidebar-layout active' : 'sidebar-layout', 'route' => 'driver.create'])
                ->data('permission', [ 'driver add', 'driver edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);
            
            $menu->driver->add('<span>'.__('message.manage_driver_document').'</span>', ['class' => ( request()->is('driverdocument') || request()->is('driverdocument/*') ) ? 'sidebar-layout active' : 'sidebar-layout', 'route' => 'driverdocument.index'])
                ->data('permission', ['driverdocument list'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.document').'</span>', ['class' => ''])
            ->prepend('<i class="fas fa-file"></i>')
            ->nickname('document')
            ->data('permission', 'document list')
            ->link->attr(['class' => ''])
            ->href('#document');
            
            $menu->document->add('<span>'.__('message.list_form_title',['form' => __('message.document')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'document.index'])
                ->data('permission', 'document list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->document->add('<span>'.__('message.add_form_title',['form' => __('message.document')]).'</span>', ['class' => request()->is('document/*/edit') ? 'sidebar-layout active' : 'sidebar-layout', 'route' => 'document.create'])
                ->data('permission', [ 'document add', 'document edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.coupon').'</span>', [ 'class' => ''])
            ->prepend('<i class="fas fa-gift"></i>')
            ->nickname('coupon')
            ->data('permission', 'coupon list')
            ->link->attr(['class' => ''])
            ->href('#coupon');
            
            $menu->coupon->add('<span>'.__('message.list_form_title',['form' => __('message.coupon')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'coupon.index'])
                ->data('permission', 'coupon list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->coupon->add('<span>'.__('message.add_form_title',['form' => __('message.coupon')]).'</span>', ['class' => request()->is('coupon/*/edit') ? 'sidebar-layout active' : 'sidebar-layout', 'route' => 'coupon.create'])
                ->data('permission', [ 'coupon add', 'coupon edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.riderequest').'</span>', [ 'class' => '' ])
            ->prepend('<i class="fas fa-car-side"></i>')
            ->nickname('riderequest')
            ->data('permission', 'riderequest list')
            ->link->attr(['class' => ''])
            ->href('#riderequest');

            $menu->riderequest->add('<span>'.__('message.list_form_title',['form' => __('message.riderequest')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'riderequest.index'])
                ->data('permission', 'riderequest list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.complaint').'</span>', [ 'class' => '', 'route' => 'complaint.index'])
            ->prepend('<i class="fas fa-file-alt"></i>')
            ->data('permission', 'complaint list')
            ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.withdrawrequest').'</span>', [ 'class' => '', 'route' => 'withdrawrequest.index'])
            ->prepend('<i class="fas fa-money-check"></i>')
            ->data('permission', 'withdrawrequest list')
            ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.account_setting').'</span>', ['class' => ''])
            ->prepend('<i class="fas fa-users-cog"></i>')
            ->nickname('account_setting')
            ->data('permission', ['role list','permission list'])
            ->link->attr(["class" => ""])
            ->href('#account_setting');

            $menu->account_setting->add('<span>'.__('message.list_form_title',['form' => __('message.role')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'role.index'])
                ->data('permission', 'role list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->account_setting->add('<span>'.__('message.list_form_title',['form' => __('message.permission')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'permission.index'])
                ->data('permission', 'permission list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.additionalfees').'</span>', [ 'class' => ''])
            ->prepend('<i class="fas fa-address-book"></i>')
            ->nickname('additionalfees')
            ->data('permission', 'additionalfees list')
            ->link->attr(['class' => ''])
            ->href('#additionalfees');

            $menu->additionalfees->add('<span>'.__('message.list_form_title',['form' => __('message.additionalfees')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'additionalfees.index'])
                ->data('permission', 'additionalfees list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->additionalfees->add('<span>'.__('message.add_form_title',['form' => __('message.additionalfees')]).'</span>', ['class' => request()->is('additionalfees/*/edit') ? 'sidebar-layout active' : 'sidebar-layout','route' => 'additionalfees.create'])
                ->data('permission', [ 'additionalfees add', 'additionalfees edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);
        
        $menu->add('<span>'.__('message.sos').'</span>', [ 'class' => ''])
            ->prepend('<i class="fas fa-address-book"></i>')
            ->nickname('sos')
            ->data('permission', 'sos list')
            ->link->attr(['class' => ''])
            ->href('#sos');

            $menu->sos->add('<span>'.__('message.list_form_title',['form' => __('message.sos')]).'</span>', ['class' => 'sidebar-layout' ,'route' => 'sos.index'])
                ->data('permission', 'sos list')
                ->prepend('<i class="fas fa-list"></i>')
                ->link->attr(['class' => '']);

            $menu->sos->add('<span>'.__('message.add_form_title',['form' => __('message.sos')]).'</span>', ['class' => request()->is('sos/*/edit') ? 'sidebar-layout active' : 'sidebar-layout','route' => 'sos.create'])
                ->data('permission', [ 'sos add', 'sos edit'])
                ->prepend('<i class="fas fa-plus-square"></i>')
                ->link->attr(['class' => '']);

        $menu->add('<span>'.__('message.pages').'</span>', ['class' => ''])
                ->prepend('<i class="fas fa-file"></i>')
                ->nickname('pages')
                ->data('permission', 'pages')
                ->link->attr(['class' => ''])
                ->href('#pages');
                $menu->pages->add('<span>'.__('message.terms_condition').'</span>', ['class' => 'sidebar-layout' ,'route' => 'term-condition'])
                    ->data('permission', 'terms condition')
                    ->prepend('<i class="fas fa-file-contract"></i>')
                    ->link->attr(['class' => '']);
                
                $menu->pages->add('<span>'.__('message.privacy_policy').'</span>', ['class' => 'sidebar-layout' ,'route' => 'privacy-policy'])
                    ->data('permission', 'privacy policy')
                    ->prepend('<i class="fas fa-user-shield"></i>')
                    ->link->attr(['class' => '']);       
        
        $menu->add('<span>'.__('message.setting').'</span>', ['route' => 'setting.index'])
                ->prepend('<i class="fas fa-cog"></i>')
                ->nickname('setting')
                ->data('permission', 'system setting');
        

        })->filter(function ($item) {
            return checkMenuRoleAndPermission($item);
        });
@endphp

<div class="mm-sidebar sidebar-default">
    <div class="mm-sidebar-logo d-flex align-items-center justify-content-between">
        <a href="{{ route('home') }}" class="header-logo">
            <img src="{{ getSingleMedia(appSettingData('get'),'site_logo',null) }}" class="img-fluid mode light-img rounded-normal light-logo site_logo_preview" alt="logo">
            <img src="{{ getSingleMedia(appSettingData('get'),'site_dark_logo',null) }}" class="img-fluid mode dark-img rounded-normal darkmode-logo site_dark_logo_preview" alt="dark-logo">
        </a>
        <div class="side-menu-bt-sidebar">
            <i class="fas fa-bars wrapper-menu"></i>
        </div>
    </div>

    <div class="data-scrollbar" data-scroll="1">
        <nav class="mm-sidebar-menu">
            <ul id="mm-sidebar-toggle" class="side-menu">
                @include(config('laravel-menu.views.bootstrap-items'), ['items' => $MyNavBar->roots()])       
            </ul>
        </nav>
        <div class="pt-5 pb-2"></div>
    </div>
</div>
