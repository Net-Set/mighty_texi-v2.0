import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxibooking/screens/ReviewScreen.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../components/DrawerWidget.dart';
import '../main.dart';
import '../model/CurrentRequestModel.dart';
import '../model/TextModel.dart';
import '../network/RestApis.dart';
import '../screens/EmergencyContactScreen.dart';
import '../screens/MyRidesScreen.dart';
import '../screens/MyWalletScreen.dart';
import '../screens/OrderDetailScreen.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/DataProvider.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/ConformationDialog.dart';
import '../utils/Extensions/LiveStream.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';
import 'EditProfileScreen.dart';
import 'LocationPermissionScreen.dart';
import 'NewEstimateRideListWidget.dart';
import 'NotificationScreen.dart';
import 'RiderWidget.dart';
import 'SettingScreen.dart';

class RiderDashBoardScreen extends StatefulWidget {
  @override
  RiderDashBoardScreenState createState() => RiderDashBoardScreenState();
}

class RiderDashBoardScreenState extends State<RiderDashBoardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LatLng? sourceLocation;

  List<TexIModel> list = getBookList();

  final Set<Marker> markers = {};
  Set<Polyline> _polyLines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  OnRideRequest? servicesListData;

  double cameraZoom = 14;
  double cameraTilt = 0;
  double cameraBearing = 30;
  int onTapIndex = 0;

  int selectIndex = 0;
  String sourceLocationTitle = '';

  late StreamSubscription<ServiceStatus> serviceStatusStream;

  LocationPermission? permissionData;

  late BitmapDescriptor riderIcon;

  @override
  void initState() {
    super.initState();
    locationPermission();
    afterBuildCreated(() {
      init();
      getCurrentRequest();
    });
  }

  void init() async {
    riderIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'images/ic_source_pin.png');
    await getAppSetting().then((value) {
      appStore.setWalletPresetTopUpAmount(value.walletSetting!.firstWhere((element) => element.key == PRESENT_TOPUP_AMOUNT).value ?? '10|20|30');
      appStore.setWalletTipAmount(value.rideSetting!.firstWhere((element) => element.key == PRESENT_TIP_AMOUNT).value ?? '10|20|30');
      appStore.setRiderMinutes(value.rideSetting!.firstWhere((element) => element.key == MAX_TIME_FOR_RIDER_MINUTE).value ?? '4');
      appStore.setCurrencyCode(value.currencySetting!.symbol ?? currencySymbol);
      appStore.setCurrencyName(value.currencySetting!.code ?? currencyName);
      appStore.setCurrencyPosition(value.currencySetting!.position ?? LEFT);
      if (value.walletSetting!.firstWhere((element) => element.key == MIN_AMOUNT_TO_ADD).value != null)
        appStore.setMinAmountToAdd(int.parse(value.walletSetting!.firstWhere((element) => element.key == MIN_AMOUNT_TO_ADD).value!));
      if (value.walletSetting!.firstWhere((element) => element.key == MAX_AMOUNT_TO_ADD).value != null)
        appStore.setMaxAmountToAdd(int.parse(value.walletSetting!.firstWhere((element) => element.key == MAX_AMOUNT_TO_ADD).value!));
    }).catchError((error) {
      log('${error.toString()}');
    });
    getCurrentUserLocation();
    polylinePoints = PolylinePoints();
  }

  Future<void> getCurrentUserLocation() async {
    if (permissionData != LocationPermission.denied) {
      final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).catchError((error) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => LocationPermissionScreen()));
      });
      sourceLocation = LatLng(geoPosition.latitude, geoPosition.longitude);
      markers.add(
        Marker(
          markerId: MarkerId('Order Detail'),
          position: sourceLocation!,
          infoWindow: InfoWindow(title: sourceLocationTitle, snippet: ''),
          icon: riderIcon,
        ),
      );
      List<Placemark>? placemarks = await placemarkFromCoordinates(geoPosition.latitude, geoPosition.longitude);

      Placemark place = placemarks[0];
      if (place != null) {
        sourceLocationTitle = "${place.name != null ? place.name : place.subThoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
        polylineSource = LatLng(geoPosition.latitude, geoPosition.longitude);
      }
      startLocationTracking();
      setState(() {});
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LocationPermissionScreen()));
    }
  }

  Future<void> getCurrentRequest() async {
    await getCurrentRideRequest().then((value) {
      servicesListData = value.rideRequest ?? value.onRideRequest;
      log('$servicesListData');
      if (servicesListData != null) {
        if (servicesListData!.status != COMPLETED) {
          launchScreen(
            context,
            isNewTask: true,
            NewEstimateRideListWidget(
              sourceLatLog: LatLng(double.parse(servicesListData!.startLatitude!), double.parse(servicesListData!.startLongitude!)),
              destinationLatLog: LatLng(double.parse(servicesListData!.endLatitude!), double.parse(servicesListData!.endLongitude!)),
              sourceTitle: servicesListData!.startAddress!,
              destinationTitle: servicesListData!.endAddress!,
              isCurrentRequest: true,
              servicesId: servicesListData!.serviceId,
              id: servicesListData!.id,
            ),
            pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
          );
        } else if (servicesListData!.status == COMPLETED && servicesListData!.isRiderRated == 0) {
          launchScreen(context, ReviewScreen(rideRequest: servicesListData!, driverData: value.driver), pageRouteAnimation: PageRouteAnimation.SlideBottomTop, isNewTask: true);
        }
      } else if (value.payment != null && value.payment!.paymentStatus != COMPLETED) {
        launchScreen(context, OrderDetailScreen(rideId: value.payment!.rideRequestId), pageRouteAnimation: PageRouteAnimation.SlideBottomTop, isNewTask: true);
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> locationPermission() async {
    serviceStatusStream = Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.disabled) {
        launchScreen(navigatorKey.currentState!.overlay!.context, LocationPermissionScreen());
      } else if (status == ServiceStatus.enabled) {
        getCurrentUserLocation();

        if (Navigator.canPop(navigatorKey.currentState!.overlay!.context)) {
          Navigator.pop(navigatorKey.currentState!.overlay!.context);
        }
      }
    }, onError: (error) {
     //
    });
  }

  Future<void> startLocationTracking() async {
    Map req = {
      "status": "active",
      "latitude": sourceLocation!.latitude.toString(),
      "longitude": sourceLocation!.longitude.toString(),
    };

    await updateStatus(req).then((value) {
      //
    }).catchError((error) {
      log(error);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    LiveStream().on(CHANGE_LANGUAGE, (p0) {
      setState(() {});
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 16, right: 8),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(defaultRadius)),
                child: Row(
                  children: [
                    Observer(builder: (context) {
                      return Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: commonCachedNetworkImage(appStore.userProfile.validate().validate(), height: 60, width: 60, fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      );
                    }),
                    SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          sharedPref.getString(LOGIN_TYPE) != 'mobile' && sharedPref.getString(LOGIN_TYPE) != null
                              ? Text(sharedPref.getString(USER_NAME).validate(), style: boldTextStyle(color: Colors.white))
                              : Text(sharedPref.getString(FIRST_NAME).validate(), style: boldTextStyle(color: Colors.white)),
                          SizedBox(height: 4),
                          Text(appStore.userEmail, style: secondaryTextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              DrawerWidget(
                  title: language.myProfile,
                  iconData: 'images/ic_my_profile.png',
                  onTap: () {
                    Navigator.pop(context);
                    launchScreen(context, EditProfileScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                  }),
              DrawerWidget(
                  title: language.myRides,
                  iconData: 'images/ic_my_rides.png',
                  onTap: () {
                    Navigator.pop(context);
                    launchScreen(context, MyRidesScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                  }),
              DrawerWidget(
                  title: language.myWallet,
                  iconData: 'images/my_wallet.png',
                  onTap: () {
                    Navigator.pop(context);
                    launchScreen(context, MyWalletScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                  }),
              DrawerWidget(
                  title: language.emergencyContacts,
                  iconData: 'images/ic_emergency_contact.png',
                  onTap: () {
                    Navigator.pop(context);
                    launchScreen(context, EmergencyContactScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                  }),
              DrawerWidget(
                  title: language.setting,
                  iconData: 'images/ic_setting.png',
                  onTap: () {
                    launchScreen(context, SettingScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                  }),
              SizedBox(height: 16),
              Center(
                child: AppButtonWidget(
                  text: language.logOut,
                  textStyle: boldTextStyle(color: primaryColor),
                  onTap: () async {
                    await showConfirmDialogCustom(_scaffoldKey.currentState!.context,
                        primaryColor: primaryColor,
                        dialogType: DialogType.CONFIRMATION,
                        title: language.areYouSureYouWantToLogoutThisApp,
                        positiveText: language.yes,
                        negativeText: language.no, onAccept: (v) async {
                      await Future.delayed(Duration(milliseconds: 500));
                      await logout(data: _scaffoldKey.currentState!.context);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                launchScreen(context, NotificationScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
              },
              icon: Icon(Icons.notifications_active_outlined),
            ),
          ),
        ],
      ),
      body: sourceLocation != null
          ? Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  markers: markers,
                  polylines: _polyLines,
                  initialCameraPosition: CameraPosition(
                    target: sourceLocation!,
                    zoom: cameraZoom,
                    tilt: cameraTilt,
                    bearing: cameraBearing,
                  ),
                ),
                SlidingUpPanel(
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
                  backdropColor: primaryColor,
                  backdropTapClosesPanel: true,
                  minHeight: 150,
                  maxHeight: 150,
                  panel: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 16),
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(defaultRadius)),
                        ),
                      ),
                      Text(language.whatWouldYouLikeToGo, style: primaryTextStyle()),
                      SizedBox(height: 16),
                      AppTextField(
                        autoFocus: false,
                        readOnly: true,
                        onTap: () async {
                          if (await checkPermission()) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
                              ),
                              context: context,
                              builder: (_) {
                                return RiderWidget(title: sourceLocationTitle);
                              },
                            );
                          }
                        },
                        textFieldType: TextFieldType.EMAIL,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                          hintText: language.enterYourDestination,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            )
          : loaderWidget(),
    );
  }
}
