import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:taxi_driver/model/DocumentListModel.dart';
import 'package:taxi_driver/model/RideDetailModel.dart';
import 'package:taxi_driver/model/RiderListModel.dart';
import 'package:taxi_driver/model/UserDetailModel.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../model/AdditionalFeesList.dart';
import '../model/AppSettingModel.dart';
import '../model/ChangePasswordResponseModel.dart';
import '../model/ContactNumberListModel.dart';
import '../model/CurrentRequestModel.dart';
import '../model/DriverDocumentList.dart';
import '../model/LDBaseResponse.dart';
import '../model/LoginResponse.dart';
import '../model/NotificationListModel.dart';
import '../model/PaymentListModel.dart';
import '../model/ProfileUpdateModel.dart';
import '../model/ServiceModel.dart';
import '../model/WalletListModel.dart';
import '../model/WithDrawListModel.dart';
import '../screens/LoginScreen.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import 'NetworkUtils.dart';

Future<LoginResponse> signUpApi(Map request) async {
  Response response = await buildHttpResponse('driver-register', request: request, method: HttpMethod.POST);

  if (!(response.statusCode >= 200 && response.statusCode <= 206)) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    var loginResponse = LoginResponse.fromJson(json);
    await sharedPref.setString(TOKEN, loginResponse.data!.apiToken.validate());
    await sharedPref.setString(USER_TYPE, loginResponse.data!.user_type.validate());
    await sharedPref.setString(FIRST_NAME, loginResponse.data!.first_name.validate());
    await sharedPref.setString(LAST_NAME, loginResponse.data!.last_name.validate());
    await sharedPref.setString(CONTACT_NUMBER, loginResponse.data!.contact_number.validate());
    await sharedPref.setString(USER_EMAIL, loginResponse.data!.email.validate());
    await sharedPref.setString(USER_NAME, loginResponse.data!.username.validate());
    await sharedPref.setString(ADDRESS, loginResponse.data!.address.validate());
    await sharedPref.setInt(USER_ID, loginResponse.data!.id!);
    await sharedPref.setString(USER_PROFILE_PHOTO, loginResponse.data!.profile_image.validate());
    await sharedPref.setString(GENDER, loginResponse.data!.gender.validate());
    await sharedPref.setInt(IS_ONLINE, loginResponse.data!.is_online ?? 0);
    await sharedPref.setString(UID, loginResponse.data!.uid.validate());
    await sharedPref.setString(LOGIN_TYPE, loginResponse.data!.login_type.validate());
    await sharedPref.setInt(IS_Verified_Driver, loginResponse.data!.is_verified_driver ?? 0);


    await appStore.setLoggedIn(true);
    await appStore.setUserEmail(loginResponse.data!.email.validate());
    await appStore.setUserProfile(loginResponse.data!.profile_image.validate());

    return loginResponse;
  }).catchError((e) {
    log(e.toString());
  });
}

Future<LoginResponse> logInApi(Map request, {bool isSocialLogin = false}) async {
  Response response = await buildHttpResponse(isSocialLogin ? 'social-login' : 'login', request: request, method: HttpMethod.POST);

  if (!(response.statusCode >= 200 && response.statusCode <= 206)) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((json) async {
    var loginResponse = LoginResponse.fromJson(json);

    await sharedPref.setString(TOKEN, loginResponse.data!.apiToken.validate());
    await sharedPref.setString(USER_TYPE, loginResponse.data!.user_type.validate());
    await sharedPref.setString(FIRST_NAME, loginResponse.data!.first_name.validate());
    await sharedPref.setString(LAST_NAME, loginResponse.data!.last_name.validate());
    await sharedPref.setString(CONTACT_NUMBER, loginResponse.data!.contact_number.validate());
    await sharedPref.setString(USER_EMAIL, loginResponse.data!.email.validate());
    await sharedPref.setString(USER_NAME, loginResponse.data!.username.validate());
    await sharedPref.setString(ADDRESS, loginResponse.data!.address.validate());
    await sharedPref.setInt(USER_ID, loginResponse.data!.id ?? 0);
    await sharedPref.setString(USER_PROFILE_PHOTO, loginResponse.data!.profile_image.validate());
    await sharedPref.setString(GENDER, loginResponse.data!.gender.validate());
    await sharedPref.setInt(IS_ONLINE, loginResponse.data!.is_online ?? 0);
    await sharedPref.setInt(IS_Verified_Driver, loginResponse.data!.is_verified_driver ?? 0);
    await sharedPref.setString(UID, loginResponse.data!.uid.validate());
    await sharedPref.setString(LOGIN_TYPE, loginResponse.data!.login_type.validate());

    await appStore.setLoggedIn(true);
    await appStore.setUserEmail(loginResponse.data!.email.validate());
    await appStore.setUserProfile(loginResponse.data!.profile_image.validate());

    return loginResponse;
  }).catchError((e) {
    throw e.toString();
  });
}

Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = '${baseUrl ?? buildBaseUrl(endPoint).toString()}';
  log(url);
  return MultipartRequest('POST', Uri.parse(url));
}

Future sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  multiPartRequest.headers.addAll(buildHeaderTokens());

  await multiPartRequest.send().then((res) {
    res.stream.transform(Utf8Decoder()).transform(LineSplitter()).listen((value) {
      onSuccess?.call(jsonDecode(value));
    });
  }).catchError((error) {
    onError?.call(error.toString());
  });
}

/// Profile Update
Future updateProfile({String? firstName, String? lastName, String? userEmail, String? address, String? contactNumber, String? gender, File? file}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
  multiPartRequest.fields['id'] = sharedPref.getInt(USER_ID).toString();
  multiPartRequest.fields['username'] = sharedPref.getString(USER_NAME).validate();
  multiPartRequest.fields['email'] = userEmail ?? appStore.userEmail;
  multiPartRequest.fields['first_name'] = firstName.validate();
  multiPartRequest.fields['last_name'] = lastName.validate();
  multiPartRequest.fields['contact_number'] = contactNumber.validate();
  multiPartRequest.fields['address'] = address.validate();
  multiPartRequest.fields['gender'] = gender.validate();

  if (file != null) multiPartRequest.files.add(await MultipartFile.fromPath('profile_image', file.path));

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      ProfileUpdate res = ProfileUpdate.fromJson(data);
      await sharedPref.setString(FIRST_NAME, res.data!.firstName.validate());
      await sharedPref.setString(LAST_NAME, res.data!.lastName.validate());
      await sharedPref.setString(USER_PROFILE_PHOTO, res.data!.profileImage.validate());
      await sharedPref.setString(USER_NAME, res.data!.username.validate());
      await sharedPref.setString(USER_ADDRESS, res.data!.address.validate());
      await sharedPref.setString(CONTACT_NUMBER, res.data!.contactNumber.validate());
      await sharedPref.setString(GENDER, res.data!.gender.validate());
      await appStore.setUserEmail(res.data!.email.validate());
      await appStore.setUserProfile(res.data!.profileImage.validate());
    }
  }, onError: (error) {
    log('${error.toString()}');
    toast(error.toString());
  });
}

Future<void> logout({required BuildContext data}) async {
  sharedPref.remove(USER_ID);
  sharedPref.remove(FIRST_NAME);
  sharedPref.remove(LAST_NAME);
  sharedPref.remove(USER_PROFILE_PHOTO);
  sharedPref.remove(USER_NAME);
  sharedPref.remove(USER_ADDRESS);
  sharedPref.remove(CONTACT_NUMBER);
  sharedPref.remove(GENDER);
  sharedPref.remove(UID);

  appStore.setLoggedIn(false);
  await appStore.setUserEmail('');

  launchScreen(data, LoginScreen(), isNewTask: true);
}

Future<ChangePasswordResponseModel> changePassword(Map req) async {
  return ChangePasswordResponseModel.fromJson(await handleResponse(await buildHttpResponse('change-password', request: req, method: HttpMethod.POST)));
}

Future<ChangePasswordResponseModel> forgotPassword(Map req) async {
  return ChangePasswordResponseModel.fromJson(await handleResponse(await buildHttpResponse('forget-password', request: req, method: HttpMethod.POST)));
}

Future<ServiceModel> getServices() async {
  return ServiceModel.fromJson(await handleResponse(await buildHttpResponse('service-list', method: HttpMethod.GET)));
}

Future<UserDetailModel> getUserDetail({int? userId}) async {
  return UserDetailModel.fromJson(await handleResponse(await buildHttpResponse('user-detail?id=$userId', method: HttpMethod.GET)));
}

Future<LDBaseResponse> changeStatus(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('update-user-status', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> saveBooking(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('update-user-status', method: HttpMethod.POST, request: request)));
}

Future<WalletListModel> getWalletList({required int page}) async {
  return WalletListModel.fromJson(await handleResponse(await buildHttpResponse('wallet-list?page=$Page', method: HttpMethod.GET)));
}

Future<PaymentListModel> getPaymentList() async {
  return PaymentListModel.fromJson(await handleResponse(await buildHttpResponse('payment-gateway-list', method: HttpMethod.GET)));
}

Future<LDBaseResponse> saveWallet(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-wallet', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> saveSOS(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-sos', method: HttpMethod.POST, request: request)));
}

Future<ContactNumberListModel> getSosList() async {
  return ContactNumberListModel.fromJson(await handleResponse(await buildHttpResponse('sos-list', method: HttpMethod.GET)));
}

Future<ContactNumberListModel> deleteSosList({int? id}) async {
  return ContactNumberListModel.fromJson(await handleResponse(await buildHttpResponse('sos-delete/$id', method: HttpMethod.POST)));
}

Future<WithDrawListModel> getWithDrawList({int? page}) async {
  return WithDrawListModel.fromJson(await handleResponse(await buildHttpResponse('withdrawrequest-list?page=$page', method: HttpMethod.GET)));
}

Future<LDBaseResponse> saveWithDrawRequest(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-withdrawrequest', method: HttpMethod.POST, request: request)));
}

Future<AppSettingModel> getAppSetting() async {
  return AppSettingModel.fromJson(await handleResponse(await buildHttpResponse('admin-dashboard', method: HttpMethod.GET)));
}

Future<RiderListModel> getRiderRequestList({int? page, String? status, LatLng? sourceLatLog, int? driverId}) async {
  if (sourceLatLog != null) {
    return RiderListModel.fromJson(await handleResponse(await buildHttpResponse('riderequest-list?page=$page&driver_id=$driverId', method: HttpMethod.GET)));
  } else {
    return RiderListModel.fromJson(await handleResponse(
        await buildHttpResponse(status != null ? 'riderequest-list?page=$page&status=$status&driver_id=$driverId' : 'riderequest-list?page=$page&driver_id=$driverId', method: HttpMethod.GET)));
  }
}

Future<DocumentListModel> getDocumentList() async {
  return DocumentListModel.fromJson(await handleResponse(await buildHttpResponse('document-list', method: HttpMethod.GET)));
}

Future<DriverDocumentList> getDriverDocumentList() async {
  return DriverDocumentList.fromJson(await handleResponse(await buildHttpResponse('driver-document-list', method: HttpMethod.GET)));
}

/// Profile Update
Future uploadDocument({int? driverId, int? documentId, File? file, int? isExpire}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('driver-document-save');
  multiPartRequest.fields['driver_id'] = driverId.toString();
  multiPartRequest.fields['document_id'] = documentId.toString();
  multiPartRequest.fields['is_verified'] = '0';
  if (isExpire != null) multiPartRequest.fields['is_verified'] = '0';
  if (file != null) multiPartRequest.files.add(await MultipartFile.fromPath('driver_document', file.path));

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      //
    }
  }, onError: (error) {
    toast(error.toString());
  });
}

Future<LDBaseResponse> deleteDeliveryDoc(int id) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('driver-document-delete/$id', method: HttpMethod.POST)));
}

Future<LoginResponse> updateStatus(Map request) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse('update-user-status', method: HttpMethod.POST, request: request)));
}

Future<UserDetailModel> userDetail(int? userId) async {
  return UserDetailModel.fromJson(await handleResponse(await buildHttpResponse('user-detail?id=$userId', method: HttpMethod.POST)));
}

/// Update Vehicle Info
Future updateVehicleDetail({String? carModel, String? carColor, String? carPlateNumber, String? carProduction}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
  multiPartRequest.fields['id'] = sharedPref.getInt(USER_ID).toString();
  multiPartRequest.fields['email'] = sharedPref.getString(USER_EMAIL).validate();
  multiPartRequest.fields['contact_number'] = sharedPref.getString(CONTACT_NUMBER).validate();
  multiPartRequest.fields['username'] = sharedPref.getString(USER_NAME).validate();
  multiPartRequest.fields['user_detail[car_model]'] = carModel.validate();
  multiPartRequest.fields['user_detail[car_color]'] = carColor.validate();
  multiPartRequest.fields['user_detail[car_plate_number]'] = carPlateNumber.validate();
  multiPartRequest.fields['user_detail[car_production_year]'] = carProduction.validate();

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      //
    }
  }, onError: (error) {
    toast(error.toString());
  });
}

/// Update Bank Info
Future updateBankDetail({String? bankName, String? bankCode, String? accountName, String? accountNumber}) async {
  MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
  multiPartRequest.fields['email'] = sharedPref.getString(USER_EMAIL).validate();
  multiPartRequest.fields['contact_number'] = sharedPref.getString(CONTACT_NUMBER).validate();
  multiPartRequest.fields['username'] = sharedPref.getString(USER_NAME).validate();
  multiPartRequest.fields['user_bank_account[bank_name]'] = bankName.validate();
  multiPartRequest.fields['user_bank_account[bank_code]'] = bankCode.validate();
  multiPartRequest.fields['user_bank_account[account_holder_name]'] = accountName.validate();
  multiPartRequest.fields['user_bank_account[account_number]'] = accountNumber.validate();

  await sendMultiPartRequest(multiPartRequest, onSuccess: (data) async {
    if (data != null) {
      //
    }
  }, onError: (error) {
    toast(error.toString());
  });
}

Future<CurrentRequestModel> getCurrentRideRequest() async {
  return CurrentRequestModel.fromJson(await handleResponse(await buildHttpResponse('current-riderequest', method: HttpMethod.GET)));
}

Future<LDBaseResponse> rideRequestUpdate({required Map request, int? rideId}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('riderequest-update/$rideId', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> ratingReview({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-ride-rating', method: HttpMethod.POST, request: request)));
}

Future<AdditionalFeesList> getAdditionalFees() async {
  return AdditionalFeesList.fromJson(await handleResponse(await buildHttpResponse('additional-fees-list', method: HttpMethod.GET)));
}

Future<LDBaseResponse> adminNotify({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('admin-sos-notify', method: HttpMethod.POST, request: request)));
}

Future<RideDetailModel> rideDetail({required int? orderId}) async {
  return RideDetailModel.fromJson(await handleResponse(await buildHttpResponse('riderequest-detail?id=$orderId', method: HttpMethod.GET)));
}

Future<LDBaseResponse> saveComplain({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-complaint', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> completeRide({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('complete-riderequest', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> savePayment(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-payment', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> rideRequestResPond({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('riderequest-respond', method: HttpMethod.POST, request: request)));
}

/// Get Notification List
Future<NotificationListModel> getNotification({required int page}) async {
  return NotificationListModel.fromJson(await handleResponse(await buildHttpResponse('notification-list?page=$page', method: HttpMethod.POST)));
}

Future<LDBaseResponse> deleteUser() async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('delete-user-account', method: HttpMethod.POST)));
}
