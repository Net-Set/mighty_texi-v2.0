
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['coupon.destroy', $id], 'method' => 'delete','data--submit'=>'coupon'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('coupon edit'))
    <a class="mr-2" href="{{ route('coupon.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.coupon') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif
    
    @if($auth_user->can('coupon delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="coupon{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.coupon') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.coupon') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}