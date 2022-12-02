import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/app_common.dart';
import '../utils/Extensions/app_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FocusNode oldPassFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();

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
        'old_password': oldPassController.text.trim(),
        'new_password': newPassController.text.trim(),
      };
      appStore.setLoading(true);

      await sharedPref.setString(USER_PASSWORD, newPassController.text.trim());

      await changePassword(req).then((value) {
        toast(value.message.toString());
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
      appBar: AppBar(
        title: Text(language.changePassword, style: boldTextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, top: 30, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: oldPassController,
                    textFieldType: TextFieldType.PASSWORD,
                    focus: oldPassFocus,
                    nextFocus: newPassFocus,
                    decoration: inputDecoration(context, label: language.oldPassword),
                    errorThisFieldRequired: language.thisFieldRequired,
                    errorMinimumPasswordLength: language.passwordInvalid,
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: newPassController,
                    textFieldType: TextFieldType.PASSWORD,
                    focus: newPassFocus,
                    nextFocus: confirmPassFocus,
                    decoration: inputDecoration(context, label: language.newPassword),
                    errorThisFieldRequired: language.thisFieldRequired,
                    errorMinimumPasswordLength: language.passwordInvalid,
                  ),
                  SizedBox(height: 16),
                  AppTextField(
                    controller: confirmPassController,
                    textFieldType: TextFieldType.PASSWORD,
                    focus: confirmPassFocus,
                    decoration: inputDecoration(context, label: language.confirmPassword),
                    errorThisFieldRequired: language.thisFieldRequired,
                    errorMinimumPasswordLength: language.passwordInvalid,
                    validator: (val) {
                      if (val!.isEmpty) return language.thisFieldRequired;
                      if (val != newPassController.text) return language.passwordDoesNotMatch;
                      return null;
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: AppButtonWidget(
          color: primaryColor,
          onTap: () {
            submit();
          },
          child: Text(language.save, style: boldTextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
