import 'package:flutter/material.dart';

import '../main.dart';
import '../model/WalkThroughModel.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import 'LoginScreen.dart';

class WalkThroughtScreen extends StatefulWidget {
  @override
  WalkThroughtScreenState createState() => WalkThroughtScreenState();
}

class WalkThroughtScreenState extends State<WalkThroughtScreen> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  List<WalkThroughModel> walkThroughClass = [
    WalkThroughModel(
      name: 'Search your Ride',
      text: "Request a ride get picked up by\na nearby community driver",
      img: 'images/ic_walk1.jpg',
    ),
    WalkThroughModel(
      name: 'Select your Ride',
      text: "Request a ride get picked up by\na nearby community driver",
      img: 'images/ic_walk2.jpg',
    ),
    WalkThroughModel(
      name: 'Track your Ride',
      text: "Know your Service and be able to view\ncurrent location in real time on themap",
      img: 'images/ic_walk3.jpg',
    )
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: walkThroughClass.length,
            controller: pageController,
            itemBuilder: (context, i) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    walkThroughClass[i].img.toString(),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  Positioned(
                    bottom: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(walkThroughClass[i].name!, style: boldTextStyle(size: 30, color: Colors.white), textAlign: TextAlign.center),
                        SizedBox(height: 16),
                        Text(walkThroughClass[i].text.toString(), style: secondaryTextStyle(size: 14, color: Colors.white), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              );
            },
            onPageChanged: (int i) {
              currentPage = i;
              setState(() {});
            },
          ),
          Positioned(
            bottom: 20,
            right: 16,
            left: 16,
            child: Column(
              children: [
                dotIndicator(walkThroughClass, currentPage),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (currentPage.toInt() >= 2) {
                      launchScreen(context, LoginScreen(), isNewTask: true);
                      sharedPref.setBool(IS_FIRST_TIME, false);
                    } else {
                      pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.linearToEaseOut);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: TextButton(
              onPressed: () {
                launchScreen(context, LoginScreen(), isNewTask: true);
                sharedPref.setBool(IS_FIRST_TIME, false);
              },
              child: Text('Skip', style: boldTextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
