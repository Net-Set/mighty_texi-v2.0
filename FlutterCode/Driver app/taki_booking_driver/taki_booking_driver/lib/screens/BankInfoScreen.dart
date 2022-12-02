import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxi_driver/model/UserDetailModel.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';

class BankInfoScreen extends StatefulWidget {
  @override
  BankInfoScreenState createState() => BankInfoScreenState();
}

class BankInfoScreenState extends State<BankInfoScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankCodeController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  UserBankAccount? bankDetail;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    appStore.setLoading(true);
    await getUserDetail(userId: sharedPref.getInt(USER_ID)).then((value) {
      if (value.data!.user_bank_account != null) {
        bankDetail = value.data!.user_bank_account!;
        bankNameController.text = bankDetail!.bank_name.validate();
        bankCodeController.text = bankDetail!.bank_code.validate();
        accountHolderNameController.text = bankDetail!.account_holder_name.validate();
        accountNumberController.text = bankDetail!.account_number.validate();
        appStore.setLoading(false);
        setState(() {});
      }
      appStore.setLoading(false);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
  }

  Future<void> updateBankInfo() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appStore.setLoading(true);
      updateBankDetail(
        accountName: accountHolderNameController.text.trim(),
        accountNumber: accountNumberController.text.trim(),
        bankCode: bankCodeController.text.trim(),
        bankName: bankNameController.text.trim(),
      ).then((value) {
        appStore.setLoading(false);

        Navigator.pop(context);
        toast(language.bankInfoUpdateSuccessfully);
      }).catchError((error) {
        appStore.setLoading(false);
        log(error.toString());
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.bankInfo, style: boldTextStyle(color: Colors.white)),
      ),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  AppTextField(
                    controller: bankNameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(context, label: language.bankName),
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: bankCodeController,
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration: inputDecoration(context, label: language.bankCode),
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: accountHolderNameController,
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration: inputDecoration(context, label: language.accountHolderName),
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: accountNumberController,
                    textFieldType: TextFieldType.PHONE,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration: inputDecoration(context, label: language.accountNumber),
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButtonWidget(
          text: bankDetail != null ? language.updateBankDetail : language.addBankDetail,
          color: primaryColor,
          textStyle: boldTextStyle(color: Colors.white),
          onTap: () {
            updateBankInfo();
          },
        ),
      ),
    );
  }
}
