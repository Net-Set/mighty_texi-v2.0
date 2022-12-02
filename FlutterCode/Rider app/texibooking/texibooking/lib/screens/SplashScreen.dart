import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxibooking/main.dart';

import '../../screens/WalkThroughtScreen.dart';
import '../../utils/Colors.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/app_common.dart';
import 'LoginScreen.dart';
import 'RiderDashBoardScreen.dart';

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
    //await determinePosition();
    await Future.delayed(Duration(seconds: 2));
    if (sharedPref.getBool(IS_FIRST_TIME) ?? true) {
      launchScreen(context, WalkThroughtScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
    } else {
      if (appStore.isLoggedIn) {
        launchScreen(context, RiderDashBoardScreen(), pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
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
            Image.asset('images/ic_logo_white.png', fit: BoxFit.contain, height: 150, width: 150),
            SizedBox(height: 16),
            Text(language.appName, style: boldTextStyle(color: Colors.white, size: 22)),
          ],
        ),
      ),
    );
  }
}

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
  } else {
    //throw Exception('Error');
  }
  return await Geolocator.getCurrentPosition();
}
