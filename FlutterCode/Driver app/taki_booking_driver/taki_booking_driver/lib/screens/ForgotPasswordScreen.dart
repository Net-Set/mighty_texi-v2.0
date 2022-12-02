import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../../main.dart';
import '../../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController forgotEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      Map req = {
        'email': forgotEmailController.text.trim(),
      };
      appStore.setLoading(true);

      await forgotPassword(req).then((value) {
        toast(value.message.validate());

        appStore.setLoading(false);

        Navigator.pop(context);
      }).catchError((error) {
        appStore.setLoading(false);

        toast(error.toString());
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
      appBar: AppBar(),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language.forgotPassword, style: boldTextStyle(size: 20)),
                  SizedBox(height: 16),
                  Text(language.enterTheEmailAssociatedWithYourAccount, style: primaryTextStyle(size: 14), textAlign: TextAlign.start),
                  SizedBox(height: 32),
                  AppTextField(
                    controller: forgotEmailController,
                    autoFocus: false,
                    textFieldType: TextFieldType.EMAIL,
                    errorThisFieldRequired: language.thisFieldRequired,
                    decoration: inputDecoration(context, label: language.email),
                  ),
                  SizedBox(height: 32),
                  AppButtonWidget(
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    textStyle: boldTextStyle(color: Colors.white),
                    text: language.submit,
                    onTap: () {
                      submit();
                    },
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: appStore.isLoading,
                child: loaderWidget(),
              );
            },
          ),
        ],
      ),
    );
  }
}
