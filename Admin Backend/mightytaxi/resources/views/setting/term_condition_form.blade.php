<x-master-layout>
<div class="container-fluid">
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
        <div class="col-lg-12">
            <div class="card">
                <div class="card-body">
                    {{ Form::model($setting_data,['method' => 'POST','route'=>'term-condition-save', 'data-toggle'=>"validator" ] ) }}
                        {{ Form::hidden('id') }}
                        <div class="row">
                            <div class="form-group col-md-12">
                                {{ Form::label('terms_condition',__('message.terms_condition'), ['class' => 'form-control-label']) }}
                                {{ Form::textarea('value', null, ['class'=> 'form-control tinymce-terms_condition' , 'placeholder'=> __('message.terms_condition') ]) }}
                            </div>
                        </div>
                        {{ Form::submit( __('message.save'), ['class'=>'btn btn-md btn-primary float-right']) }}
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>
</div>
@section('bottom_script')
    <script>
        (function($) {
            $(document).ready(function(){
                tinymceEditor('.tinymce-terms_condition',' ',function (ed) {

                }, 450)
            
            });

        })(jQuery);
    </script>
@endsection
</x-master-layout>