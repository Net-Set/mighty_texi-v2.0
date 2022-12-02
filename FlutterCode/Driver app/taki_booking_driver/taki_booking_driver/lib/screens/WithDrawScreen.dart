import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxi_driver/model/WithDrawListModel.dart';

import '../main.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';

class WithDrawScreen extends StatefulWidget {
  final Function() onTap;

  WithDrawScreen({required this.onTap});

  @override
  WithDrawScreenState createState() => WithDrawScreenState();
}

class WithDrawScreenState extends State<WithDrawScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();
  TextEditingController addMoneyController = TextEditingController();

  int currentPage = 1;
  int totalPage = 1;

  List<WithDrawModel> withDrawData = [];

  int totalAmount = 0;
  int currentIndex = -1;

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
    await getWithDrawList(page: currentPage).then((value) {
      appStore.setLoading(false);

      currentPage = value.pagination!.currentPage!;
      totalPage = value.pagination!.totalPages!;
      totalAmount = value.wallet_balance!.totalAmount!.toInt();
      if (currentPage == 1) {
        withDrawData.clear();
      }
      withDrawData.addAll(value.data!);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  Future<void> withDrawRequest({int? userId, int? amount}) async {
    appStore.setLoading(true);
    Map req = {
      "user_id": appStore.userId,
      "currency": appStore.currencyName,
      "amount": amount,
      "status": "0",
    };
    await saveWithDrawRequest(req).then((value) {
      toast(value.message);
      Navigator.pop(context);
      widget.onTap.call();
      appStore.setLoading(false);
      init();
    }).catchError((error) {
      Navigator.pop(context);
      toast(error.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: Text(language.withDraw, style: boldTextStyle(color: Colors.white)),
      ),
      body: Observer(builder: (context) {
        return Form(
          key: formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(language.availableBalance, style: secondaryTextStyle(color: Colors.white)),
                            SizedBox(height: 8),
                            Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} $totalAmount' : '$totalAmount ${appStore.currencyCode}',
                                style: boldTextStyle(size: 22, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(language.withdrawHistory, style: boldTextStyle(size: 18)),
                    SizedBox(height: 16),
                    ListView.builder(
                      itemCount: withDrawData.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        WithDrawModel data = withDrawData[index];

                        return Container(
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(language.withdrawHistory, style: boldTextStyle(size: 14)),
                                    SizedBox(height: 4),
                                    Text(printDate(data.created_at!), style: secondaryTextStyle(size: 12)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(data.status == 1 ? language.approved : language.requested, style: secondaryTextStyle(color: data.status == 1 ? Colors.green : Colors.red)),
                                  SizedBox(height: 4),
                                  Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} ${data.amount}' : '${data.amount} ${appStore.currencyCode}', style: secondaryTextStyle()),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Visibility(
                visible: appStore.isLoading,
                child: loaderWidget(),
              ),
              !appStore.isLoading && withDrawData.isEmpty ? emptyWidget() : SizedBox(),
            ],
          ),
        );
      }),
      bottomNavigationBar: Visibility(
        visible: totalAmount > 0,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: AppButtonWidget(
            text: language.withDraw,
            textStyle: boldTextStyle(color: Colors.white),
            color: primaryColor,
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius))),
                builder: (_) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(language.addMoney, style: boldTextStyle()),
                              SizedBox(height: 16),
                              AppTextField(
                                controller: addMoneyController,
                                textFieldType: TextFieldType.OTHER,
                                keyboardType: TextInputType.number,
                                errorThisFieldRequired: language.thisFieldRequired,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    if (totalAmount < int.parse(val)) {
                                      addMoneyController.text = totalAmount.toString();
                                      setState(() {});
                                    }
                                  }
                                },
                                decoration: inputDecoration(context, label: language.amount),
                              ),
                              SizedBox(height: 16),
                              Wrap(
                                runSpacing: 8,
                                spacing: 8,
                                children: appStore.walletPresetTopUpAmount.split('|').map((e) {
                                  return inkWellWidget(
                                    onTap: () {
                                      currentIndex = appStore.walletPresetTopUpAmount.split('|').indexOf(e);
                                      if (totalAmount < num.parse(appStore.walletPresetTopUpAmount.split("|")[currentIndex])) {
                                        addMoneyController.text = totalAmount.toString();
                                        addMoneyController.selection = TextSelection.fromPosition(TextPosition(offset: totalAmount.toString().length));
                                      } else {
                                        addMoneyController.text = appStore.walletPresetTopUpAmount.split("|")[currentIndex];
                                        addMoneyController.selection = TextSelection.fromPosition(TextPosition(offset: appStore.walletPresetTopUpAmount.split("|")[currentIndex].toString().length));
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: currentIndex == appStore.walletPresetTopUpAmount.split('|').indexOf(e) ? primaryColor : Colors.white,
                                        border: Border.all(color: currentIndex == appStore.walletPresetTopUpAmount.split('|').indexOf(e) ? primaryColor : Colors.grey),
                                        borderRadius: BorderRadius.circular(defaultRadius),
                                      ),
                                      child: Text(appStore.currencyPosition == LEFT ? '${appStore.currencyCode} $e' : '$e ${appStore.currencyCode}',
                                          style: boldTextStyle(color: currentIndex == appStore.walletPresetTopUpAmount.split('|').indexOf(e) ? Colors.white : primaryColor)),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButtonWidget(
                                      text: language.cancel,
                                      textStyle: boldTextStyle(color: Colors.white),
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.red,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: AppButtonWidget(
                                      text: language.withDraw,
                                      textStyle: boldTextStyle(color: Colors.white),
                                      width: MediaQuery.of(context).size.width,
                                      color: primaryColor,
                                      onTap: () async {
                                        if (addMoneyController.text.isNotEmpty) {
                                          await withDrawRequest(amount: int.parse(addMoneyController.text));
                                        } else {
                                          toast(language.pleaseSelectAmount);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
