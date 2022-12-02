import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:taxi_driver/model/RiderModel.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../network/RestApis.dart';
import '../screens/RideDetailScreen.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';

class CreateTabScreen extends StatefulWidget {
  final String? status;

  CreateTabScreen({this.status});

  @override
  CreateTabScreenState createState() => CreateTabScreenState();
}

class CreateTabScreenState extends State<CreateTabScreen> {
  ScrollController scrollController = ScrollController();

  int currentPage = 1;
  int totalPage = 1;
  List<RiderModel> riderData = [];
  List<String> riderStatus = [COMPLETED, CANCELED];

  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (currentPage < totalPage) {
          appStore.setLoading(true);
          currentPage++;
          setState(() {});

          init();
        }
      }
    });
    afterBuildCreated(() => appStore.setLoading(true));
  }

  void init() async {
    await getRiderRequestList(page: currentPage, status: widget.status, driverId: sharedPref.getInt(USER_ID)).then((value) {
      appStore.setLoading(false);

      currentPage = value.pagination!.currentPage!;
      totalPage = value.pagination!.totalPages!;
      if (currentPage == 1) {
        riderData.clear();
      }
      riderData.addAll(value.data!);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Stack(
        children: [
          AnimationLimiter(
            child: ListView.builder(
                itemCount: riderData.length,
                controller: scrollController,
                padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                itemBuilder: (_, index) {
                  RiderModel data = riderData[index];
                  return AnimationConfiguration.staggeredList(
                    delay: Duration(milliseconds: 200),
                    position: index,
                    duration: Duration(milliseconds: 375),
                    child: SlideAnimation(
                      child: IntrinsicHeight(
                        child: inkWellWidget(
                          onTap: () {
                            if (data.status != CANCELED) {
                              launchScreen(context, RideDetailScreen(orderId: data.id!.toInt()), pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            margin: EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(defaultRadius),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5),
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.near_me,color: Colors.green),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(printDate(data.datetime!), style: secondaryTextStyle()),
                                            SizedBox(height: 4),
                                            Text(data.startAddress.validate(), style: boldTextStyle(size: 14)),
                                          ],
                                        ),
                                      ),
                                      Text('#${data.id}', style: boldTextStyle(size: 16)),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 20,color: Colors.red),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (data.endTime != null) Text(data.endTime != null ? printDate(data.endTime ?? '') : '', style: secondaryTextStyle()),
                                            if (data.endTime != null) SizedBox(height: 4),
                                            Text(data.endAddress.validate(), style: boldTextStyle(size: 14)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Visibility(
            visible: appStore.isLoading,
            child: loaderWidget(),
          ),
          if (riderData.isEmpty) appStore.isLoading ? SizedBox() : emptyWidget(),
        ],
      );
    });
  }
}
