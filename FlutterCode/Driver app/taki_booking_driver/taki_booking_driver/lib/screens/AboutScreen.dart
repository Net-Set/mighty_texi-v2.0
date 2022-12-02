import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/Colors.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/app_common.dart';
import '../main.dart';
import '../model/SettingModel.dart';
import '../utils/Common.dart';

class AboutScreen extends StatefulWidget {
  final SettingModel settingModel;

  AboutScreen({required this.settingModel});

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
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
        title: Text(language.aboutUs, style: boldTextStyle(color: Colors.white)),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/ic_app_logo.jpg', height: 150, width: 150, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(mAppName, style: primaryTextStyle(size: 20)),
            SizedBox(height: 8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (_, snap) {
                if (snap.hasData) {
                  return Text('v${snap.data!.version}', style: secondaryTextStyle());
                }
                return SizedBox();
              },
            ),
            SizedBox(height: 16),
            Text(widget.settingModel.siteDescription.validate(), style: secondaryTextStyle(), maxLines: 6, overflow: TextOverflow.visible),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          height: 120,
          child: Column(
            children: [
              Text(language.lblFollowUs, style: boldTextStyle()),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  inkWellWidget(
                    onTap: () {
                      if (widget.settingModel.instagramUrl != null && widget.settingModel.instagramUrl!.isNotEmpty) {
                        launchUrl(Uri.parse(widget.settingModel.instagramUrl.validate()), mode: LaunchMode.externalApplication);
                      } else {
                        toast(language.txtURLEmpty);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset("images/ic_insta.png", height: 35, width: 35),
                    ),
                  ),
                  inkWellWidget(
                    onTap: () {
                      if (widget.settingModel.twitterUrl != null && widget.settingModel.twitterUrl!.isNotEmpty) {
                        launchUrl(Uri.parse(widget.settingModel.twitterUrl.validate()), mode: LaunchMode.externalApplication);
                      } else {
                        toast(language.txtURLEmpty);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset('images/ic_twitter.png', height: 35, width: 35),
                    ),
                  ),
                  inkWellWidget(
                    onTap: () {
                      if (widget.settingModel.linkedinUrl != null && widget.settingModel.linkedinUrl!.isNotEmpty) {
                        launchUrl(Uri.parse(widget.settingModel.linkedinUrl.validate()), mode: LaunchMode.externalApplication);
                      } else {
                        toast(language.txtURLEmpty);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset('images/ic_linked.png', height: 35, width: 35),
                    ),
                  ),
                  inkWellWidget(
                    onTap: () {
                      if (widget.settingModel.facebookUrl != null && widget.settingModel.facebookUrl!.isNotEmpty) {
                        launchUrl(Uri.parse(widget.settingModel.facebookUrl.validate()), mode: LaunchMode.externalApplication);
                      } else {
                        toast(language.txtURLEmpty);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset('images/ic_facebook.png', height: 35, width: 35),
                    ),
                  ),
                  inkWellWidget(
                    onTap: () {
                      if (widget.settingModel.contactNumber != null && widget.settingModel.contactNumber!.isNotEmpty) {
                        launch(('tel://${widget.settingModel.contactNumber.validate()}'));
                      } else {
                        toast(language.txtURLEmpty);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.call,
                        color: appStore.isDarkMode ? Colors.white : primaryColor,
                        size: 36,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              widget.settingModel.siteCopyright != null && widget.settingModel.siteCopyright!.isNotEmpty
                  ? Text(widget.settingModel.siteCopyright.validate(), style: secondaryTextStyle(), maxLines: 1)
                  : Text('Copyright' + " @${DateTime.now().year} meetmighty", style: secondaryTextStyle(size: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
