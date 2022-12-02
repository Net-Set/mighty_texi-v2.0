import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:taxibooking/model/CouponListModel.dart';
import 'package:taxibooking/model/CurrentRequestModel.dart';
import 'package:taxibooking/model/EstimatePriceModel.dart';
import 'package:taxibooking/model/GooglePlaceIdModel.dart';
import 'package:taxibooking/model/LDBaseResponse.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../model/AppSettingModel.dart';
import '../model/ChangePasswordResponseModel.dart';
import '../model/ContactNumberListModel.dart';
import '../model/GoogleMapSearchModel.dart';
import '../model/LoginResponse.dart';
import '../model/NotificationListModel.dart';
import '../model/PaymentListModel.dart';
import '../model/RideDetailModel.dart';
import '../model/RiderListModel.dart';
import '../model/ServiceModel.dart';
import '../model/WalletListModel.dart';
import '../screens/LoginScreen.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import 'NetworkUtils.dart';

Future<LoginResponse> signUpApi(Map request) async {
  Response response = await buildHttpResponse('register', request: request, method: HttpMethod.POST);

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
    await sharedPref.setString(USER_TYPE, loginResponse.data!.userType.validate());
    await sharedPref.setString(FIRST_NAME, loginResponse.data!.firstName.validate());
    await sharedPref.setString(LAST_NAME, loginResponse.data!.lastName.validate());
    await sharedPref.setString(CONTACT_NUMBER, loginResponse.data!.contactNumber.validate());
    await sharedPref.setString(USER_EMAIL, loginResponse.data!.email.validate());
    await sharedPref.setString(USER_NAME, loginResponse.data!.username.validate());
    await sharedPref.setString(ADDRESS, loginResponse.data!.address.validate());
    await sharedPref.setInt(USER_ID, loginResponse.data!.id!);
    await sharedPref.setString(USER_PROFILE_PHOTO, loginResponse.data!.profileImage.validate());
    await sharedPref.setString(GENDER, loginResponse.data!.gender.validate());
    await sharedPref.setString(LOGIN_TYPE, loginResponse.data!.loginType.validate());
    await appStore.setLoggedIn(true);
    await appStore.setUserEmail(loginResponse.data!.email.validate());
    await sharedPref.setString(UID, loginResponse.data!.uid.validate());
    await appStore.setUserProfile(loginResponse.data!.profileImage.validate());

    return loginResponse;
  }).catchError((e) {
    toast(e.toString());
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
    await sharedPref.setString(USER_TYPE, loginResponse.data!.userType.validate());
    await sharedPref.setString(FIRST_NAME, loginResponse.data!.firstName.validate());
    await sharedPref.setString(LAST_NAME, loginResponse.data!.lastName.validate());
    await sharedPref.setString(CONTACT_NUMBER, loginResponse.data!.contactNumber.validate());
    await sharedPref.setString(USER_EMAIL, loginResponse.data!.email.validate());
    await sharedPref.setString(USER_NAME, loginResponse.data!.username.validate());
    await sharedPref.setString(ADDRESS, loginResponse.data!.address.validate());
    await sharedPref.setInt(USER_ID, loginResponse.data!.id ?? 0);
    await sharedPref.setString(USER_PROFILE_PHOTO, loginResponse.data!.profileImage.validate());
    await sharedPref.setString(GENDER, loginResponse.data!.gender.validate());
    await sharedPref.setString(LOGIN_TYPE, loginResponse.data!.loginType.validate());
    await appStore.setLoggedIn(true);
    await appStore.setUserEmail(loginResponse.data!.email.validate());
    await sharedPref.setString(UID, loginResponse.data!.uid.validate());
    await appStore.setUserProfile(loginResponse.data!.profileImage.validate());

    return loginResponse;
  }).catchError((e) {
    log('${e.toString()}');
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
    log(res.statusCode);
    res.stream.transform(utf8.decoder).listen((value) {
      log(value);
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
      LoginResponse res = LoginResponse.fromJson(data);

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
    toast(error.toString());
  });
}

Future<void> logout({required BuildContext data}) async {
  await appStore.setLoggedIn(false);
  sharedPref.remove(FIRST_NAME);
  sharedPref.remove(LAST_NAME);
  sharedPref.remove(USER_PROFILE_PHOTO);
  sharedPref.remove(USER_NAME);
  sharedPref.remove(USER_ADDRESS);
  sharedPref.remove(CONTACT_NUMBER);
  sharedPref.remove(GENDER);
  sharedPref.remove(UID);
  sharedPref.remove(LOGIN_TYPE);
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

Future<LoginResponse> getUserDetail({int? userId}) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse('user-detail?id=$userId', method: HttpMethod.GET)));
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

Future<EstimatePriceModel> estimatePriceList(Map request) async {
  return EstimatePriceModel.fromJson(await handleResponse(await buildHttpResponse('estimate-price-time', method: HttpMethod.POST, request: request)));
}

Future<CouponListModel> getCouponList() async {
  return CouponListModel.fromJson(await handleResponse(await buildHttpResponse('coupon-list', method: HttpMethod.GET)));
}

Future<LDBaseResponse> savePayment(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-payment', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> saveRideRequest(Map request) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-riderequest', method: HttpMethod.POST, request: request)));
}

Future<AppSettingModel> getAppSetting() async {
  return AppSettingModel.fromJson(await handleResponse(await buildHttpResponse('admin-dashboard', method: HttpMethod.GET)));
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

Future<LDBaseResponse> adminNotify({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('admin-sos-notify', method: HttpMethod.POST, request: request)));
}


Future<RiderListModel> getRiderRequestList({int? page, String? status, LatLng? sourceLatLog, int? riderId}) async {
  if (sourceLatLog != null) {
    return RiderListModel.fromJson(await handleResponse(await buildHttpResponse('riderequest-list?page=$page&rider_id=$riderId', method: HttpMethod.GET)));
  } else {
    return RiderListModel.fromJson(await handleResponse(
        await buildHttpResponse(status != null ? 'riderequest-list?page=$page&status=$status&rider_id=$riderId' : 'riderequest-list?page=$page&rider_id=$riderId', method: HttpMethod.GET)));
  }
}

Future<LDBaseResponse> saveComplain({required Map request}) async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('save-complaint', method: HttpMethod.POST, request: request)));
}

Future<RideDetailModel> rideDetail({required int? orderId}) async {
  return RideDetailModel.fromJson(await handleResponse(await buildHttpResponse('riderequest-detail?id=$orderId', method: HttpMethod.GET)));
}

/// Get Notification List
Future<NotificationListModel> getNotification({required int page}) async {
  return NotificationListModel.fromJson(await handleResponse(await buildHttpResponse('notification-list?page=$page', method: HttpMethod.POST)));
}

Future<GoogleMapSearchModel> searchAddressRequest({String? search}) async {
  return GoogleMapSearchModel.fromJson(
      await handleResponse(await buildHttpResponse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$googleMapAPIKey', method: HttpMethod.GET)));
}

Future<GooglePlaceIdModel> searchAddressRequestPlaceId({String? placeId}) async {
  return GooglePlaceIdModel.fromJson(
      await handleResponse(await buildHttpResponse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleMapAPIKey', method: HttpMethod.GET)));
}

Future<LoginResponse> updateStatus(Map request) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse('update-user-status', method: HttpMethod.POST, request: request)));
}

Future<LDBaseResponse> deleteUser() async {
  return LDBaseResponse.fromJson(await handleResponse(await buildHttpResponse('delete-user-account', method: HttpMethod.POST)));
}
