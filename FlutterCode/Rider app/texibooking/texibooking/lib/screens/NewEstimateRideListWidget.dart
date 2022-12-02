import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxibooking/screens/ReviewScreen.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../../components/CouPonWidget.dart';
import '../../components/RideAcceptWidget.dart';
import '../../main.dart';
import '../../network/RestApis.dart';
import '../../utils/Colors.dart';
import '../../utils/Common.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/AppButtonWidget.dart';
import '../../utils/Extensions/app_common.dart';
import '../../utils/Extensions/app_textfield.dart';
import '../components/BookingWidget.dart';
import '../components/CarDetailWidget.dart';
import '../model/CurrentRequestModel.dart';
import '../model/EstimatePriceModel.dart';
import 'RiderDashBoardScreen.dart';

class NewEstimateRideListWidget extends StatefulWidget {
  final LatLng sourceLatLog;
  final LatLng destinationLatLog;
  final String sourceTitle;
  final String destinationTitle;
  bool isCurrentRequest;
  final int? servicesId;
  final int? id;

  NewEstimateRideListWidget({
    required this.sourceLatLog,
    required this.destinationLatLog,
    required this.sourceTitle,
    required this.destinationTitle,
    this.isCurrentRequest = false,
    this.servicesId,
    this.id,
  });

  @override
  NewEstimateRideListWidgetState createState() => NewEstimateRideListWidgetState();
}

class NewEstimateRideListWidgetState extends State<NewEstimateRideListWidget> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = {};
  Set<Polyline> _polyLines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  late Marker sourceMarker;
  late Marker destinationMarker;

  late LatLng userLatLong;

  TextEditingController promoCode = TextEditingController();
  bool isBooking = false;
  late DateTime scheduleData;
  List<ServicesListData> serviceList = [];

  int selectedIndex = 0;
  int rideRequestId = 0;

  List<String> cashList = ['cash', 'wallet'];
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  String paymentMethodType = '';

  ServicesListData? servicesListData;
  OnRideRequest? rideRequest;
  Driver? driverData;
  DateTime willPopScope = DateTime.now();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'images/ic_source_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'images/ic_des_pin.png');
    getServiceList();
    getCurrentRequest();
    mqttForUser();
    if (!widget.isCurrentRequest) getNewService();
    isBooking = widget.isCurrentRequest;
  }

  Future<void> getCurrentRequest() async {
    await getCurrentRideRequest().then((value) {
      rideRequest = value.rideRequest ?? value.onRideRequest;
      driverData = value.driver!;
      if (rideRequest != null) {
        setState(() {});
      }
      if (rideRequest!.status == COMPLETED && rideRequest != null && driverData != null) {
        launchScreen(context, ReviewScreen(rideRequest: rideRequest!, driverData: driverData), pageRouteAnimation: PageRouteAnimation.SlideBottomTop, isNewTask: true);
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> getServiceList() async {
    polylinePoints = PolylinePoints();
    setPolyLines(
      sourceLocation: LatLng(widget.sourceLatLog.latitude, widget.sourceLatLog.longitude),
      destinationLocation: LatLng(widget.destinationLatLog.latitude, widget.destinationLatLog.longitude),
    );
    MarkerId id = MarkerId('Source');
    markers.add(
      Marker(
        markerId: id,
        position: LatLng(widget.sourceLatLog.latitude, widget.sourceLatLog.longitude),
        icon: sourceIcon,
      ),
    );
    MarkerId id1 = MarkerId('Destination');
    markers.add(
      Marker(
        markerId: id1,
        position: LatLng(widget.destinationLatLog.latitude, widget.destinationLatLog.longitude),
        icon: destinationIcon,
      ),
    );
    setState(() {});
  }

  Future<void> getNewService({bool coupon = false}) async {
    appStore.setLoading(true);
    Map req = {
      "pick_lat": widget.sourceLatLog.latitude,
      "pick_lng": widget.sourceLatLog.longitude,
      "drop_lat": widget.destinationLatLog.latitude,
      "drop_lng": widget.destinationLatLog.longitude,
      if (coupon) "coupon_code": promoCode.text.trim(),
    };
    await estimatePriceList(req).then((value) {
      appStore.setLoading(false);
      serviceList.clear();

      serviceList.addAll(value.data!);
      if (serviceList.isNotEmpty) servicesListData = serviceList[0];
      if (serviceList.isNotEmpty) paymentMethodType = serviceList[0].paymentMethod!;
      if (serviceList.isNotEmpty) cashList = paymentMethodType == 'cash_wallet' ? cashList = ['cash', 'wallet'] : cashList = [paymentMethodType];

      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  Future<void> getCouponNewService() async {
    appStore.setLoading(true);
    Map req = {
      "pick_lat": widget.sourceLatLog.latitude,
      "pick_lng": widget.sourceLatLog.longitude,
      "drop_lat": widget.destinationLatLog.latitude,
      "drop_lng": widget.destinationLatLog.longitude,
      "coupon_code": promoCode.text.trim(),
    };
    await estimatePriceList(req).then((value) {
      appStore.setLoading(false);
      serviceList.clear();
      serviceList.addAll(value.data!);
      if (serviceList.isNotEmpty) servicesListData = serviceList[selectedIndex];
      if (serviceList.isNotEmpty) cashList = paymentMethodType == 'cash_wallet' ? cashList = ['cash', 'wallet'] : cashList = [paymentMethodType];
      setState(() {});
      Navigator.pop(context);
    }).catchError((error) {
      promoCode.clear();
      Navigator.pop(context);

      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  Future<void> setPolyLines({required LatLng sourceLocation, required LatLng destinationLocation}) async {
    _polyLines.clear();
    polylineCoordinates.clear();
    var result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapAPIKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });
      _polyLines.add(Polyline(
        visible: true,
        width: 5,
        polylineId: PolylineId('poly'),
        color: Color.fromARGB(255, 40, 122, 198),
        points: polylineCoordinates,
      ));
      setState(() {});
    }
  }

  onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> saveBookingData() async {
    appStore.setLoading(true);
    Map req = {
      "rider_id": sharedPref.getInt(USER_ID).toString(),
      "service_id": servicesListData!.id.toString(),
      "datetime": DateTime.now().toString(),
      "start_latitude": widget.sourceLatLog.latitude.toString(),
      "start_longitude": widget.sourceLatLog.longitude.toString(),
      "start_address": widget.sourceTitle,
      "end_latitude": widget.destinationLatLog.latitude.toString(),
      "end_longitude": widget.destinationLatLog.longitude.toString(),
      "end_address": widget.destinationTitle,
      "seat_count": servicesListData!.capacity.toString(),
      "status": NEW_RIDE_REQUESTED,
      "payment_type": paymentMethodType = paymentMethodType == 'cash_wallet' ? 'cash' : paymentMethodType,
      if (promoCode.text.isNotEmpty) "coupon_code": promoCode.text,
      "is_schedule": 0,
    };

    log('$req');
    await saveRideRequest(req).then((value) async {
      rideRequestId = value.rideRequestId!;
      widget.isCurrentRequest = true;
      isBooking = true;
      appStore.setLoading(false);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  mqttForUser() async {
    client.setProtocolV311();
    client.logging(on: true);
    client.keepAlivePeriod = 120;
    client.autoReconnect = true;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      debugPrint(e.toString());
      client.connect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.onSubscribed = onSubscribed;

      debugPrint('connected');
    } else {
      client.connect();
    }

    void onconnected() {
      debugPrint('connected');
    }

    client.subscribe('ride_request_status_' + sharedPref.getInt(USER_ID).toString(), MqttQos.atLeastOnce);

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (jsonDecode(pt)['success_type'] == ACCEPTED || jsonDecode(pt)['success_type'] == ARRIVING || jsonDecode(pt)['success_type'] == ARRIVED || jsonDecode(pt)['success_type'] == IN_PROGRESS) {
        isBooking = true;
        getCurrentRequest();
      } else if (jsonDecode(pt)['success_type'] == CANCELED) {
        launchScreen(context, RiderDashBoardScreen(), isNewTask: true);
      } else if (jsonDecode(pt)['success_type'] == COMPLETED) {
        getCurrentRequest();
      }
    });

    client.onConnected = onconnected;
  }

  void onConnected() {
    log('Connected');
  }

  void onSubscribed(String topic) {
    log('Subscription confirmed for topic $topic');
  }

  @override
  void dispose() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      polylineSource = LatLng(value.latitude, value.longitude);
    });
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 50,
        leading: inkWellWidget(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
            child: Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(target: widget.sourceLatLog, zoom: 11.0),
            markers: markers,
            mapType: MapType.normal,
            polylines: _polyLines,
          ),
          !isBooking
              ? SlidingUpPanel(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
                  color: Theme.of(context).cardColor,
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  body: null,
                  panel: Stack(
                    children: [
                      Visibility(
                        visible: serviceList.isNotEmpty,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 16, top: 16),
                                  height: 5,
                                  width: 70,
                                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(defaultRadius)),
                                ),
                              ),
                              SingleChildScrollView(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: serviceList.map((e) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedIndex = serviceList.indexOf(e);
                                        servicesListData = e;
                                        paymentMethodType = e.paymentMethod!;
                                        cashList = paymentMethodType == 'cash_wallet' ? cashList = ['cash', 'wallet'] : cashList = [paymentMethodType];
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        margin: EdgeInsets.only(top: 16, left: 8, right: 8),
                                        decoration: BoxDecoration(
                                          color: selectedIndex == serviceList.indexOf(e) ? primaryColor : Colors.white,
                                          border: Border.all(color: primaryColor.withOpacity(0.5)),
                                          borderRadius: BorderRadius.circular(defaultRadius),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            commonCachedNetworkImage(e.serviceImage.validate(), height: 50, width: 100, fit: BoxFit.cover, alignment: Alignment.center),
                                            SizedBox(height: 8),
                                            Text(e.name.validate(), style: boldTextStyle(color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor)),
                                            Divider(color: Colors.grey, height: 8),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(language.capacity, style: secondaryTextStyle(color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor)),
                                                SizedBox(width: 8),
                                                Text(e.capacity.toString(), style: primaryTextStyle(color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor)),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  appStore.currencyPosition == LEFT
                                                      ? '${appStore.currencyCode} ${e.totalAmount!.toStringAsFixed(fixedDecimal)}'
                                                      : '${e.totalAmount!.toStringAsFixed(fixedDecimal)} ${appStore.currencyCode}',
                                                  style: boldTextStyle(
                                                    color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor,
                                                    textDecoration: e.discountAmount != 0 ? TextDecoration.lineThrough : null,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                inkWellWidget(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      backgroundColor: primaryColor,
                                                      context: context,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(defaultRadius), topLeft: Radius.circular(defaultRadius))),
                                                      builder: (_) {
                                                        return CarDetailWidget(service: e);
                                                      },
                                                    );
                                                  },
                                                  child: Icon(Icons.info_outline_rounded, size: 20, color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor),
                                                ),
                                              ],
                                            ),
                                            if (e.discountAmount != 0) SizedBox(height: 8),
                                            if (e.discountAmount != 0)
                                              Text(
                                                '\$ ${e.subtotal!.toStringAsFixed(fixedDecimal)}',
                                                style: boldTextStyle(
                                                  color: selectedIndex == serviceList.indexOf(e) ? Colors.white : primaryColor,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 8),
                              inkWellWidget(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                        return Observer(builder: (context) {
                                          return Stack(
                                            children: [
                                              AlertDialog(
                                                contentPadding: EdgeInsets.all(16),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(language.paymentMethod, style: boldTextStyle()),
                                                        inkWellWidget(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.all(8),
                                                            decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
                                                            child: Icon(Icons.close, color: Colors.white, size: 20),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(language.chooseYouPaymentLate, style: secondaryTextStyle()),
                                                    SizedBox(height: 16),
                                                    Wrap(
                                                      children: cashList.map((e) {
                                                        return RadioListTile(
                                                          contentPadding: EdgeInsets.zero,
                                                          controlAffinity: ListTileControlAffinity.trailing,
                                                          activeColor: primaryColor,
                                                          value: e,
                                                          groupValue: paymentMethodType == 'cash_wallet' ? 'cash' : paymentMethodType,
                                                          title: Text(e, style: boldTextStyle()),
                                                          onChanged: (String? val) {
                                                            paymentMethodType = val!;
                                                            setState(() {});
                                                          },
                                                        );
                                                      }).toList(),
                                                    ),
                                                    SizedBox(height: 16),
                                                    AppTextField(
                                                      controller: promoCode,
                                                      autoFocus: false,
                                                      textFieldType: TextFieldType.EMAIL,
                                                      keyboardType: TextInputType.emailAddress,
                                                      errorThisFieldRequired: language.thisFieldRequired,
                                                      readOnly: true,
                                                      onTap: () async {
                                                        var data = await showModalBottomSheet(
                                                          context: context,
                                                          builder: (_) {
                                                            return CouPonWidget();
                                                          },
                                                        );
                                                        if (data != null) {
                                                          promoCode.text = data;
                                                        }
                                                      },
                                                      decoration: inputDecoration(context,
                                                          label: language.enterPromoCode,
                                                          suffixIcon: promoCode.text.isNotEmpty
                                                              ? inkWellWidget(
                                                                  onTap: () {
                                                                    promoCode.clear();
                                                                    getNewService(coupon: false);
                                                                  },
                                                                  child: Icon(Icons.close, color: Colors.black, size: 25),
                                                                )
                                                              : null),
                                                    ),
                                                    SizedBox(height: 16),
                                                    AppButtonWidget(
                                                      width: MediaQuery.of(context).size.width,
                                                      text: language.confirm,
                                                      textStyle: boldTextStyle(color: Colors.white),
                                                      color: primaryColor,
                                                      onTap: () {
                                                        if (promoCode.text.isNotEmpty) {
                                                          getCouponNewService();
                                                          //getNewService(coupon: true);
                                                        } else {
                                                          // getNewService();
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: appStore.isLoading,
                                                child: Observer(builder: (context) {
                                                  return loaderWidget();
                                                }),
                                              )
                                            ],
                                          );
                                        });
                                      });
                                    },
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(16),
                                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(defaultRadius)),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(language.paymentVia, style: secondaryTextStyle()),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(defaultRadius)),
                                                child: Icon(Icons.wallet_outlined, size: 20, color: Colors.white),
                                              ),
                                              SizedBox(width: 16),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(paymentMethodType == 'cash_wallet' ? 'cash' : paymentMethodType, style: boldTextStyle()),
                                                  SizedBox(height: 4),
                                                  Text(language.forInstantPayment, style: secondaryTextStyle(size: 12)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: AppButtonWidget(
                                        color: primaryColor,
                                        onTap: () {
                                          saveBookingData();
                                        },
                                        text: language.bookNow,
                                        textStyle: boldTextStyle(color: Colors.white),
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: appStore.isLoading,
                        child: Observer(builder: (context) {
                          return loaderWidget();
                        }),
                      ),
                      if (!appStore.isLoading && serviceList.isEmpty) emptyWidget()
                    ],
                  ),
                )
              : SlidingUpPanel(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
                  color: Theme.of(context).cardColor,
                  minHeight: MediaQuery.of(context).size.height * 0.4,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  body: null,
                  panel: rideRequest != null
                      ? rideRequest!.status == NEW_RIDE_REQUESTED
                          ? BookingWidget(id: widget.id)
                          : RideAcceptWidget(rideRequest: rideRequest, driverData: driverData)
                      : BookingWidget(id: rideRequestId == 0 ? widget.id : rideRequestId, isLast: true),
                ),
        ],
      ),
    );
  }
}
