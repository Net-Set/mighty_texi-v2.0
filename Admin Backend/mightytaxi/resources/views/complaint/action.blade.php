
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['complaint.destroy', $id], 'method' => 'delete','data--submit'=>'complaint'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('complaint edit') &&  $complaint->status != 'resolved')       
        <a class="mr-2" href="{{ route('complaint.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.complaint') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif

    @if($auth_user->can('complaint delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="complaint{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.complaint') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.complaint') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}