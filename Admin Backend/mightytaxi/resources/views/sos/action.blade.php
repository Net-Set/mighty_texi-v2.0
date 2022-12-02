<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['sos.destroy', $id], 'method' => 'delete','data--submit'=>'sos'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('sos edit'))
    <a class="mr-2" href="{{ route('sos.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.sos') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif

    @if($auth_user->can('sos delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="sos{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.sos') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.sos') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}