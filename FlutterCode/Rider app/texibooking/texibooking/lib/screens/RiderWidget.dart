import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:taxibooking/main.dart';
import 'package:taxibooking/model/LocationModel.dart';
import 'package:taxibooking/screens/NewEstimateRideListWidget.dart';

import '../model/GoogleMapSearchModel.dart';
import '../model/ServiceModel.dart';
import '../model/TextModel.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/DataProvider.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import 'NewGoogleMapScreen.dart';

class RiderWidget extends StatefulWidget {
  final String title;

  RiderWidget({required this.title});

  @override
  RiderWidgetState createState() => RiderWidgetState();
}

class RiderWidgetState extends State<RiderWidget> {
  TextEditingController sourceLocation = TextEditingController();
  TextEditingController destinationLocation = TextEditingController();

  FocusNode sourceFocus = FocusNode();
  FocusNode desFocus = FocusNode();

  List<TexIModel> carList = getCarList();
  int selectedIndex = -1;
  double? totalAmount;
  double? subTotal;
  double? amount;

  LocationModel? model;

  List<ServiceList> list = [];
  ServiceList? serviceList;

  List<Prediction> listAddress = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    sourceLocation.text = widget.title;
    await getServices().then((value) {
      list.addAll(value.data!);
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: inkWellWidget(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                        child: Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(defaultRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Column(
                              children: [
                                Icon(Icons.near_me, color: Colors.green),
                                SizedBox(height: 4),
                                SizedBox(
                                  height: 50,
                                  child: DottedLine(
                                    direction: Axis.vertical,
                                    lineLength: double.infinity,
                                    lineThickness: 2,
                                    dashColor: primaryColor,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Icon(Icons.location_on, color: Colors.red),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: sourceLocation,
                                    focusNode: sourceFocus,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.zero, hintText: language.currentLocation),
                                    onChanged: (val) {
                                      if (val.isNotEmpty) {
                                        if (val.length < 3) {
                                          listAddress.clear();
                                          setState(() {});
                                        } else {
                                          searchAddressRequest(search: val).then((value) {
                                            listAddress = value.predictions!;
                                            setState(() {});
                                          }).catchError((error) {
                                            log(error);
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller: destinationLocation,
                                    focusNode: desFocus,
                                    autofocus: true,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.zero, hintText: language.destinationLocation),
                                    onChanged: (val) {
                                      if (val.isNotEmpty) {
                                        if (val.length < 3) {
                                          listAddress.clear();
                                          setState(() {});
                                        } else {
                                          searchAddressRequest(search: val).then((value) {
                                            listAddress = value.predictions!;
                                            setState(() {});
                                          }).catchError((error) {
                                            log(error);
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                  if (listAddress.isNotEmpty) SizedBox(height: 16),
                  ListView.builder(
                    controller: ScrollController(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: listAddress.length,
                    itemBuilder: (context, index) {
                      Prediction mData = listAddress[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.location_on_outlined, color: primaryColor),
                        minLeadingWidth: 16,
                        title: Text(mData.description ?? "", style: primaryTextStyle()),
                        onTap: () async {
                          await searchAddressRequestPlaceId(placeId: mData.placeId).then((value) async {
                            var data = value.result!.geometry;
                            if (sourceFocus.hasFocus) {
                              sourceLocation.text = mData.description!;
                              polylineSource = LatLng(data!.location!.lat!, data.location!.lng!);

                              if (sourceLocation.text.isNotEmpty && destinationLocation.text.isNotEmpty) {
                                launchScreen(
                                    context,
                                    NewEstimateRideListWidget(
                                        sourceLatLog: polylineSource, destinationLatLog: polylineDestination, sourceTitle: sourceLocation.text, destinationTitle: destinationLocation.text),
                                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                                sourceLocation.clear();
                                destinationLocation.clear();
                              }
                            } else if (desFocus.hasFocus) {
                              destinationLocation.text = mData.description!;
                              polylineDestination = LatLng(data!.location!.lat!, data.location!.lng!);
                              if (sourceLocation.text.isNotEmpty && destinationLocation.text.isNotEmpty) {
                                launchScreen(
                                    context,
                                    NewEstimateRideListWidget(
                                        sourceLatLog: polylineSource, destinationLatLog: polylineDestination, sourceTitle: sourceLocation.text, destinationTitle: destinationLocation.text),
                                    pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                                sourceLocation.clear();
                                destinationLocation.clear();
                              }
                            }
                            listAddress.clear();
                            setState(() {});
                          }).catchError((error) {
                            log(error);
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  AppButtonWidget(
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    onTap: () async {
                      if (sourceFocus.hasFocus) {
                        PickResult selectedPlace = await launchScreen(context, NewGoogleMapScreen(), pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                        log(selectedPlace);
                        sourceLocation.text = selectedPlace.formattedAddress!;
                        polylineSource = LatLng(selectedPlace.geometry!.location.lat, selectedPlace.geometry!.location.lng);

                        if (sourceLocation.text.isNotEmpty && destinationLocation.text.isNotEmpty) {
                          log(sourceLocation.text);
                          log(destinationLocation.text);

                          launchScreen(
                              context,
                              NewEstimateRideListWidget(
                                  sourceLatLog: polylineSource, destinationLatLog: polylineDestination, sourceTitle: sourceLocation.text, destinationTitle: destinationLocation.text),
                              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);

                          sourceLocation.clear();
                          destinationLocation.clear();
                        }
                      } else if (desFocus.hasFocus) {
                        PickResult selectedPlace = await launchScreen(context, NewGoogleMapScreen(), pageRouteAnimation: PageRouteAnimation.SlideBottomTop);

                        destinationLocation.text = selectedPlace.formattedAddress!;
                        polylineDestination = LatLng(selectedPlace.geometry!.location.lat, selectedPlace.geometry!.location.lng);

                        if (sourceLocation.text.isNotEmpty && destinationLocation.text.isNotEmpty) {
                          log(sourceLocation.text);
                          log(destinationLocation.text);

                          launchScreen(
                              context,
                              NewEstimateRideListWidget(
                                  sourceLatLog: polylineSource, destinationLatLog: polylineDestination, sourceTitle: sourceLocation.text, destinationTitle: destinationLocation.text),
                              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);

                          sourceLocation.clear();
                          destinationLocation.clear();
                        }
                      } else {
                        //
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.my_location_sharp, color: Colors.white),
                        SizedBox(width: 16),
                        Text(language.chooseOnMap, style: boldTextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
