<script>
(function($) {
    'use strict';
    
    $(document).ready(function(){
        $('.select2js').select2();
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        function errorMessage(message) {
            Snackbar.show({
                text: message,
                pos: 'bottom-center',
                backgroundColor: '#dc3545',
                actionTextColor: 'white'
            });
        }

        function showMessage(message) {
            Snackbar.show({
                text: message,
                pos: 'bottom-center'
            });
        }

        if($('.min-daterange-picker').length > 0){
            flatpickr('.min-daterange-picker', {
                minDate: 'today',
                plugins: [new rangePlugin({ input: '#end_date' })],
            });
        }
        
        if($('.min-datepicker').length > 0){
            flatpickr('.min-datepicker', {
                minDate: 'today',
            });
        }
        
        $(document).on('click', '.loadRemoteModel', function(e) {
            e.preventDefault();
            var url = $(this).attr('href');

            if (url.indexOf('#') == 0) {
                $(url).modal('open');
            } else {
                $.get(url, function(data) {
                    $('#remoteModelData').html(data);
                    $('#remoteModelData').modal();
                    $('form').validator();
                    $(".datepicker").flatpickr({
                        dateFormat: "d-m-Y"
                    });
                });
            }
        });

        $(document).on('click', '[data-form="ajax"]', function(f) {
            $('form').validator('update');
            f.preventDefault();
            var current = $(this);
            current.addClass('disabled');
            var form = $(this).closest('form');
            var url = form.attr('action');
            var fd = new FormData(form[0]);

            $.ajax({
                type: "POST",
                url: url,
                data: fd, // serializes form's elements.
                success: function(e) {
                    if (e.status == true) {
                        if (e.event == "submited") {
                            showMessage(e.message);
                            $(".modal").modal('hide');
                        }
                        if(e.event == 'refresh'){
                            window.location.reload();
                        }
                        if(e.event == "callback"){
                            showMessage(e.message);
                            $(".modal").modal('hide');
                            location.reload();
                        }
                    }
                    if (e.status == false) {
                        if (e.event == 'validation') {
                            errorMessage(e.message);
                        }
                    }
                },
                error: function(error) {

                },
                cache: false,
                contentType: false,
                processData: false,
            });
            f.preventDefault(); // avoid to execute the actual submit of the form.

        });

        $(document).on('change','.change_status', function() {

            var status = $(this).prop('checked') == true ? 1 : 0;
            
            var key_name = $(this).attr('data-name');
            var id = $(this).attr('data-id');
            var type = $(this).attr('data-type');
            $.ajax({
                type: "GET",
                dataType: "json",
                url: "{{ route('changeStatus') }}",
                data: { 'status': status, 'id': id ,'type': type ,[key_name]: key_name },
                success: function(data){
                    if(data.status == false){
                        errorMessage(data.message)
                    }else{
                        showMessage(data.message);
                    }
                }
            });
        })
        $(document).on('click', '[data-toggle="tabajax"]', function(e) {
            e.preventDefault();
            var selectDiv = this;
            ajaxMethodCall(selectDiv);
        });
        
        function ajaxMethodCall(selectDiv) {

            var $this = $(selectDiv),
                loadurl = $this.attr('data-href'),
                targ = $this.attr('data-target'),
                id = selectDiv.id || '';

            $.post(loadurl, function(data) {
                $(targ).html(data);
                $('form').append('<input type="hidden" name="active_tab" value="'+id+'" />');
            });

            $this.tab('show');
            return false;
        }

        $('form[data-toggle="validator"]').on('submit', function (e) {
            window.setTimeout(function () {
                var errors = $('.has-error')
                if (errors.length) {
                    $('html, body').animate({ scrollTop: "0" }, 500);
                    e.preventDefault()
                }
            }, 0);
        });   
        
        $(document).on('click','[data--confirmation="true"]',function(e){
            e.preventDefault();
            var form = $(this).attr('data--submit');

            var title = $(this).attr('data-title');

            var message = $(this).attr('data-message');

            var ajaxtype = $(this).attr('data--ajax');
            if(form == 'confirm_form') {
                $('#confirm_form').attr('action', $(this).attr('href'));
            }
            let __this = this

            confirmation(form,title,message,ajaxtype,__this);
        });

        function confirmation(form,title = "{{ __('message.confirmation') }}",message = "{{ __('message.delete_msg') }}",ajaxtype=false,_this){
            const storageDark = localStorage.getItem('dark');
            const theme = (storageDark == "false") ? 'material' : 'dark';
            $.confirm({
            content: message,
            type: '',
            title: title,
            buttons: {
                yes: {
                    action: function () {
                        
                        if(ajaxtype == 'true') {
                            let url = _this;

                            let data = $('[data--submit="'+form+'"]').serializeArray();
                            $.post(url, data).then(response => {
                                if(response.status) {

                                    if(response.image != null){
                                        $(_this).remove();
                                        $('#'+response.preview).attr('src',response.image)
                                        if (jQuery.inArray(response.preview, ["service_attachment_preview"]) !== -1) {
                                            $('#'+response.preview+"_"+response.id).remove()
                                            let total_file = $('.remove-file').length;
                                            if(total_file == 0){
                                                $('.service_attachment_div').remove();
                                            }
                                        }
                                        if(response.preview == 'site_logo_preview'){
                                            $('.'+response.preview).attr('src',response.image);
                                        }
                                        if(response.preview == 'site_favicon_preview'){
                                            $('.'+response.preview).attr('href',response.image);
                                        }

                                        if(response.preview == 'site_dark_logo_preview'){
                                            $('.'+response.preview).attr('src',response.image);
                                        }

                                        showMessage(response.message)
                                        return true;
                                    }
                                    $('.dataTable').DataTable().ajax.reload( null, false );
                                    showMessage(response.message)
                                }
                                if(response.status == false){
                                    errorMessage(response.message)
                                }
                            })
                        } else {
                            if (form !== undefined && form){
                                $(document).find('[data--submit="'+form+'"]').submit();
                            }else{
                                return true;
                            }
                        }
                    }
                },
                no: {
                    action: function () {}
                },
            },
            theme: theme
        });
        return false;
    }

        $('.notification_list').on('click',function(){
            notificationList();
        });

        $(document).on('click','.notifyList',function()
        {
            notificationList($(this).attr('data-type'));
        });

         $(document).on('click','.notification_data',function(event){
            event.stopPropagation();
         })

        function notificationList(type=''){
            var url = "{{ route('notification.list') }}";
            $.ajax({
                type: 'get',
                url: url,
                data: {'type':type},
                success: function(res){

                    $('.notification_data').html(res.data);
                    getNotificationCounts();
                    if(res.type == "markas_read"){
                        notificationList();
                    }
                    $('.notify_count').removeClass('notification_tag').text('');
                }
            });
        }

        function getNotificationCounts(){
            var url = "{{ route('notification.counts') }}";
            $.ajax({
                type: 'get',
                url: url,
                success: function(res){
                    if(res.counts > 0){
                        $('.notify_count').addClass('notification_tag').text(res.counts);
                        setNotification(res.counts);
                        $('.notification_list span.dots').addClass('d-none')
                        $('.notify_count').removeClass('d-none')
                    }else{
                        $('.notify_count').addClass('d-none')
                        $('.notification_list span.dots').removeClass('d-none')
                    }

                    if(res.counts <= 0 && res.unread_total_count > 0){
                        $('.notification_list span.dots').removeClass('d-none')
                    }else{
                        $('.notification_list span.dots').addClass('d-none')
                    }
                }
            });
        }

        getNotificationCounts();

        setInterval(getNotificationCounts, 600000);
        
        function setNotification(count){
            if(Number(count) >= 100){
                $('.notify_count').text('99+');
            }
        }

        $(document).on('change', '.custom-file-input', function() {
            readURL(this);
        })

        function readURL(input) {
            var target = $(input).attr('data--target');
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                var field_name = $(input).attr('name');
                var msg = "{{ __('message.image_png_gif') }}";
                var selected_file = [];

                if (jQuery.inArray(field_name, ["service_attachment[]"]) !== -1) {
                    for (var i = 0; i < $(input).get(0).files.length; ++i) {
                        var file_name = $(input).get(0).files[i].name;

                        res = isAttachments(file_name);
                        msg = $(input).attr('data-file-error');
                        if (res == false) {
                            $('.selected_file').text('');
                            errorMessage(msg);
                            $(input).val("");
                            return false;
                        }else{
                            selected_file.push(file_name);
                            $('.selected_file').text(selected_file);
                        }
                    }
                } else if(jQuery.inArray(field_name, ['driver_document']) !== -1){
                    var res = isDocuments(input.files[0].name);
                    if ($('.selected_file').length > 0) {
                        $('.selected_file').text(input.files[0].name);
                    }
                }  else {
                    var res = isImage(input.files[0].name);
                    if ($('.selected_file').length > 0) {
                        $('.selected_file').text(input.files[0].name);
                    }
                }

                if (res == false) {
                    errorMessage(msg)
                    $(input).val("");
                    return false;
                }
                reader.onload = function(e) {
                    $('.'+target).attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }

            var modal = $(input).attr('data--modal');

            if (modal !== undefined && modal !== null && modal === 'modal')
                $('.image_upload-modal').modal('hide');

        }

        function getExtension(filename) {
            var parts = filename.split('.');
            return parts[parts.length - 1];
        }

        function isImage(filename) {
            var ext = getExtension(filename);
            switch (ext.toLowerCase()) {
                case 'jpg':
                case 'jpeg':
                case 'png':
                case 'gif':
                case 'svg':
                case 'ico':
                    return true;
            }
            return false;
        }

        function isDocuments(filename) {
            var ext = getExtension(filename);
            var validExtensions = ['jpg', 'pdf', 'jpeg', 'gif', 'png'];

            if (jQuery.inArray(ext.toLowerCase(), validExtensions) !== -1) {
                return true;
            }
            return false;
        }

        function isAttachments(filename) {
            var ext = getExtension(filename);
            var validExtensions = ['jpg', 'pdf', 'jpeg', 'gif', 'png', 'mp4', 'avi'];
            
            if (jQuery.inArray(ext.toLowerCase(), validExtensions) !== -1) {
                return true;
            }
            return false;
        }

    @if(isset($assets) && in_array('phone', $assets))
        $(document).ready(function(){
            var input = document.querySelector("#phone"), 
                errorMsg = document.querySelector("#error-msg"),
                validMsg = document.querySelector("#valid-msg");

            if(input) {
                var iti = window.intlTelInput(input, {
                    hiddenInput: "contact_number",
                    separateDialCode: true,
                    utilsScript: "{{ asset('vendor/intlTelInput/js/utils.js') }}" // just for formatting/placeholders etc
                });

                input.addEventListener("countrychange", function() {
                  validate();
                });

                // // here, the index maps to the error code returned from getValidationError - see readme
                var errorMap = [ "Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];
                //
                // // initialise plugin
                const phone = $('#phone');
                const err = $('#error-msg');
                const succ = $('#valid-msg');
                var reset = function() {
                    err.addClass('d-none');
                    succ.addClass('d-none');
                    validate();
                };

                // on blur: validate
                $(document).on('blur, keyup','#phone',function () {
                    reset();
                    var val = $(this).val();
                    if (val.match(/[^0-9\.\+.\s.]/g)) {
                        $(this).val(val.replace(/[^0-9\.\+.\s.]/g, ''));
                    }
                    if(val === ''){
                        $('[type="submit"]').removeClass('disabled').prop('disabled',false);
                    }
                });

                // on keyup / change flag: reset
                input.addEventListener('change', reset);
                input.addEventListener('keyup', reset);

                var errorCode = '';

                function validate() {
                    if (input.value.trim()) {
                        if (iti.isValidNumber()) {
                            succ.removeClass('d-none');
                            err.html('');
                            err.addClass('d-none');
                            $('[type="submit"]').removeClass('disabled').prop('disabled',false);
                        } else {
                            errorCode = iti.getValidationError();
                            err.html(errorMap[errorCode]);
                            err.removeClass('d-none');
                            phone.closest('.form-group').addClass('has-danger');
                            $('[type="submit"]').addClass('disabled').prop('disabled',true);
                        }
                    }
                }
            }

            
        });
    @endif

    @if(isset($assets) && in_array('maps', $assets))
        $(document).ready(function() {
            
            var map; // Global declaration of the map
            var drawingManager;
            var last_latlong = null;
            var polygons = [];

            function initialize() {
                var myLatlng = new google.maps.LatLng(20.947940, 72.955786);
                var myOptions = {
                    zoom: 13,
                    center: myLatlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }
                
                map = new google.maps.Map(document.getElementById('map-canvas'), myOptions);
                drawingManager = new google.maps.drawing.DrawingManager({
                    drawingMode: google.maps.drawing.OverlayType.POLYGON,
                    drawingControl: true,
                    drawingControlOptions: {
                        position: google.maps.ControlPosition.TOP_CENTER,
                        drawingModes: [google.maps.drawing.OverlayType.POLYGON]
                    },
                    
                    polygonOptions: {
                        editable: true
                    }
                });
                
                drawingManager.setMap(map);
            }             
            if(window.google || window.google.maps) {
                initialize();
            }
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                    const pos = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude,
                    };
                    map.setCenter(pos);
                });
            }
            google.maps.event.addListener(drawingManager, 'overlaycomplete', function(event) {
                if ( last_latlong ) {
                    last_latlong.setMap(null);
                }
                
                $('#coordinates').val(event.overlay.getPath().getArray());
                last_latlong = event.overlay;
                auto_grow();
            });

            function auto_grow() {
                let element = document.getElementById('coordinates');
                element.style.height = '5px';
                element.style.height = (element.scrollHeight)+'px';
            }
        });
    @endif
    });
})(jQuery);
</script>