<!-- Fixed Side Menu -->
<div class="dashboard3-fixed-menu">
    <div class="dashboard3-info bg-primary p-2 rounded">
        <a href="#payment" class="collapsed" data-toggle="collapse" aria-expanded="false">
            <i class="ri-list-check"></i>
        </a>
        <ul id="payment" class="submenu collapse show list-inline m-0 p-0 mt-2">
            
            
            <li>
                <a href="{{route('auth.login)}} " data-toggle="tooltip" data-placement="right" title="Sign in"><i
                        class="las la-sign-in-alt"></i></a>
            </li>
            <li>
                <a href="{{route('auth.register')}}" data-toggle="tooltip" data-placement="right" title="Sign Up"><i
                        class="las la-sign-out-alt"></i></a>
            </li>
        </ul>
    </div>
</div>
<!-- Fixed Side Menu End -->
