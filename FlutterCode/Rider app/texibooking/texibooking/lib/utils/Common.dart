import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:taxibooking/utils/Colors.dart';
import 'package:taxibooking/utils/Constants.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../../main.dart';
import 'Extensions/Loader.dart';
import 'Extensions/app_common.dart';

Widget dotIndicator(list, i) {
  return SizedBox(
    height: 16,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        list.length,
        (ind) {
          return Container(
            height: 8,
            width: 8,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(color: i == ind ? Colors.white : Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(defaultRadius)),
          );
        },
      ),
    ),
  );
}

InputDecoration inputDecoration(BuildContext context, {String? label, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: primaryColor.withOpacity(0.1))),
    alignLabelWithHint: true,
    filled: true,
    isDense: true,
    labelText: label ?? "Sample Text",
    labelStyle: primaryTextStyle(),
    suffixIcon: suffixIcon,
  );
}

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}

EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  return EdgeInsets.symmetric(vertical: 14, horizontal: 16);
}

Widget inkWellWidget({Function()? onTap, required Widget child}) {
  return InkWell(onTap: onTap, child: child, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashColor: Colors.transparent);
}

bool get isRTL => rtlLanguage.contains(appStore.selectedLanguage);

Widget commonCachedNetworkImage(String? url, {double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, bool usePlaceholderIfUrlEmpty = true, double? radius}) {
  if (url != null && url.isEmpty) {
    return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url!,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(height: height, width: width, fit: fit, alignment: alignment, radius: radius);
      },
    );
  } else {
    return Image.network(url!, height: height, width: width, fit: fit, alignment: alignment ?? Alignment.center);
  }
}

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment, double? radius}) {
  return Image.asset('images/placeholder.jpg', height: height, width: width, fit: fit ?? BoxFit.cover, alignment: alignment ?? Alignment.center);
}

List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? Colors.grey.withOpacity(0.2),
      blurRadius: blurRadius ?? 4.0,
      spreadRadius: spreadRadius ?? 1.0,
      offset: offset,
    )
  ];
}

/// Hide soft keyboard
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

const double degrees2Radians = pi / 180.0;

double radians(double degrees) => degrees * degrees2Radians;

const default_Language = 'en';

Future<bool> isNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

Widget loaderWidget1() {
  return Center(child: Image.asset('images/loader.gif', height: 100, width: 100, fit: BoxFit.contain));
}

Widget loaderWidget() {
  return Center(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

void afterBuildCreated(Function()? onCreated) {
  makeNullable(SchedulerBinding.instance)!.addPostFrameCallback((_) => onCreated?.call());
}

T? makeNullable<T>(T? value) => value;

String printDate(String date) {
  return DateFormat('dd MMM yyyy').format(DateTime.parse(date).toLocal()) + " at " + DateFormat('hh:mm a').format(DateTime.parse(date).toLocal());
}

Widget emptyWidget() {
  return Center(child: Image.asset('images/no_data.png', width: 150, height: 250));
}

Future<void> saveOneSignalPlayerId() async {
  await OneSignal.shared.getDeviceState().then((value) async {
    if (value!.userId.validate().isNotEmpty) await sharedPref.setString(PLAYER_ID, value.userId.validate());
  });
}

String statusTypeIcon({String? type}) {
  String icon = 'images/icons/ic_new_ride_requested.png';
  if (type == NEW_RIDE_REQUESTED) {
    icon = 'images/icons/ic_new_ride_requested.png';
  } else if (type == ACCEPTED) {
    icon = 'images/icons/ic_accepted.png';
  } else if (type == ARRIVING) {
    icon = 'images/icons/ic_arriving.png';
  } else if (type == ARRIVED) {
    icon = 'images/icons/ic_arrived.png';
  } else if (type == IN_PROGRESS) {
    icon = 'images/icons/in_progress.png';
  } else if (type == CANCELED) {
    icon = 'images/icons/ic_canceled.png';
  } else if (type == COMPLETED) {
    icon = 'images/icons/ic_completed.png';
  }
  return icon;
}

Widget scheduleOptionWidget(BuildContext context, bool isSelected, String imagePath, String title) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(
          color: isSelected
              ? primaryColor
              : appStore.isDarkMode
                  ? Colors.transparent
                  : borderColor),
    ),
    child: Row(
      children: [
        ImageIcon(AssetImage(imagePath), size: 20, color: isSelected ? primaryColor : Colors.grey),
        SizedBox(width: 16),
        Text(title, style: boldTextStyle()),
      ],
    ),
  );
}

Widget totalCount({String? title, String? subTitle, String? description}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(title!, style: primaryTextStyle()),
      ),
      Expanded(
        child: Text(description!, style: primaryTextStyle()),
      ),
      Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} $subTitle' : '$subTitle ${appStore.currencyCode}', style: primaryTextStyle()),
    ],
  );
}

Future<bool> checkPermission() async {
  // Request app level location permission
  LocationPermission locationPermission = await Geolocator.requestPermission();

  if (locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
    // Check system level location permission
    if (!await Geolocator.isLocationServiceEnabled()) {
      return await Geolocator.openLocationSettings().then((value) => false).catchError((e) => false);
    } else {
      return true;
    }
  } else {
    toast(language.pleaseEnableLocationPermission);

    // Open system level location permission
    await Geolocator.openAppSettings();

    return false;
  }
}

/// Handle error and loading widget when using FutureBuilder or StreamBuilder
Widget snapWidgetHelper<T>(
  AsyncSnapshot<T> snap, {
  Widget? errorWidget,
  Widget? loadingWidget,
  String? defaultErrorMessage,
  @Deprecated('Do not use this') bool checkHasData = false,
  Widget Function(String)? errorBuilder,
}) {
  if (snap.hasError) {
    log(snap.error);
    if (errorBuilder != null) {
      return errorBuilder.call(defaultErrorMessage ?? snap.error.toString());
    }
    return Center(
      child: errorWidget ??
          Text(
            defaultErrorMessage ?? snap.error.toString(),
            style: primaryTextStyle(),
          ),
    );
  } else if (!snap.hasData) {
    return loadingWidget ?? Loader();
  } else {
    return SizedBox();
  }
}

String statusName({String? status}) {
  if (status == NEW_RIDE_REQUESTED) {
    status = language.newRideRequested;
  } else if (status == ACCEPTED) {
    status = language.accepted;
  } else if (status == ARRIVING) {
    status = language.arriving;
  } else if (status == ARRIVED) {
    status = language.arrived;
  } else if (status == IN_PROGRESS) {
    status = language.inProgress;
  } else if (status == CANCELED) {
    status = language.cancelled;
  } else if (status == COMPLETED) {
    status = language.completed;
  }
  return status!;
}

String paymentStatus(String paymentStatus) {
  if (paymentStatus.toLowerCase() == PAYMENT_PENDING.toLowerCase()) {
    return language.pending;
  } else if (paymentStatus.toLowerCase() == PAYMENT_FAILED.toLowerCase()) {
    return language.failed;
  } else if (paymentStatus == PAYMENT_PAID) {
    return language.paid;
  } else if (paymentStatus == CASH) {
    return language.cash;
  } else if (paymentStatus == Wallet) {
    return language.wallet;
  }
  return language.pending;
}

String changeStatusText(String? status) {
  if (status == COMPLETED) {
    return language.completed;
  } else if (status == CANCELED) {
    return language.cancelled;
  }
  return '';
}

String changeGender(String? name) {
  if (name == MALE) {
    return language.male;
  } else if (name == FEMALE) {
    return language.female;
  } else if (name == OTHER) {
    return language.other;
  }
  return '';
}
