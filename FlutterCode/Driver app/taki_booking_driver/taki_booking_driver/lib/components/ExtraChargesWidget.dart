import 'package:flutter/material.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../model/AdditionalFeesList.dart';
import '../model/ExtraChargeRequestModel.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';

class ExtraChargesWidget extends StatefulWidget {
  final List<ExtraChargeRequestModel>? data;

  ExtraChargesWidget({this.data});

  @override
  ExtraChargesWidgetState createState() => ExtraChargesWidgetState();
}

class ExtraChargesWidgetState extends State<ExtraChargesWidget> {
  TextEditingController extraController = TextEditingController();
  List<AdditionalFeesModel> additionalFeesData = [];
  String? extraCharges;

  List<ExtraChargeRequestModel> list = [];

  num total = 50;

  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      isLoad = true;
    });
    await getAdditionalFees().then((value) {
      additionalFeesData.addAll(value.data!);
      setState(() {
        isLoad = false;
      });
    }).catchError((error) {
      log(error.toString());
    });
    if (widget.data != null && widget.data!.isNotEmpty) {
      list.addAll(widget.data!);

      setState(() {});
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            !isLoad && additionalFeesData.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(language.addExtraCharges, style: boldTextStyle()),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding:  EdgeInsets.only(left: 16),
                            child: Text('Apply extra charges'),
                          ),
                          value: extraCharges,
                          isExpanded: true,
                          underline: SizedBox(),
                          items: additionalFeesData.map((e) {
                            return DropdownMenuItem(
                              value: e.title,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(e.title.validate(), style: boldTextStyle()),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            extraCharges = val!;
                            if (list.isNotEmpty) {
                              list.forEach((element) {
                                if (element.key == val) {
                                  extraController.text = element.value.toString();
                                }
                              });
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AppTextField(
                              controller: extraController,
                              autoFocus: false,
                              textFieldType: TextFieldType.PHONE,
                              errorThisFieldRequired: language.thisFieldRequired,
                              decoration: inputDecoration(context, label: language.enterAmount),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: AppButtonWidget(
                              text: 'Add',
                              color: primaryColor,
                              textStyle: boldTextStyle(color: Colors.white),
                              onTap: () {
                                if (extraCharges != null) {
                                  if (extraController.text.isNotEmpty) {
                                    if (list.isNotEmpty) {
                                      if (list.any((element) => element.key == extraCharges)) {
                                        ExtraChargeRequestModel data = list.firstWhere((element) => element.key == extraCharges);
                                        list.remove(data);
                                        list.add(ExtraChargeRequestModel(key: extraCharges, value: int.parse(extraController.text.trim())));
                                      } else {
                                        list.add(ExtraChargeRequestModel(key: extraCharges, value: int.parse(extraController.text.trim())));
                                      }
                                    } else {
                                      list.add(ExtraChargeRequestModel(key: extraCharges, value: int.parse(extraController.text.trim())));
                                    }
                                    hideKeyboard(context);
                                    extraController.clear();
                                    setState(() {});
                                  } else {
                                    toast(language.pleaseAddedAmount);
                                  }
                                } else {
                                  toast('Please select extra charges');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      if (list.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text(language.title, style: boldTextStyle())),
                                Expanded(child: Text(language.charges, style: boldTextStyle())),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 8),
                            Column(
                              children: list.map((e) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(e.key.validate(), style: primaryTextStyle()),
                                    ),
                                    SizedBox(height: 16),
                                    Expanded(
                                      child: Text(e.value.toString(), style: primaryTextStyle()),
                                    ),
                                    Expanded(
                                      child: inkWellWidget(
                                        onTap: () {
                                          list.remove(e);
                                          setState(() {});
                                        },
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppButtonWidget(
                              text: language.cancel,
                              color: Colors.red,
                              textStyle: boldTextStyle(color: Colors.white),
                              onTap: () {
                                list.clear();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: AppButtonWidget(
                              text: language.saveCharges,
                              color: primaryColor,
                              textStyle: boldTextStyle(color: Colors.white),
                              onTap: () {
                                Navigator.pop(context, list);
                                log(list.length);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : isLoad
                    ? loaderWidget()
                    : emptyWidget(),
            isLoad ? loaderWidget() : SizedBox(),
          ],
        ));
  }
}
