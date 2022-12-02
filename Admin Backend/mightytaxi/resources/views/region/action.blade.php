
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['region.destroy', $id], 'method' => 'delete','data--submit'=>'region'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('region edit'))
    <a class="mr-2" href="{{ route('region.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.region') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif

    @if($auth_user->can('region delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="region{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.region') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.region') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}