<div class="col-md-12">
    <div class="row ">
		<div class="col-md-3">
			<div class="user-sidebar">
				<div class="user-body user-profile text-center">
					<div class="user-img">
						<img class="rounded-circle avatar-100 image-fluid profile_image_preview" src="{{ getSingleMedia($user_data,'profile_image', null) }}" alt="profile-pic">
					</div>
					<div class="sideuser-info">
						<span class="mb-2">{{ $user_data->display_name }}</span>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-9">
			<div class="user-content">
				{{ Form::model($user_data, ['route'=>'updateProfile','method' => 'POST','data-toggle'=>"validator" , 'enctype'=> 'multipart/form-data','id' => 'user-form']) }}
					<input type="hidden" name="profile" value="profile">
					{{ Form::hidden('username') }}
					{{ Form::hidden('email') }}
				    {{ Form::hidden('id', null, [ 'placeholder' => 'id','class' => 'form-control' ]) }}
				    <div class="row ">
				        
						<div class="form-group col-md-6">
							{{ Form::label('first_name',__('message.first_name').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
							{{ Form::text('first_name',old('first_name'),['placeholder' => __('message.first_name'),'class' =>'form-control','required']) }}
						</div>
						
						<div class="form-group col-md-6">
							{{ Form::label('last_name',__('message.last_name').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
							{{ Form::text('last_name',old('last_name'),['placeholder' => __('message.last_name'),'class' =>'form-control','required']) }}
						</div>
						
						<div class="form-group col-md-6">
							{{ Form::label('username',__('message.username').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
							{{ Form::text('username',old('username'),['placeholder' => __('message.username'),'class' =>'form-control','required']) }}
						</div>

						<div class="form-group col-md-6">
							{{ Form::label('email',__('message.email').' <span class="text-danger">*</span>',['class'=>'form-control-label'], false ) }}
							{{ Form::email('email',old('email'),['placeholder' => __('message.email'),'class' =>'form-control','required']) }}
						</div>

				        <div class="form-group col-md-6">
							{{ Form::label('contact_number',__('message.contact_number').' <span class="text-danger">*</span>',[ 'class' => 'form-control-label'], false ) }}
							{{ Form::text('contact_number', old('contact_number'),[ 'placeholder' => __('message.contact_number'), 'class' => 'form-control', 'id' => 'phone' ]) }}
						</div>

				        <div class="form-group col-md-6">
							{{ Form::label('profile_image',__('message.choose_profile_image'),['class'=>'form-control-label col-md-12'] ) }}
							<div class="custom-file">
								{{ Form::file('profile_image', ['class'=>"custom-file-input custom-file-input-sm detail" , 'id'=>"profile_image" , 'lang'=>"en" , 'accept'=>"image/*"]) }}
								<label class="custom-file-label" id="imagelabel" for="profile_image">{{ __('message.profile_image') }}</label>
							</div> 
				        </div>

						<div class="form-group col-md-12">
							{{ Form::label('address',__('message.address'), ['class' => 'form-control-label']) }}
							{{ Form::textarea('address', null, ['class'=>"form-control textarea" , 'rows'=>3  , 'placeholder'=> __('message.address') ]) }}
						</div>
				        <div class="col-md-12">
							{{ Form::submit(__('message.update'), ['class'=>"btn btn-md btn-primary float-md-right"]) }}
				        </div>
				    </div>
			</div>
		</div>
    </div>
</div>

<script>
	$(document).ready(function (){
				
        $(document).on('change','#profile_image',function(){
			readURL(this);
		})
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				var res=isImage(input.files[0].name);

				if(res==false){
					var msg = "{{ __('message.image_png_gif') }}";
					Snackbar.show({text: msg ,pos: 'bottom-center',backgroundColor:'#d32f2f',actionTextColor:'#fff'});
					return false;
				}

				reader.onload = function(e) {
				$('.profile_image_preview').attr('src', e.target.result);
					$("#imagelabel").text((input.files[0].name));
				}

				reader.readAsDataURL(input.files[0]);
			}
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
				return true;
			}
			return false;
		}

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
	})
</script>