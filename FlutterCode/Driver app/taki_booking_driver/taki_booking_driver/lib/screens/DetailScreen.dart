import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:taxi_driver/main.dart';
import 'package:taxi_driver/screens/DriverDashboardScreen.dart';
import 'package:taxi_driver/utils/Colors.dart';
import 'package:taxi_driver/utils/Constants.dart';
import 'package:taxi_driver/utils/Extensions/AppButtonWidget.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import 'package:taxi_driver/utils/Extensions/app_common.dart';

import '../model/CurrentRequestModel.dart';
import '../model/RideHistory.dart';
import '../model/RiderModel.dart';
import '../network/RestApis.dart';
import '../utils/Common.dart';
import '../utils/Extensions/ConformationDialog.dart';
import 'RideHistoryScreen.dart';

class DetailScreen extends StatefulWidget {
  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  CurrentRequestModel? currentData;
  RiderModel? riderModel;
  Payment? payment;
  List<RideHistory> rideHistory = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    currentRideRequest();
    mqttForUser();
  }

  Future<void> currentRideRequest() async {
    appStore.setLoading(true);
    await getCurrentRideRequest().then((value) async {
      appStore.setLoading(false);
      currentData = value;
      await orderDetailApi();
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  Future<void> savePaymentApi() async {
    appStore.setLoading(true);
    Map req = {
      "id": currentData!.payment!.id,
      "rider_id": currentData!.payment!.riderId,
      "ride_request_id": currentData!.payment!.rideRequestId,
      "datetime": DateTime.now().toString(),
      "total_amount": currentData!.payment!.totalAmount,
      "payment_type": currentData!.payment!.paymentType,
      "txn_id": "",
      "payment_status": "paid",
      "transaction_detail": ""
    };
    log(req);
    await savePayment(req).then((value) {
      appStore.setLoading(false);
      launchScreen(context, DriverDashboardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  Future<void> orderDetailApi() async {
    appStore.setLoading(true);
    await rideDetail(orderId: currentData!.payment!.rideRequestId).then((value) {
      appStore.setLoading(false);

      riderModel = value.data;
      payment = value.payment!;
      rideHistory = value.rideHistory!;
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);

      log('${error.toString()}');
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

      log('connected');
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

      if (jsonDecode(pt)['success_type'] == 'rating') {
        currentRideRequest();
      } else if (jsonDecode(pt)['success_type'] == 'change_payment_type') {
        currentRideRequest();
      } else if (jsonDecode(pt)['success_type'] == 'payment_status_message') {
        launchScreen(context, DriverDashboardScreen(), isNewTask: true);
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
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.detailScreen, style: boldTextStyle(color: Colors.white)),
      ),
      body: currentData != null && riderModel != null
          ? SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(language.orderId, style: boldTextStyle(size: 20)),
                      Text('#${riderModel!.id}', style: boldTextStyle(size: 20)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('${language.createdAt}: ${printDate(riderModel!.createdAt.validate())}', style: secondaryTextStyle()),
                  Divider(height: 30, thickness: 1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.near_me, color: Colors.green),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(riderModel!.startAddress.validate(), style: primaryTextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined, size: 20, color: Colors.red),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(riderModel!.endAddress.validate(), style: primaryTextStyle()),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      AppButtonWidget(
                        elevation: 0,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(6),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          side: BorderSide(color: primaryColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(language.viewHistory, style: primaryTextStyle(color: primaryColor)),
                            Icon(Icons.arrow_right, color: primaryColor),
                          ],
                        ),
                        onTap: () {
                          launchScreen(context, RideHistoryScreen(rideHistory: rideHistory), pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                        },
                      ),
                    ],
                  ),
                  Divider(height: 30, thickness: 1),
                  Text(language.paymentDetails, style: boldTextStyle(size: 16)),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(color: appStore.isDarkMode ? scaffoldSecondaryDark : primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language.paymentType, style: primaryTextStyle()),
                            Text(riderModel!.paymentType.validate(), style: primaryTextStyle()),
                          ],
                        ),
                        Divider(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language.paymentStatus, style: primaryTextStyle()),
                            Text(riderModel!.paymentStatus.validate(), style: primaryTextStyle()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(language.priceDetail, style: boldTextStyle(size: 16)),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(color: appStore.isDarkMode ? scaffoldSecondaryDark : primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        if (riderModel!.perDistanceCharge != null) totalCount(title: language.basePrice, description: '', subTitle: '${riderModel!.baseFare}'),
                        SizedBox(height: 16),
                        if (riderModel!.perDistanceCharge != null) totalCount(title: language.distancePrice, description: '', subTitle: riderModel!.perDistanceCharge.toString()),
                        SizedBox(height: 16),
                        if (riderModel!.perMinuteDriveCharge != null) totalCount(title: language.duration, description: '', subTitle: '${riderModel!.perMinuteDriveCharge}'),
                        SizedBox(height: 16),
                        if (riderModel!.perDistanceCharge != null) totalCount(title: language.timePrice, description: '', subTitle: '${riderModel!.perDistanceCharge}'),
                        SizedBox(height: 16),
                        totalCount(title: language.waitTime, description: '', subTitle: '${riderModel!.perMinuteWaitingCharge}'),
                        SizedBox(height: 16),
                        if (payment != null) totalCount(title: language.tip, description: '', subTitle: payment!.driverTips.toString()),
                        if (payment != null) SizedBox(height: 16),
                        if (riderModel!.extraCharges!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(language.extraCharges, style: boldTextStyle()),
                              SizedBox(height: 8),
                              ...riderModel!.extraCharges!.map((e) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.key.validate().capitalizeFirstLetter(), style: primaryTextStyle()),
                                      Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} ${e.value}' : '${e.value} ${appStore.currencyCode}', style: primaryTextStyle()),
                                    ],
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        if (riderModel!.couponData != null && riderModel!.couponDiscount != 0) SizedBox(height: 16),
                        if (riderModel!.couponData != null && riderModel!.couponDiscount != 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(language.couponDiscount, style: primaryTextStyle(color: Colors.red)),
                              Text(
                                  appStore.currencyPosition == LEFT
                                      ? '-${appStore.currencyCode} ${riderModel!.couponDiscount.toString()}'
                                      : '-${riderModel!.couponDiscount.toString()} ${appStore.currencyCode}',
                                  style: primaryTextStyle(color: Colors.green)),
                            ],
                          ),
                        Divider(height: 30, thickness: 1),
                        totalCount(title: language.total, description: '', subTitle: '${riderModel!.subtotal}'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Observer(builder: (context) {
              return Visibility(
                visible: appStore.isLoading,
                child: loaderWidget(),
              );
            }),
      bottomNavigationBar: currentData != null
          ? Padding(
              padding: EdgeInsets.all(16),
              child: currentData!.payment!.paymentType == CASH
                  ? AppButtonWidget(
                      text: language.cashCollected,
                      textStyle: boldTextStyle(color: Colors.white),
                      color: primaryColor,
                      onTap: () {
                        showConfirmDialogCustom(
                            primaryColor: primaryColor,
                            positiveText: language.yes,
                            negativeText: language.no,
                            dialogType: DialogType.CONFIRMATION,
                            title: language.areYouSureCollectThisPayment,
                            context, onAccept: (v) {
                          savePaymentApi();
                        });
                      },
                    )
                  : AppButtonWidget(
                      text: language.waitingForDriverConformation,
                      textStyle: boldTextStyle(color: Colors.white, size: 12),
                      color: primaryColor,
                      onTap: () {
                        if (currentData!.payment!.paymentStatus == COMPLETED) {
                          launchScreen(context, DriverDashboardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                        } else {
                          //currentRideRequest();
                          toast(language.waitingForDriverConformation);
                        }
                      },
                    ),
            )
          : SizedBox(),
    );
  }

  Widget chargesWidget({String? name, String? amount}) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name!, style: primaryTextStyle()),
          Text(amount!, style: primaryTextStyle()),
        ],
      ),
    );
  }
}
