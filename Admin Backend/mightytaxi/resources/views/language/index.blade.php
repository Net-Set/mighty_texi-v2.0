{{ Form::model($flatArray,['method' => 'POST', 'route'=> 'saveLangContent', 'data-toggle' => 'validator'] ) }}
    <input type="hidden" value="{{ $filename }}" name="filename"/>
    <input type="hidden" value="{{ $requestLang }}" name="requestLang"/>
    <table class="table language_table table-sm table-fixed">
        <thead>
            <tr>
                <th scope="col">{{ __('message.key') }}</th>
                <th scope="col">{{ __('message.value') }}</th>
            </tr>
        </thead>
        <tbody>
            @foreach($flatArray as $key => $val)
               <tr>
                   <td>{{ $val }} <small>({{ $key }})</small></td>
                   <td><input class="form-control" name="{{ $key }}" value="{{ $val }}" /></td>
               </tr>
            @endforeach
        </tbody>
    </table>
{{ Form::submit( __('message.save'), ['class' => 'btn btn-md btn-primary float-right']) }}
{{ Form::close() }}
