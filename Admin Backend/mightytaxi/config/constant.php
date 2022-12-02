<?php
return [
    'IMAGE_EXTENTIONS' => ['png','jpg','jpeg','gif'],
    'PER_PAGE_LIMIT' => 10,
    'MAIL_SETTING' => [
        'MAIL_MAILER' => env('MAIL_MAILER'),
        'MAIL_HOST' => env('MAIL_HOST'),
        'MAIL_PORT' => env('MAIL_PORT'),
        'MAIL_USERNAME' => env('MAIL_USERNAME'),
        'MAIL_PASSWORD' => env('MAIL_PASSWORD'),
        'MAIL_ENCRYPTION' => env('MAIL_ENCRYPTION'),
        'MAIL_FROM_ADDRESS' => env('MAIL_FROM_ADDRESS'),
    ],
    'MAIL_PLACEHOLDER' => [
        'MAIL_MAILER' => 'smtp',
        'MAIL_HOST' => 'smtp.gmail.com',
        'MAIL_PORT' => '587',
        'MAIL_ENCRYPTION' => 'tls',
        'MAIL_USERNAME' => 'youremail@gmail.com',
        'MAIL_PASSWORD' => 'Password',
        'MAIL_FROM_ADDRESS' => 'youremail@gmail.com',
    ],
    'PAYMENT_GATEWAY_SETTING' => [
        // 'cash' => [],
        'stripe' => [ 'url', 'secret_key', 'publishable_key' ],
        'razorpay' => [ 'key_id', 'secret_id' ],
        'paystack' => [ 'public_key' ],
        'flutterwave' => [ 'public_key', 'secret_key', 'encryption_key' ],
        'paypal' => [ 'tokenization_key' ],
        'paytabs' => [ 'client_key', 'profile_id', 'server_key'],
        'mercadopago' => [ 'public_key', 'access_token' ],
        'myfatoorah' => ['access_token'],
        'paytm' => [ 'merchant_id', 'merchant_key' ],
    ],

    'wallet' => [
        'min_amount_to_add'     => '',
        'max_amount_to_add'     => '',
        'min_amount_to_get_ride'=> '',
        'preset_topup_amount'   => '',
    ],

    'ride' => [
        'max_time_for_find_drivers_for_regular_ride_in_minute'  => '',
        'ride_accept_decline_duration_for_driver_in_second'     => '',
        // 'schedule_ride_after_minute'    => '',
        // 'min_time_for_find_driver_for_schedule_ride_in_minute'  => '',
        'preset_tip_amount'   => '',
        'apply_additional_fee'  => '',
    ],
    'ride_status' => ['new_ride_requested', 'no_drivers_available', 'accepted', 'arriving', 'arrived', 'in_progress', 'canceled', 'completed' , 'sos'],
    'notification' => [
        'IS_ONESIGNAL' => '',
        // 'IS_FIREBASE' => '',
    ],
];