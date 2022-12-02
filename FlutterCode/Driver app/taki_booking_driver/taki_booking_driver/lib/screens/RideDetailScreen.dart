import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taxi_driver/model/ComplaintModel.dart';
import 'package:taxi_driver/model/DriverRatting.dart';
import 'package:taxi_driver/model/RideHistory.dart';
import 'package:taxi_driver/network/RestApis.dart';
import 'package:taxi_driver/screens/RideHistoryScreen.dart';
import 'package:taxi_driver/utils/Colors.dart';
import 'package:taxi_driver/utils/Common.dart';
import 'package:taxi_driver/utils/Extensions/AppButtonWidget.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import 'package:taxi_driver/utils/Extensions/app_common.dart';

import '../main.dart';
import '../model/CurrentRequestModel.dart';
import '../model/RiderModel.dart';
import '../utils/Constants.dart';
import 'ComplaintScreen.dart';

class RideDetailScreen extends StatefulWidget {
  final int orderId;

  RideDetailScreen({required this.orderId});

  @override
  RideDetailScreenState createState() => RideDetailScreenState();
}

class RideDetailScreenState extends State<RideDetailScreen> {
  RiderModel? riderModel;
  List<RideHistory> rideHistory = [];
  DriverRatting? riderRatting;
  ComplaintModel? complaintData;
  Payment? payment;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    appStore.setLoading(true);
    await rideDetail(orderId: widget.orderId).then((value) {
      appStore.setLoading(false);

      riderModel = value.data;
      rideHistory.addAll(value.rideHistory!);
      riderRatting = value.riderRatting;
      complaintData = value.complaintModel;
      if (value.payment != null) payment = value.payment;
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);

      log('error:${error.toString()}');
    });
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
      body: Stack(
        children: [
          if (riderModel != null)
            SingleChildScrollView(
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
                      AppButtonWidget(
                        elevation: 0,
                        color: Colors.transparent,
                        padding: EdgeInsets.all(8),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          side: BorderSide(color: primaryColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(language.complain, style: primaryTextStyle(color: primaryColor)),
                          ],
                        ),
                        onTap: () {
                          launchScreen(
                            context,
                            ComplaintScreen(
                              driverRatting: riderRatting ?? DriverRatting(),
                              complaintModel: complaintData,
                              riderModel: riderModel,
                            ),
                            pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                          );
                        },
                      ),
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
                            Text(paymentStatus(riderModel!.paymentType.validate()), style: primaryTextStyle()),
                          ],
                        ),
                        Divider(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language.paymentStatus, style: primaryTextStyle()),
                            Text(paymentStatus(riderModel!.paymentStatus.validate()), style: primaryTextStyle()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text('About Rider', style: boldTextStyle(size: 16)),
                  SizedBox(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: appStore.isDarkMode ? scaffoldSecondaryDark : primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: commonCachedNetworkImage(riderModel!.driverProfileImage.validate(), height: 70, width: 70, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(riderModel!.riderName.validate(), style: boldTextStyle()),
                                SizedBox(height: 8),
                                if (riderRatting != null)
                                  RatingBar.builder(
                                    direction: Axis.horizontal,
                                    glow: false,
                                    allowHalfRating: false,
                                    ignoreGestures: true,
                                    wrapAlignment: WrapAlignment.spaceBetween,
                                    itemCount: 5,
                                    itemSize: 20,
                                    initialRating: double.parse(riderRatting!.rating.toString()),
                                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (rating) {
                                      //
                                    },
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(language.priceDetail, style: boldTextStyle(size: 16)),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(color: appStore.isDarkMode ? scaffoldSecondaryDark : primaryColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        totalCount(title: language.basePrice, description: '', subTitle: '${riderModel!.baseFare}'),
                        SizedBox(height: 16),
                        totalCount(title: language.distancePrice, description: '', subTitle: riderModel!.perDistanceCharge.toString()),
                        SizedBox(height: 16),
                        totalCount(title: language.duration, description: '', subTitle: '${riderModel!.perMinuteDriveCharge}'),
                        SizedBox(height: 16),
                        totalCount(title: language.timePrice, description: '', subTitle: '${riderModel!.perDistanceCharge}'),
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
                        payment!.driverTips != 0
                            ? totalCount(title: language.total, description: '', subTitle: '${riderModel!.subtotal! + payment!.driverTips!}')
                            : totalCount(title: language.total, description: '', subTitle: '${riderModel!.subtotal}'),
                      ],
                    ),
                  ),
                ],
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
