<x-master-layout :assets="$assets ?? []">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-8">
                <div class="card card-block">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title mb-0">{{ __('message.riderequest') }}</h4>
                        </div>
                        <h4 class="float-right">#{{ $data->id }}</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-6">
                                <h4>{{ __('message.pickup_address') }}</h4>
                                <p>{{ $data->start_address }}</p>
                            </div>
                            <div class="col-6">
                                <h4>{{ __('message.drop_address') }}</h4>
                                <p>{{ $data->end_address }}</p>
                            </div>
                        </div>
                        @if(optional($data)->payment != null && optional($data)->payment->payment_status == 'paid')
                            <hr>
                            <div class="row">
                                <div class="col-4">
                                    <p>{{ __('message.total_distance') }}</p>
                                    {{ $data->distance }} {{ $data->distance_unit }}
                                </div>
                                <div class="col-4">
                                    <p>{{ __('message.total_duration') }}</p>
                                    {{ $data->duration }} {{ __('message.min') }}
                                </div>                                
                            </div>
                        @endif
                    </div>
                </div>
                <div class="card card-block">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title mb-0">{{ __('message.payment') }}</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        @if(optional($data)->payment != null && optional($data)->payment->payment_status == 'paid')
                            @php
                            $distance_unit = $data->distance_unit;
                            @endphp
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.base_fare') }}</span>
                                    <span>{{ __('message.for_first') }} {{ $data->base_distance }} {{ __('message.'.$distance_unit) }}</span>
                                    <span class="">{{ getPriceFormat($data->base_fare) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.distance') }}</span>
                                    @if($data->distance > $data->base_distance)
                                        <span>{{ $data->distance - $data->base_distance }} {{ $distance_unit }} x {{ $data->per_distance }}/{{ __('message.'.$distance_unit) }}</span>
                                    @else
                                        <span>{{ $data->distance }} {{ $distance_unit }} x {{ $data->per_distance }}/{{ __('message.'.$distance_unit) }}</span>
                                    @endif
                                    <span class="">{{ getPriceFormat($data->per_distance_charge) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.duration') }}</span>
                                    <span>{{ $data->duration }} {{ __('message.min') }} x {{ $data->per_minute_drive }}/{{ __('message.min') }}</span>
                                    <span class="">{{ getPriceFormat($data->per_minute_drive_charge) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.wait_time') }}</span>
                                    @if($data->waiting_time == 0)
                                        <span></span>
                                    @else
                                        <span>{{ $data->waiting_time }} {{ __('message.min') }} x {{ $data->per_minute_waiting }}/{{ __('message.min') }}</span>
                                    @endif
                                    <span class="">{{ getPriceFormat($data->per_minute_waiting_charge) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.extra_charges') }}</span>
                                    @if(count($data->extra_charges) > 0)
                                        @php
                                            $extra_charges = collect($data->extra_charges)->pluck('key')->implode(', ');
                                        @endphp
                                        <span>{{ $extra_charges }}</span>
                                    @else
                                        <span></span>
                                    @endif
                                    <span class="">{{ getPriceFormat($data->extra_charges_amount) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.tip') }}</span>
                                    <span></span>
                                    <span class="">{{ getPriceFormat($data->tips) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.coupon_discount') }}</span>
                                    <span></span>
                                    <span class="">{{ getPriceFormat($data->coupon_discount) }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.amount') }}</span>
                                    @php
                                        $total_amount = ( $data->tips ?? 0 ) + optional($data->payment)->total_amount;
                                    @endphp
                                    <span class="font-weight-bold">{{ getPriceFormat($total_amount) }}</span>
                                </li>
                            </ul>
                        @else
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.payment_method') }}</span>
                                    <span class="font-weight-bold">{{ $data->payment_type ?? '-' }}</span>
                                </li>
                                <li class="list-group-item d-flex flex-xl-row flex-column justify-content-between align-items-center align-items-xl-start px-0"> 
                                    <span>{{ __('message.amount') }}</span>
                                    <span class="font-weight-bold">{{ optional($data->payment)->total_amount == null ? '-' : getPriceFormat(optional($data->payment)->total_amount) }}</span>
                                </li>
                            </ul>
                        @endif
                    </div>
                </div>
                @if(count($data->rideRequestHistory) > 0)
                    <div class="card card-block">
                        <div class="card-header d-flex justify-content-between">
                            <div class="header-title">
                                <h4 class="card-title mb-0">{{ __('message.activity_timeline') }}</h4>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="mm-timeline0 m-0 d-flex align-items-center justify-content-between position-relative">
                                <ul class="list-inline p-0 m-0">
    
                                    @foreach($data->rideRequestHistory as $history)
                                        <li>
                                            <div class="timeline-dots1 border-primary text-primary">
                                                <!-- <i class="ri-login-circle-line"></i> -->
                                            </div>
                                            <h6 class="float-left mb-1">{{ __('message.'.$history->history_type) }}</h6>
                                            <small class="float-right mt-1">{{ $history->datetime }}</small>
                                            <div class="d-inline-block w-100">
                                                <p>{{ $history->history_message }}</p>
                                            </div>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                    </div>
                @endif
            </div>
            <div class="col-lg-4">
                <div class="card card-block">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title mb-0">{{ __('message.detail_form_title', [ 'form' => __('message.rider') ]) }}</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3">
                                <img src="{{ getSingleMedia(optional($data->rider), 'profile_image',null) }}" alt="rider-profile" class="img-fluid avatar-60 rounded-small">
                            </div>
                            <div class="col-9">
                                <p class="mb-0">{{ optional($data->rider)->display_name }}</p>
                                <p class="mb-0">{{ optional($data->rider)->contact_number }}</p>
                                <p class="mb-0">{{ optional($data->rider)->email }}</p>
                                <p class="mb-0">{{ optional($data->rideRequestRiderRating())->rating }}
                                    @if( optional($data->rideRequestRiderRating())->rating > 0 )
                                        <i class="fa fa-star" style="color: yellow"></i>
                                    @endif
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                @if( isset($data->driver) )
                <div class="card card-block">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title mb-0">{{ __('message.detail_form_title', [ 'form' => __('message.driver') ]) }}</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3">
                                <img src="{{ getSingleMedia(optional($data->driver), 'profile_image',null) }}" alt="driver-profile" class="img-fluid avatar-60 rounded-small">
                            </div>
                            <div class="col-9">
                                <p class="mb-0">{{ optional($data->driver)->display_name }}</p>
                                <p class="mb-0">{{ optional($data->driver)->contact_number }}</p>
                                <p class="mb-0">{{ optional($data->driver)->email }}</p>
                                <p class="mb-0">{{ optional($data->rideRequestDriverRating())->rating }}
                                    @if( optional($data->rideRequestDriverRating())->rating > 0 )
                                        <i class="fa fa-star" style="color: yellow"></i>
                                    @endif
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                @endif
                <div class="card card-block">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title mb-0">{{ __('message.detail_form_title', [ 'form' => __('message.service') ]) }}</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3">
                                <img src="{{ getSingleMedia($data->service, 'service_image',null) }}" alt="service-detail" class="img-fluid avatar-60 rounded-small">
                            </div>
                            <div class="col-9">
                                <p class="mb-0">{{ optional($data->service)->name }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-master-layout>