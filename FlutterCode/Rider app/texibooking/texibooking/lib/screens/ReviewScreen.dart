import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:taxibooking/screens/OrderDetailScreen.dart';
import 'package:taxibooking/utils/Colors.dart';
import 'package:taxibooking/utils/Common.dart';
import 'package:taxibooking/utils/Constants.dart';
import 'package:taxibooking/utils/Extensions/AppButtonWidget.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';
import 'package:taxibooking/utils/Extensions/app_common.dart';
import 'package:taxibooking/utils/Extensions/app_textfield.dart';

import '../main.dart';
import '../model/CurrentRequestModel.dart';
import '../network/RestApis.dart';
import 'RiderDashBoardScreen.dart';

class ReviewScreen extends StatefulWidget {
  final Driver? driverData;
  final OnRideRequest rideRequest;

  ReviewScreen({this.driverData, required this.rideRequest});

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();
  TextEditingController tipController = TextEditingController();

  num rattingData = 0;
  int currentIndex = -1;
  bool isMoreTip = false;
  bool isTipShow = true;

  OnRideRequest? servicesListData;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    mqttForUser();
    appStore.walletPresetTipAmount.isNotEmpty ? appStore.setWalletTipAmount(appStore.walletPresetTipAmount) : appStore.setWalletTipAmount('10|20|50');
  }

  Future<void> getCurrentRequest() async {
    await getCurrentRideRequest().then((value) {
      servicesListData = value.onRideRequest;
      if (servicesListData != null) {
        launchScreen(context, OrderDetailScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
      } else {
        launchScreen(context, RiderDashBoardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  Future<void> userReviewData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appStore.setLoading(true);
      Map req = {
        "ride_request_id": widget.rideRequest.id,
        "rating": rattingData,
        "comment": reviewController.text.trim(),
        if (tipController.text.isNotEmpty) "tips": tipController.text,
      };
      await ratingReview(request: req).then((value) {
        appStore.setLoading(false);
        getCurrentRequest();
      }).catchError((error) {
        appStore.setLoading(false);
        log(error.toString());
      });
    }
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

      if (jsonDecode(pt)['success_type'] == 'payment_status_message') {
        isTipShow = false;
        setState(() {});
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
        centerTitle: true,
        title: Text(language.howWasYourRide, style: boldTextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: commonCachedNetworkImage(widget.driverData!.profileImage.validate(), height: 70, width: 70),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.driverData!.firstName.validate()} ${widget.driverData!.lastName.validate()}', style: boldTextStyle()),
                          SizedBox(height: 4),
                          Text('${widget.driverData!.email.validate()}', style: primaryTextStyle()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    glow: false,
                    allowHalfRating: false,
                    wrapAlignment: WrapAlignment.spaceBetween,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      rattingData = rating;
                    },
                  ),
                  SizedBox(height: 32),
                  if (widget.rideRequest.paymentStatus != PAID && isTipShow)
                    Row(
                      children: [
                        Text(language.wouldYouLikeToAddTip, style: primaryTextStyle()),
                        SizedBox(width: 32),
                        if (tipController.text.isNotEmpty)
                          inkWellWidget(
                            onTap: () {
                              currentIndex = -1;
                              tipController.clear();

                              setState(() {});
                            },
                            child: Icon(Icons.clear_all, size: 30),
                          )
                      ],
                    ),
                  if (widget.rideRequest.paymentStatus != PAID && isTipShow) SizedBox(height: 16),
                  if (widget.rideRequest.paymentStatus != PAID && isTipShow)
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: appStore.walletPresetTipAmount.split('|').map((e) {
                        return inkWellWidget(
                          onTap: () {
                            currentIndex = appStore.walletPresetTipAmount.split('|').indexOf(e);
                            tipController.text = e;
                            tipController.selection = TextSelection.fromPosition(TextPosition(offset: e.toString().length));
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: currentIndex == appStore.walletPresetTipAmount.split('|').indexOf(e) ? primaryColor : primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(defaultRadius)),
                            child: Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} $e' : '$e ${appStore.currencyCode}', style: primaryTextStyle(color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ),
                  if (widget.rideRequest.paymentStatus != PAID && isTipShow) SizedBox(height: 16),
                  if (widget.rideRequest.paymentStatus != PAID && isTipShow)
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Visibility(
                          visible: isMoreTip,
                          child: AppTextField(
                            textFieldType: tipController.text.isNotEmpty ? TextFieldType.PHONE : TextFieldType.OTHER,
                            controller: tipController,
                            decoration: inputDecoration(context, label: language.addMoreTip),
                          ),
                        ),
                        if (!isMoreTip)
                          AppButtonWidget(
                            text: language.addMore,
                            textStyle: boldTextStyle(color: Colors.white),
                            color: primaryColor,
                            onTap: () {
                              isMoreTip = true;
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                  SizedBox(height: 32),
                  Text(language.addComments, style: boldTextStyle(color: primaryColor)),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.2),
                      focusColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      hintText: language.writeYourComments,
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
                    ),
                    textFieldType: TextFieldType.NAME,
                    minLines: 2,
                    maxLines: 5,
                  ),
                  SizedBox(height: 16),
                  AppButtonWidget(
                    text: language.continueD,
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    textStyle: boldTextStyle(color: Colors.white),
                    onTap: () {
                      userReviewData();
                    },
                  )
                ],
              ),
            ),
          ),
          Observer(builder: (context) {
            return Visibility(
              visible: appStore.isLoading,
              child: loaderWidget(),
            );
          })
        ],
      ),
    );
  }
}
