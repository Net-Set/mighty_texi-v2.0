import 'package:flutter/material.dart';

import '../Constants.dart';

enum DeviceSize { mobile, tablet, desktop }

extension LayoutUtils on BoxConstraints {
  /// returns DeviceSize
  DeviceSize get device {
    if (this.maxWidth >= desktopBreakpointGlobal) {
      return DeviceSize.desktop;
    }
    if (this.maxWidth >= tabletBreakpointGlobal) {
      return DeviceSize.tablet;
    }
    return DeviceSize.mobile;
  }
}

extension WidgetExtension on Widget? {
  /// With custom height and width
  /// Validate given widget is not null and returns given value if null.
  Widget validate({Widget value = const SizedBox()}) => this ?? value;
}

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}

/// set different layout based on current screen size (mobile, web, desktop)
class Responsive extends StatelessWidget {
  final Widget? web;
  final Widget mobile;
  final Widget? tablet;
  final bool? useFullWidth;
  final double? width;
  final double? minHeight;
  final Widget? defaultWidget;

  Responsive({
    this.web,
    required this.mobile,
    this.tablet,
    this.useFullWidth,
    this.width,
    this.minHeight,
    this.defaultWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.device == DeviceSize.tablet) {
          return tablet ?? mobile;
        } else if (constraints.device == DeviceSize.mobile) {
          return mobile;
        } else if (constraints.device == DeviceSize.desktop) {
          /// $desktopBreakpointGlobal checkout this variable to breakout desktop widget

          if (minHeight != null && constraints.minHeight < minHeight!) {
            return defaultWidget.validate();
          } else {
            return Container(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: useFullWidth.validate(value: true) ? null : BoxConstraints(maxWidth: width ?? (MediaQuery.of(context).size.width * 0.9)),
                child: web ?? SizedBox(),
              ),
            );
          }
        }
        return web ?? tablet ?? mobile;
      },
    );
  }
}
