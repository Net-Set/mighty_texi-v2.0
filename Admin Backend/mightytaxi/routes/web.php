<?php

use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\RiderController;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\FleetController;
use App\Http\Controllers\RegionController;
use App\Http\Controllers\ServiceController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\CouponController;
use App\Http\Controllers\ComplaintController;
use App\Http\Controllers\RideRequestController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\LanguageController;
use App\Http\Controllers\AdditionalFeesController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\DriverDocumentController;
use App\Http\Controllers\SosController;
use App\Http\Controllers\WithdrawRequestController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

require __DIR__.'/auth.php';


Route::get('/mqtt/publish/{topic}/{message}', [ HomeController::class, 'SendMsgViaMqtt' ]);
Route::get('/mqtt/subscribe/{topic}', [ HomeController::class, 'SubscribetoTopic' ]);

//Auth pages Routs
Route::group(['prefix' => 'auth'], function() {
    Route::get('login', [HomeController::class, 'authLogin'])->name('auth.login');
    Route::get('register', [HomeController::class, 'authRegister'])->name('auth.register');
    Route::get('recover-password', [HomeController::class, 'authRecoverPassword'])->name('auth.recover-password');
    Route::get('confirm-email', [HomeController::class, 'authConfirmEmail'])->name('auth.confirm-email');
    Route::get('lock-screen', [HomeController::class, 'authlockScreen'])->name('auth.lock-screen');
});

Route::get('language/{locale}', [ HomeController::class, 'changeLanguage'])->name('change.language');
Route::group(['middleware' => ['auth', 'verified', 'admin']], function()
{
    Route::get('/', [HomeController::class, 'index']);
    Route::get('/home', [HomeController::class, 'index'])->name('home');

    Route::group(['namespace' => '' ], function () {
        Route::resource('permission', PermissionController::class);
        Route::get('permission/add/{type}',[ PermissionController::class,'addPermission' ])->name('permission.add');
        Route::post('permission/save',[ PermissionController::class,'savePermission' ])->name('permission.save');
	});

	Route::resource('role', RoleController::class);
	Route::resource('region', RegionController::class);
	Route::resource('service', ServiceController::class);
        
	Route::resource('rider', RiderController::class);
	Route::resource('driver', DriverController::class);
	Route::resource('fleet', FleetController::class);
	Route::resource('additionalfees', AdditionalFeesController::class);
	Route::resource('document', DocumentController::class);
	Route::resource('driverdocument', DriverDocumentController::class);
    
    
    Route::resource('riderequest', RideRequestController::class)->except(['create', 'edit']);
    Route::resource('coupon', CouponController::class);
    Route::resource('complaint', ComplaintController::class);
    Route::resource('sos', SosController::class);
    Route::resource('withdrawrequest', WithdrawRequestController::class);
    Route::post('withdrawrequest/status', [ WithdrawRequestController::class, 'updateStatus' ] )->name('withdraw.request.status');

	Route::get('changeStatus', [ HomeController::class, 'changeStatus'])->name('changeStatus');

	Route::get('setting/{page?}',[ SettingController::class, 'settings'])->name('setting.index');
    Route::post('/layout-page',[ SettingController::class, 'layoutPage'])->name('layout_page');
    Route::post('settings/save',[ SettingController::class , 'settingsUpdates'])->name('settingsUpdates');
    Route::post('mobile-config-save',[ SettingController::class , 'settingUpdate'])->name('settingUpdate');
    Route::post('payment-settings/save',[ SettingController::class , 'paymentSettingsUpdate'])->name('paymentSettingsUpdate');
    Route::post('wallet-settings/save',[ SettingController::class , 'walletSettingsUpdate'])->name('walletSettingsUpdate');
    Route::post('ride-settings/save',[ SettingController::class , 'rideSettingsUpdate'])->name('rideSettingsUpdate');
    Route::post('notification-settings/save',[ SettingController::class , 'notificationSettingsUpdate'])->name('notificationSettingsUpdate');
    
    Route::post('get-lang-file', [ LanguageController::class, 'getFile' ] )->name('getLanguageFile');
    Route::post('save-lang-file', [ LanguageController::class, 'saveFileContent' ] )->name('saveLangContent');

    Route::get('pages/term-condition',[ SettingController::class, 'termAndCondition'])->name('term-condition');
    Route::post('term-condition-save',[ SettingController::class, 'saveTermAndCondition'])->name('term-condition-save');

    Route::get('pages/privacy-policy',[ SettingController::class, 'privacyPolicy'])->name('privacy-policy');
    Route::post('privacy-policy-save',[ SettingController::class, 'savePrivacyPolicy'])->name('privacy-policy-save');
    
	Route::post('env-setting', [ SettingController::class , 'envChanges'])->name('envSetting');
    Route::post('update-profile', [ SettingController::class , 'updateProfile'])->name('updateProfile');
    Route::post('change-password', [ SettingController::class , 'changePassword'])->name('changePassword');

    Route::get('notification-list',[ NotificationController::class ,'notificationList'])->name('notification.list');
    Route::get('notification-counts',[ NotificationController::class ,'notificationCounts'])->name('notification.counts');
    Route::get('notification',[ NotificationController::class ,'index'])->name('notification.index');

    Route::post('remove-file',[ HomeController::class, 'removeFile' ])->name('remove.file');

});

Route::get('/ajax-list',[ HomeController::class, 'getAjaxList' ])->name('ajax-list');