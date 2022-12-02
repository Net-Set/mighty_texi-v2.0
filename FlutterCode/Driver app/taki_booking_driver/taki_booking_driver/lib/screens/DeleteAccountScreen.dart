import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../Services/AuthService.dart';
import '../main.dart';
import '../network/RestApis.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/AppButtonWidget.dart';
import '../utils/Extensions/ConformationDialog.dart';
import '../utils/Extensions/app_common.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  DeleteAccountScreenState createState() => DeleteAccountScreenState();
}

class DeleteAccountScreenState extends State<DeleteAccountScreen> {
  AuthServices authService = AuthServices();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.deleteAccount, style: boldTextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language.areYouSureYouWantPleaseReadAffect, style: primaryTextStyle()),
                SizedBox(height: 16),
                Text(language.account, style: boldTextStyle()),
                SizedBox(height: 8),
                Text(language.deletingAccountEmail, style: primaryTextStyle()),
                SizedBox(height: 24),
                Center(
                  child: AppButtonWidget(
                    text: language.deleteAccount,
                    textStyle: boldTextStyle(color: Colors.white),
                    color: Colors.red,
                    onTap: () async {
                      await showConfirmDialogCustom(
                        context,
                        title: language.areYouSureYouWantDeleteAccount,
                        dialogType: DialogType.DELETE,
                        positiveText: language.yes,
                        negativeText: language.no,
                        onAccept: (c) async {
                           await deleteAccount(context);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Observer(builder: (context) {
            return Visibility(
              visible: appStore.isLoading,
              child: loaderWidget(),
            );
          }),
        ],
      ),
    );
  }

  Future deleteAccount(BuildContext context) async {
    appStore.setLoading(true);
    await deleteUser().then((value) async {
      await userService.removeDocument(sharedPref.getString(UID)!).then((value) async {
        await authService.deleteUserFirebase().then((value) async {
          await logout(data: context).then((value) {
            appStore.setLoading(false);
          });
        }).catchError((error) {
          appStore.setLoading(false);
          toast(error.toString());
        });
      }).catchError((error) {
        appStore.setLoading(false);
        toast(error.toString());
      });
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }
}
