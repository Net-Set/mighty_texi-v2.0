@foreach($items as $item)
    <?php
    if ($item->hasChildren()){
        if ($item->children()->where('isActive',true)->first() !== null){
            $active = 'active';
        }else{
            $active = '';
        }
    }else{
        $active = '';
    }
    ?>
    <li @lm_attrs($item) @if($item->hasChildren()) @endif @lm_endattrs>
        @if($item->link) <a @lm_attrs($item->link)
            @if($item->hasChildren()) data-toggle="collapse" role="button" aria-expanded="{{ $active != '' ? 'true' : 'false' }}" aria-controls="collapseExample" @else class="nav-link" @endif @lm_endattrs href="{!! $item->url() !!}">
            {!! $item->title !!}
            @if($item->hasChildren())
                <i class="fas fa-angle-right mm-arrow-right arrow-active"></i>
                <i class="fas fa-angle-down mm-arrow-right arrow-hover"></i>
            @endif
        </a>
        @else
            <span class="navbar-text">{!! $item->title !!}</span>
        @endif
        @if($item->hasChildren())
            <ul class="submenu collapse  {{ $active != '' ? 'show' : '' }}" id="{!! str_replace('#','',$item->url()) !!}">
                @include(config('laravel-menu.views.bootstrap-items'),array('items' => $item->children()))
            </ul>
        @endif
    </li>
    @if($item->divider)
        <li{!! Lavary\Menu\Builder::attributes($item->divider) !!}></li>
    @endif
@endforeach
