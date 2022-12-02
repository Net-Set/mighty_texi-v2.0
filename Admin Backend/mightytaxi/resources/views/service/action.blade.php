
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['service.destroy', $id], 'method' => 'delete','data--submit'=>'service'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('service edit'))
    <a class="mr-2" href="{{ route('service.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.service') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif
    
    @if($auth_user->can('service delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="service{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.service') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.service') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}