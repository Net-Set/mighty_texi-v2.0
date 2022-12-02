<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['additionalfees.destroy', $id], 'method' => 'delete','data--submit'=>'additionalfees'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('additionalfees edit'))
    <a class="mr-2" href="{{ route('additionalfees.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.additionalfees') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif
    
    @if($auth_user->can('additionalfees delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="additionalfees{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.additionalfees') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.additionalfees') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}