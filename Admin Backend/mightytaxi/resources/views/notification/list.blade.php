<div class="p-3 card-header-border">
    <h6 class="text-center">
        {{ __('message.notification') }}   <small class="badge badge-light float-right pt-1 notification_count notification_tag"> {{ $all_unread_count }}</small>
    </h6>
</div>
<div class="px-2 py-2">
    <h6 class="text-sm text-muted m-0"><span class="notification_count">{{  __('message.you_have_unread_notification',['number' => $all_unread_count ]) }}</span>
        @if($all_unread_count > 0 )
            <a href="#" data-type="markas_read" class="notifyList float-right" ><span>{{ __('message.mark_all_as_read') }}</span></a>
        @endif
    </h6>
</div>

@if(isset($notifications) && count($notifications) > 0)
    <div class="notification-height">
        @foreach($notifications->sortByDesc('created_at')->take(5) as  $notification)
            <a href="{{ route('riderequest.show', $notification->data['id'] ) }}" class="sub-card {{ $notification->read_at ? '':'notify-list-bg'}}">
                <div class="media align-items-center">
                    <div class="media-body ml-3">
                        <h6 class="mb-0">#{{ $notification->data['id'] }} {{ __('message.'.$notification->data['type'])  }}</h6>
                        <small class="float-right font-size-12">{{ timeAgoFormate($notification->created_at)  }}</small>
                        <p class="mb-0">{{ isset($notification->data['message']) ? $notification->data['message'] : __('message.booked') }}</p>
                    </div>
                </div>
            </a>
        @endforeach
    </div>
    <a href="{{ route('notification.index') }}" class="dropdown-item text-center text-primary font-weight-bold py-3">{{ __('message.view_all') }}</a>
@else
    <a href="#" class="sub-card">
        <div class="media align-items-center">
            <div class="media-body ml-3">
                <h6 class="mb-0">{{ __('message.no_notification') }}</h6>
                <small class="float-right font-size-12"></small>
                <p class="mb-0"></p>
            </div>
        </div>
    </a>
@endif