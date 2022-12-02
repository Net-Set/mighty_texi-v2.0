<?php
    $auth_user= authSession();
?>
<div class="align-items-center">
    
    @if($query->status == 0 && $auth_user->hasAnyRole(['admin']) )
        <a href="{{ route('withdraw.request.status', [ 'id' => $query->id, 'status' => 1 ]) }}"
            data--confirmation='true' data-title="{{ __('message.withdrawrequest') }}"
            data--ajax='true'
            title="{{  __('message.approved') }}"
            data-message="{{  __('message.confirm_action_message', [ 'name' => __('message.approved') ]) }}"
            data-datatable="reload">
            <span class="badge badge-success mr-1"><i class="fas fa-check"></i> </span>
        </a>

        <a href="{{ route('withdraw.request.status', [ 'id' => $query->id, 'status' => 2 ]) }}"
            data--confirmation='true' data-title="{{ __('message.withdrawrequest') }}"
            data--ajax='true'
            title="{{ __('message.decline') }}"
            data-message="{{  __('message.confirm_action_message', [ 'name' => __('message.decline') ]) }}"
            data-datatable="reload">
            <span class="badge badge-danger mr-1"> <i class="fas fa-ban"></i></span>
        </a>
    @else
        -
    @endif

    {{--
        {{ Form::open(['route' => ['withdrawrequest.destroy', $query->id], 'method' => 'delete','data--submit'=>'withdrawrequest'.$query->id]) }}
            <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="withdrawrequest{{$query->id}}" 
                data--submit="confirm_form"
                data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.withdrawrequest') ]) }}"
                title="{{ __('message.delete_form_title',['form'=>  __('message.withdrawrequest') ]) }}"
                data-message='{{ __("message.delete_msg") }}'>
                <i class="fas fa-trash-alt"></i>
            </a>
        {{ Form::close() }}
    --}}
</div>