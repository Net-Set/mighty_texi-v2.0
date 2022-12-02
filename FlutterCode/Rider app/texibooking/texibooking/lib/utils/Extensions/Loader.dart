import 'package:flutter/material.dart';

import '../../../main.dart';
import '../Common.dart';
/// Circular Loader Widget
class Loader extends StatefulWidget {
  final Color? color;

  @Deprecated(
      'accentColor is now deprecated and not being used. use defaultLoaderAccentColorGlobal instead')
  final Color? accentColor;
  final Decoration? decoration;
  final int? size;
  final double? value;
  final Animation<Color?>? valueColor;

  Loader({
    this.color,
    this.decoration,
    this.size,
    this.value,
    this.valueColor,
    this.accentColor,
  });

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 40,
        width: 40,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.color ?? defaultLoaderBgColorGlobal,
              shape: BoxShape.circle,
              boxShadow: defaultBoxShadow(),
            ),
        //Progress color uses accentColor from ThemeData
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: widget.value,
        ),
      ),
    );
  }
}
