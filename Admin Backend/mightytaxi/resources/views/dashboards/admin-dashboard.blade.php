<x-master-layout>
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 mb-3">
                <div class="d-flex align-items-center justify-content-between welcome-content">
                    <div class="navbar-breadcrumb">
                        <!-- <h4 class="mb-0 font-weight-700">Welcome To Dashboard</h4> -->
                    </div>
                    <div class="">
                        
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <circle cx="9" cy="7" r="4" />
                                            <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
                                            <path d="M21 21v-2a4 4 0 0 0 -3 -3.85" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ $data['dashboard']['total_driver'] }}</h5>
                                        <p class="mb-0">{{ __('message.total_driver') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <circle cx="9" cy="7" r="4" />
                                            <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                                            <line x1="19" y1="7" x2="19" y2="10" />
                                            <line x1="19" y1="14" x2="19" y2="14.01" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ $data['dashboard']['pending_driver'] }}</h5>
                                        <p class="mb-0">{{ __('message.pending_driver') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <circle cx="5" cy="18" r="3" />
                                            <circle cx="19" cy="18" r="3" />
                                            <polyline points="12 19 12 15 9 12 14 8 16 11 19 11" />
                                            <circle cx="17" cy="5" r="1" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ $data['dashboard']['total_rider'] }}</h5>
                                        <p class="mb-0s">{{ __('message.total_rider') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <circle cx="7" cy="17" r="2" />
                                            <circle cx="17" cy="17" r="2" />
                                            <path d="M5 17h-2v-6l2 -5h9l4 5h1a2 2 0 0 1 2 2v4h-2m-4 0h-6m-6 -6h15m-6 0v-5" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ $data['dashboard']['total_ride'] }}</h5>
                                        <p class="mb-0">{{ __('message.total_ride') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <path d="M17 8v-3a1 1 0 0 0 -1 -1h-10a2 2 0 0 0 0 4h12a1 1 0 0 1 1 1v3m0 4v3a1 1 0 0 1 -1 1h-12a2 2 0 0 1 -2 -2v-12" />
                                            <path d="M20 12v4h-4a2 2 0 0 1 0 -4h4" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ getPriceFormat($data['dashboard']['today_earning']) }}</h5>
                                        <p class="mb-0">{{ __('message.today_earning') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <path d="M17 8v-3a1 1 0 0 0 -1 -1h-10a2 2 0 0 0 0 4h12a1 1 0 0 1 1 1v3m0 4v3a1 1 0 0 1 -1 1h-12a2 2 0 0 1 -2 -2v-12" />
                                            <path d="M20 12v4h-4a2 2 0 0 1 0 -4h4" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ getPriceFormat($data['dashboard']['monthly_earning']) }}</h5>
                                        <p class="mb-0">{{ __('message.monthly_earning') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                            <path d="M17 8v-3a1 1 0 0 0 -1 -1h-10a2 2 0 0 0 0 4h12a1 1 0 0 1 1 1v3m0 4v3a1 1 0 0 1 -1 1h-12a2 2 0 0 1 -2 -2v-12" />
                                            <path d="M20 12v4h-4a2 2 0 0 1 0 -4h4" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ getPriceFormat($data['dashboard']['total_earning']) }}</h5>
                                        <p class="mb-0">{{ __('message.total_earning') }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card card-block card-stretch card-height">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="mm-cart-image text-primary">
                                        <svg class="svg-icon svg-danger" width="50" height="52" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                                            <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
                                            <line x1="9" y1="9" x2="10" y2="9" />
                                            <line x1="9" y1="13" x2="15" y2="13" />
                                            <line x1="9" y1="17" x2="15" y2="17" />
                                        </svg>
                                    </div>
                                    <div class="mm-cart-text">
                                        <h5 class="font-weight-700">{{ $data['dashboard']['complaint'] }}</h5>
                                        <p class="mb-0">{{ __('message.complaint') }}</p>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card card-block card-stretch card-height">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ __('message.recent_request') }}</h4>
                        </div>
                        <div class="card-header-toolbar d-flex align-items-center">
                        </div>
                    </div>
                    <div class="card-body align-items-center">
                        <div class="table-responsive">
                            <table class="table mb-1 table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th scope='col'>#</th>
                                        <th scope='col'>{{ __('message.rider') }}</th>
                                        <th scope='col'>{{ __('message.requested_date') }}</th>
                                        <th scope='col'>{{ __('message.driver') }}</th>
                                        <th scope='col'>{{ __('message.status') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @if( count($recent_riderequest) > 0 )
                                        @foreach ($recent_riderequest as $riderequest)
                                            @php
                                                $status = 'primary';
                                                $ride_status = $riderequest->status;
                                                switch ($ride_status) {
                                                    case 'pending':
                                                        $status = 'warning';
                                                        break;
                                                    case 'canceled':
                                                        $status = 'danger';
                                                        break;
                                                    case 'completed':
                                                        $status = 'success';
                                                        break;
                                                    default:
                                                        // $ride_status = '-';
                                                        break;
                                                }
                                                @endphp
                                            <tr>
                                                <td>{{ $riderequest->id }}</td>
                                                <td>{{ optional($riderequest->rider)->display_name ?? '-' }}</td>
                                                <td>{{ dateAgoFormate($riderequest->datetime, true) }}</td>
                                                <td>{{ optional($riderequest->driver)->display_name ?? '-' }}</td>
                                                <td><span class="badge bg-{{$status}}">{{ __('message.'.$riderequest->status) }}</span></td>
                                            </tr>
                                        @endforeach
                                    @else
                                        <tr>
                                            <td colspan="5">{{ __('message.no_record_found') }}</td>
                                        </tr>
                                    @endif
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card card-block card-stretch card-height">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ __('message.income') }}</h4>
                        </div>
                        <div class="card-header-toolbar d-flex align-items-center">
                        </div>
                    </div>
                    <div class="card-body align-items-center">
                        <div id="dash-income-chart"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Page end  -->
    </div>
    @section('bottom_script')
    <script>
        
        var options = {
            series: [{
                name: "{{ __('message.cash') }}",
                data: [ <?= implode ( ',' , $data['cash_yearly'] ) ?> ]
            }, {
                name: "{{ __('message.wallet') }}",
                data:[ <?= implode ( ',' , $data['wallet_yearly'] ) ?> ]
            }],
            chart: {
                type: 'bar',
                height: 350
            },
            plotOptions: {
                bar: {
                    horizontal: false,
                    columnWidth: '55%',
                    endingShape: 'rounded'
                },
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                show: true,
                width: 2,
                colors: ['transparent']
            },
            xaxis: {
                categories: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
            },
            yaxis: {
                title: {
                    text: ''
                }
            },
            fill: {
                opacity: 1
            },
            tooltip: {
                y: {
                    formatter: function (val) {
                        return val
                    }
                }
            }
        };

        var chart = new ApexCharts(document.querySelector("#dash-income-chart"), options);
        chart.render();
    </script>
    @endsection
</x-master-layout>
