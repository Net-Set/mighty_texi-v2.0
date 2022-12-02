<x-master-layout :assets="$assets ?? []">
    <div>
        <?php $id = $id ?? null;?>
        @if(isset($id))
            {!! Form::model($data, ['route' => ['coupon.update', $id], 'method' => 'patch' ]) !!}
        @else
            {!! Form::open(['route' => ['coupon.store'], 'method' => 'post' ]) !!}
        @endif
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between">
                        <div class="header-title">
                            <h4 class="card-title">{{ $pageTitle }}</h4>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="new-user-info">
                            <div class="row">
                                <div class="form-group col-md-4">
                                    {{ Form::label('code',__('message.code').' <span class="text-danger">*</span>',[ 'class' => 'form-control-label' ], false ) }}
                                    @if(!isset($id))
                                        {{ Form::text('code', old('code'),[ 'placeholder' => __('message.code'),'class' => 'form-control', 'required' ]) }}
                                    @else
                                    <p>{{ $data->code }}</p>
                                    @endif
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('title', __('message.title').' <span class="text-danger">*</span>',['class' => 'form-control-label'], false ) }}
                                    {{ Form::text('title', old('title'),[ 'placeholder' => __('message.title'),'class' =>'form-control','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('coupon_type',__('message.coupon_type').' <span class="text-danger">*</span>',[ 'class' => 'form-control-label'],false) }}
                                    {{ Form::select('coupon_type', [ 'all' => __('message.all'), 'first_ride' => __('message.first_ride'), 'region_wise' => __('message.region_wise'), 'service_wise' => __('message.service_wise') ],  old('coupon_type'),[
                                        'class' =>'form-control select2js', 'required']) 
                                    }}
                                </div>

                                <!-- Region List Multiple -->
                                <div class="form-group col-md-4 region_list">
                                    {{ Form::label('region_ids', __('message.select_name',[ 'select' => __('message.region') ]),[ 'class' => 'form-control-label' ]) }}
                                    <br />
                                    
                                    {{ Form::select('region_ids[]', $selected_region, old('region_ids'), [
                                            'class' => 'select2js form-group region',
                                            'multiple' => 'multiple',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.region') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'region']),
                                        ])
                                    }}
                                </div>

                                <!-- Service List -->
                                <div class="form-group col-md-4 service_list">
                                    {{ Form::label('service_ids', __('message.select_name',[ 'select' => __('message.service') ]),[ 'class' => 'form-control-label' ]) }}
                                    <br />
                                    
                                    {{ Form::select('service_ids[]', $selected_service, old('service_ids'), [
                                            'class' => 'select2js form-group service',
                                            'multiple' => 'multiple',
                                            'data-placeholder' => __('message.select_name',[ 'select' => __('message.service') ]),
                                            'data-ajax--url' => route('ajax-list', ['type' => 'service']),
                                        ])
                                    }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('usage_limit_per_rider', __('message.usage_limit_per_rider'), ['class' => 'form-control-label'] ) }}
                                    {{ Form::number('usage_limit_per_rider', old('usage_limit_per_rider'), [ 'class' => 'form-control', 'min' => 0, 'placeholder' => __('message.usage_limit_per_rider') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('start_date', __('message.start_date'), [ 'class' => 'form-control-label']) }}
                                    {{ Form::text('start_date', old('start_date'),[ 'placeholder' => __('message.start_date'),'class' => 'form-control min-daterange-picker']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('end_date', __('message.end_date'), [ 'class' => 'form-control-label']) }}
                                    {{ Form::text('end_date', old('end_date'),[ 'placeholder' => __('message.end_date'),'class' => 'form-control min-daterange-picker']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('discount_type',__('message.discount_type'), ['class' => 'form-control-label']) }}
                                    {{ Form::select('discount_type',[ 'fixed' => __('message.fixed') ,'percentage' => __('message.percentage') ], old('discount_type') ,[ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('discount', __('message.discount').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('discount', old('discount'), ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.discount') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('minimum_amount', __('message.minimum_amount').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('minimum_amount', old('minimum_amount'), ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.minimum_amount') ]) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('maximum_discount', __('message.maximum_discount').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
                                    {{ Form::number('maximum_discount', old('maximum_discount'), ['class' => 'form-control', 'min' => 0, 'step' => 'any', 'required', 'placeholder' => __('message.maximum_discount') ]) }}
                                </div>
                                
                                <div class="form-group col-md-4">
                                    {{ Form::label('status',__('message.status').' <span class="text-danger">*</span>',['class'=>'form-control-label'],false) }}
                                    {{ Form::select('status',[ '1' => __('message.active'), '0' => __('message.inactive') ], old('status'), [ 'class' =>'form-control select2js','required']) }}
                                </div>

                                <div class="form-group col-md-4">
                                    {{ Form::label('description', __('message.description'), ['class'=>'form-control-label'] ) }}
                                    {{ Form::textarea('description', null, ['class' => 'form-control textarea', 'rows' => 3, 'placeholder'=> __('message.description') ]) }}
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
    @section('bottom_script')
        <script>
            $(document).ready(function() {
                selected_coupon_type = $('#coupon_type :selected').val();
                changeCouponType(selected_coupon_type);
                $('#coupon_type').on('select2:select', function (e) {
                    var coupon_type = $(this).val();
                    changeCouponType(coupon_type);
                });
            });

            function changeCouponType(type='all') {

                switch(type) {
                    case 'region_wise':
                        $(document).find('.region_list').removeClass('d-none');
                        $(document).find('.service_list').addClass('d-none');
                        $(document).find('#usage_limit_per_rider').removeAttr('readonly');
                        break;
                    case 'service_wise':
                        $(document).find('.service_list').removeClass('d-none');
                        $(document).find('.region_list').addClass('d-none');
                        $(document).find('#usage_limit_per_rider').removeAttr('readonly');
                        break;
                    case 'first_ride':
                        $(document).find('.service_list').addClass('d-none');
                        $(document).find('.region_list').addClass('d-none');
                        $(document).find('#usage_limit_per_rider').val(1);
                        $(document).find('#usage_limit_per_rider').attr('readonly','true');
                        break;
                    default:
                        $(document).find('#usage_limit_per_rider').removeAttr('readonly')
                        $(document).find('.service_list').addClass('d-none');
                        $(document).find('.region_list').addClass('d-none');
                }
            }
        </script>
    @endsection
</x-master-layout>
