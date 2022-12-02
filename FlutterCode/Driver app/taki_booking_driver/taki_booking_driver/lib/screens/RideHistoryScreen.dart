
import 'package:flutter/material.dart';
import 'package:taxi_driver/model/RideHistory.dart';
import 'package:taxi_driver/utils/Colors.dart';
import 'package:taxi_driver/utils/Common.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import 'package:taxi_driver/utils/Extensions/app_common.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../main.dart';

class RideHistoryScreen extends StatefulWidget {
  final List<RideHistory> rideHistory;

  RideHistoryScreen({required this.rideHistory});

  @override
  RideHistoryScreenState createState() => RideHistoryScreenState();
}

class RideHistoryScreenState extends State<RideHistoryScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(language.rideHistory, style: boldTextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: widget.rideHistory.length,
        itemBuilder: (context, index) {
          RideHistory mData = widget.rideHistory[index];
          return TimelineTile(
            alignment: TimelineAlign.start,
            isFirst: index == 0 ? true : false,
            isLast: index == (widget.rideHistory.length - 1) ? true : false,
            indicatorStyle: IndicatorStyle(width: 15, color: primaryColor),
            afterLineStyle: LineStyle(color: primaryColor, thickness: 3),
            beforeLineStyle: LineStyle(color: primaryColor, thickness: 3),
            endChild: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ImageIcon(AssetImage(statusTypeIcon(type: mData.historyType)), color: primaryColor, size: 30),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${mData.historyType!.replaceAll("_", " ").capitalizeFirstLetter()}', style: boldTextStyle()),
                        SizedBox(height: 8),
                        Text(mData.historyMessage.validate()),
                        SizedBox(height: 8),
                        Text('${printDate('${mData.createdAt}')}', style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

/*  messageData(RideHistory orderData) {
    if (getStringAsync(USER_TYPE) == CLIENT) {
      if (orderData.historyType == COURIER_ASSIGNED) {
        return 'Your Order#${orderData.orderId} has been assigned to ${orderData.historyData!.driverName}.';
      } else if (orderData.historyType == COURIER_TRANSFER) {
        return 'Your Order#${orderData.orderId} has been transfered to ${orderData.historyData!.driverName}.';
      } else {
        return '${orderData.historyMessage}';
      }
    } else {
      return '${orderData.historyMessage}';
    }
  }*/
}