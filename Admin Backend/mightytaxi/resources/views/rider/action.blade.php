
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['rider.destroy', $id], 'method' => 'delete','data--submit'=>'rider'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('rider edit'))
    <a class="mr-2" href="{{ route('rider.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.rider') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif
    
    {{-- <a class="mr-2" href="{{ route('rider.show',$id) }}"><i class="fas fa-eye text-secondary"></i></a> --}}

    @if($auth_user->can('rider delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="rider{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.rider') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.rider') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}