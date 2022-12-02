<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['driverdocument.destroy', $id], 'method' => 'delete','data--submit'=>'driverdocument'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('driverdocument edit'))
    <a class="mr-2" href="{{ route('driverdocument.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.driver_document') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif

    @if($auth_user->can('driverdocument delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="driverdocument{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.driver_document') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.driver_document') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}