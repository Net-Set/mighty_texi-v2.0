
<?php
    $auth_user= authSession();
?>
{{ Form::open(['route' => ['fleet.destroy', $id], 'method' => 'delete','data--submit'=>'fleet'.$id]) }}
<div class="d-flex justify-content-end align-items-center">
    @if($auth_user->can('fleet edit'))
    <a class="mr-2" href="{{ route('fleet.edit', $id) }}" title="{{ __('message.update_form_title',['form' => __('message.fleet') ]) }}"><i class="fas fa-edit text-primary"></i></a>
    @endif
    
    {{-- <a class="mr-2" href="{{ route('fleet.show',$id) }}"><i class="fas fa-eye text-secondary"></i></a> --}}

    @if($auth_user->can('fleet delete'))
    <a class="mr-2 text-danger" href="javascript:void(0)" data--submit="fleet{{$id}}" 
        data--confirmation='true' data-title="{{ __('message.delete_form_title',['form'=> __('message.fleet') ]) }}"
        title="{{ __('message.delete_form_title',['form'=>  __('message.fleet') ]) }}"
        data-message='{{ __("message.delete_msg") }}'>
        <i class="fas fa-trash-alt"></i>
    </a>
    @endif
</div>
{{ Form::close() }}