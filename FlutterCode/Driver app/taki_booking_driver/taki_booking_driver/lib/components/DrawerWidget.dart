import 'package:flutter/material.dart';

import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';

class DrawerWidget extends StatefulWidget {
  final String title;
  final String iconData;
  final Function() onTap;

  DrawerWidget({required this.title, required this.iconData, required this.onTap});

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
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
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)), borderRadius: BorderRadius.circular(defaultRadius)),
      child: inkWellWidget(
        onTap: widget.onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(widget.iconData, height: 35, width: 35),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(widget.title, style: primaryTextStyle(color: Colors.white.withOpacity(0.8))),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.8), size: 18)
          ],
        ),
      ),
    );
  }
}
