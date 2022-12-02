{{ Form::open(['method' => 'POST','route' => ['walletSettingsUpdate'],'data-toggle'=>'validator']) }}
{{ Form::hidden('page', $page, ['class' => 'form-control'] ) }}
    
    <div class="col-md-12 mt-20">
        <div class="row">
            @foreach($wallet_setting as $key => $value)
                <div class="col-md-6 form-group">
                    @if($key == 'preset_topup_amount' )
                        {{ Form::label($key,__('message.'.$key).' <span data-toggle="tooltip" data-placement="right" title="'.__('message.preset_topup_amount_info').'"><i class="las la-question-circle"></i></span>',['class'=>'form-control-label'],false ) }}
                        {{ Form::text($key,$value ?? null,[ 'placeholder' => '10|50|100|500', 'class' => 'form-control' ]) }}
                    @else
                        {{ Form::label($key,__('message.'.$key),['class'=>'form-control-label'] ) }}
                        @if($key == 'min_amount_to_get_ride')
                            {{ Form::number($key,$value ?? null,[ 'placeholder' => __('message.'.$key), 'step' => 'any', 'class' => 'form-control' ]) }}
                        @else
                            {{ Form::number($key,$value ?? null,[ 'placeholder' => __('message.'.$key), 'min' => 0, 'step' => 'any', 'class' => 'form-control' ]) }}
                        @endif
                    @endif
                </div>
            @endforeach
        </div>
    </div>
{{ Form::submit(__('message.save'), ['class'=>"btn btn-md btn-primary float-md-right"]) }}
{{ Form::close() }}
