import 'package:flutter/material.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../model/EstimatePriceModel.dart';
import '../utils/Colors.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';

class CarDetailWidget extends StatefulWidget {
  final ServicesListData service;

  CarDetailWidget({required this.service});

  @override
  CarDetailWidgetState createState() => CarDetailWidgetState();
}

class CarDetailWidgetState extends State<CarDetailWidget> {
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
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(widget.service.serviceImage.validate(), fit: BoxFit.contain, width: 200, height: 100),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(widget.service.name.validate(), style: boldTextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text('${language.get} ${widget.service.name} ${language.rides}', style: secondaryTextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Divider(color: Colors.grey),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language.capacity, style: primaryTextStyle(color: Colors.white)),
              Text('${widget.service.capacity} ${language.people}', style: primaryTextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language.fare, style: primaryTextStyle(color: Colors.white)),
              Text('\$ ${widget.service.baseFare}', style: primaryTextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
            style: secondaryTextStyle(color: Colors.white),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16),
          AppButtonWidget(
            color: Colors.white,
            text: language.done,
            width: MediaQuery.of(context).size.width,
            onTap: () {
              Navigator.pop(context);
            },
            textStyle: boldTextStyle(color: primaryColor),
          )
        ],
      ),
    );
  }
}
