import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/SettingModel.dart';
import '../network/RestApis.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/LiveStream.dart';
import '../utils/Extensions/app_common.dart';
import 'AboutScreen.dart';
import 'ChangePasswordScreen.dart';
import 'DeleteAccountScreen.dart';
import 'LanguageScreen.dart';
import 'TermsConditionScreen.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  SettingModel settingModel = SettingModel();
  String? privacyPolicy;
  String? termsCondition;
  String? mHelpAndSupport;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await getAppSetting().then((value) {
      if (value.settingModel!.helpSupportUrl != null) mHelpAndSupport = value.settingModel!.helpSupportUrl!;
      settingModel = value.settingModel!;
      if (value.privacyPolicyModel!.value != null) privacyPolicy = value.privacyPolicyModel!.value!;
      if (value.termsCondition!.value != null) termsCondition = value.termsCondition!.value!;
      setState(() {});
    }).catchError((error) {
      log(error.toString());
    });
    LiveStream().on(CHANGE_LANGUAGE, (p0) {
      setState(() { });
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
        title: Text(language.setting, style: boldTextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Column(
          children: [
            settingItemWidget(Icons.lock_outline, language.changePassword, () {
              launchScreen(context, ChangePasswordScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
            }),
            settingItemWidget(Icons.language, language.language, () {
              launchScreen(context, LanguageScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
            }),
            settingItemWidget(Icons.assignment_outlined, language.privacyPolicy, () {
              launchScreen(context, TermsConditionScreen(title: language.privacyPolicy, subtitle: privacyPolicy), pageRouteAnimation: PageRouteAnimation.Slide);
            }),
            settingItemWidget(Icons.help_outline, language.helpSupport, () {
              if (mHelpAndSupport != null) {
                launchUrl(Uri.parse(mHelpAndSupport!));
              } else {
                toast(language.txtURLEmpty);
              }
            }),
            settingItemWidget(Icons.assignment_outlined, language.termsConditions, () {
              if (termsCondition != null) {
                launchScreen(context, TermsConditionScreen(title: language.termsConditions, subtitle: termsCondition), pageRouteAnimation: PageRouteAnimation.Slide);
              } else {
                toast(language.txtURLEmpty);
              }
            }),
            settingItemWidget(
              Icons.info_outline,
              language.aboutUs,
              () {
                launchScreen(context, AboutScreen(settingModel: settingModel), pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            settingItemWidget(Icons.delete_outline, language.deleteAccount, () {
              launchScreen(context, DeleteAccountScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
            }, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget settingItemWidget(IconData icon, String title, Function() onTap, {bool isLast = false, IconData? suffixIcon}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 16, right: 16),
          leading: Icon(icon, size: 25, color: primaryColor),
          title: Text(title, style: primaryTextStyle()),
          trailing: suffixIcon != null ? Icon(suffixIcon, color: Colors.green) : Icon(Icons.navigate_next, color: Colors.grey),
          onTap: onTap,
        ),
        if (!isLast) Divider(height: 0)
      ],
    );
  }
}
