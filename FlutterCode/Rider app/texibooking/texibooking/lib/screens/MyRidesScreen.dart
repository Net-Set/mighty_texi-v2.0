import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxibooking/utils/Colors.dart';
import 'package:taxibooking/utils/Extensions/app_common.dart';

import '../../components/CreateTabScreen.dart';
import '../../utils/Constants.dart';
import '../main.dart';
import '../utils/Common.dart';

class MyRidesScreen extends StatefulWidget {
  @override
  MyRidesScreenState createState() => MyRidesScreenState();
}

class MyRidesScreenState extends State<MyRidesScreen> {
  int currentPage = 1;
  int totalPage = 1;
  List<String> riderStatus = [COMPLETED, CANCELED];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: riderStatus.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(language.myRides, style: boldTextStyle(color: Colors.white)),
          bottom: TabBar(
              indicatorColor: primaryColor,
              unselectedLabelStyle: primaryTextStyle(),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: boldTextStyle(),
              onTap: (val) {
                log(val.toString());
              },
              tabs: riderStatus.map((e) {
                return Tab(
                  child: Text(changeStatusText(e), style: boldTextStyle(color: Colors.white)),
                );
              }).toList()),
        ),
        body: Observer(builder: (context) {
          return TabBarView(
            children: riderStatus.map((e) {
              return CreateTabScreen(status: e);
            }).toList(),
          );
        }),
      ),
    );
  }
}
