<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['document.destroy', $id], 'method' => 'delete','data--submit'=>'document'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('document edit'))
    <a class="mr-2" href="{{ route('document.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.document') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif

    @if($auth_user->can('document delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="document{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.document') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.document') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}