import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taxibooking/utils/Extensions/AppButtonWidget.dart';
import 'package:taxibooking/utils/Extensions/ConformationDialog.dart';
import 'package:taxibooking/utils/Extensions/app_common.dart';

import '../main.dart';
import '../network/RestApis.dart';
import '../screens/RiderDashBoardScreen.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';

class BookingWidget extends StatefulWidget {
  final bool isLast;
  final int? id;

  BookingWidget({required this.id, this.isLast = false});

  @override
  BookingWidgetState createState() => BookingWidgetState();
}

class BookingWidgetState extends State<BookingWidget> {
  final int timerMaxSeconds = appStore.rideMinutes != null ? int.parse(appStore.rideMinutes!) * 60 : 5 * 60;

  int currentSeconds = 0;
  int duration = 0;
  int count = 0;
  Timer? timer;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String get timerText => '${((duration - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((duration - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (sharedPref.getString(IS_TIME) == null) {
      duration = timerMaxSeconds;
      startTimeout();
      sharedPref.setString(IS_TIME, DateTime.now().add(Duration(seconds: timerMaxSeconds)).toString());
      sharedPref.setString(REMAINING_TIME, timerMaxSeconds.toString());
    } else {
      duration = DateTime.parse(sharedPref.getString(IS_TIME)!).difference(DateTime.now()).inSeconds;
      if (duration > 0) {
        startTimeout();
      } else {
        sharedPref.remove(IS_TIME);
        duration = timerMaxSeconds;
        setState(() {});
      }
    }
  }

  startTimeout() {
    var duration2 = Duration(seconds: 1);
    timer = Timer.periodic(duration2, (timer) {
      setState(
        () {
          currentSeconds = timer.tick;
          count++;
          if (count >= 60) {
            int data = int.parse(sharedPref.getString(REMAINING_TIME)!);
            data = data - count;
            Map req = {
              'max_time_for_find_driver_for_ride_request': data,
            };
            rideRequestUpdate(request: req, rideId: widget.id).then((value) {
              //
            }).catchError((error) {
              log(error.toString());
            });
            sharedPref.setString(REMAINING_TIME, data.toString());
            count = 0;
          }
          if (timer.tick >= duration) {
            Map req = {
              'status': CANCELED,
              'cancel_by': AUTO,
            };
            rideRequestUpdate(request: req, rideId: widget.id).then((value) {
              launchScreen(context, RiderDashBoardScreen());
              timer.cancel();
              sharedPref.remove(REMAINING_TIME);
              sharedPref.remove(IS_TIME);
            }).catchError((error) {
              log(error.toString());
            });
          }
        },
      );
    });
  }

  Future<void> cancelRequest() async {
    Map req = {
      "id": widget.id,
      "cancel_by": 'rider',
      "status": CANCELED,
    };
    await rideRequestUpdate(request: req, rideId: widget.id).then((value) async {
      if (widget.isLast) {
        launchScreen(context, RiderDashBoardScreen(), isNewTask: true);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }

      toast(value.message);
    }).catchError((error) {
      log(error.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language.lookingForNearbyDrivers, style: boldTextStyle()),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(color: primaryColor),
                child: Text(timerText, style: boldTextStyle(color: Colors.white)),
              )
            ],
          ),
          SizedBox(height: 16),
          Lottie.asset('images/booking.json', height: 100, width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          SizedBox(height: 50),
          Text(language.weAreLookingForNearDriversAcceptsYourRide, style: primaryTextStyle(), textAlign: TextAlign.center),
          SizedBox(height: 20),
          AppButtonWidget(
            width: MediaQuery.of(context).size.width,
            color: primaryColor,
            text: language.cancel,
            textStyle: boldTextStyle(color: Colors.white),
            onTap: () {
              showConfirmDialogCustom(context, primaryColor: primaryColor, title: language.areYouSureYouWantToCancelThisRide, dialogType: DialogType.CONFIRMATION, onAccept: (_) {
                sharedPref.remove(REMAINING_TIME);
                sharedPref.remove(IS_TIME);
                cancelRequest();
              });
            },
          )
        ],
      ),
    );
  }
}
