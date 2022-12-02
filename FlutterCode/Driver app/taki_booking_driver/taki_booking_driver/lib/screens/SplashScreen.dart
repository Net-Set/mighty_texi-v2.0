import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_driver/screens/DriverDashboardScreen.dart';
import 'package:taxi_driver/screens/LoginScreen.dart';

import '../main.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import 'VerifyDeliveryPersonScreen.dart';
import 'WalkThroughtScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 2));
    if (sharedPref.getBool(IS_FIRST_TIME) ?? true) {
      launchScreen(context, WalkThroughtScreen(), pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
    } else {
      if (sharedPref.getInt(IS_Verified_Driver) == 0 && appStore.isLoggedIn) {
        launchScreen(context, VerifyDeliveryPersonScreen(isShow: true), pageRouteAnimation: PageRouteAnimation.Slide,isNewTask: true);
      } else if (sharedPref.getInt(IS_Verified_Driver) == 1 && appStore.isLoggedIn) {
        launchScreen(context, DriverDashboardScreen(), pageRouteAnimation: PageRouteAnimation.SlideBottomTop, isNewTask: true);
      } else {
        launchScreen(context, LoginScreen(), pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/ic_driver_white.png', fit: BoxFit.contain, height: 150, width: 150),
            SizedBox(height: 16),
            Text(language.appName, style: boldTextStyle(color: Colors.white, size: 22)),
          ],
        ),
      ),
    );
  }
}
