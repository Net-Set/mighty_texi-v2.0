import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver/network/RestApis.dart';
import 'package:taxi_driver/screens/SplashScreen.dart';
import 'package:taxi_driver/store/AppStore.dart';
import 'package:taxi_driver/utils/Colors.dart';
import 'package:taxi_driver/utils/Common.dart';
import 'package:taxi_driver/utils/Constants.dart';
import 'package:taxi_driver/utils/DataProvider.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import 'AppTheme.dart';
import 'Services/ChatMessagesService.dart';
import 'Services/NotificationService.dart';
import 'Services/UserServices.dart';
import 'language/AppLocalizations.dart';
import 'language/BaseLanguage.dart';
import 'model/FileModel.dart';
import 'model/LanguageDataModel.dart';
import 'screens/NoInternetScreen.dart';
import 'utils/Extensions/app_common.dart';

AppStore appStore = AppStore();
late SharedPreferences sharedPref;
Color textPrimaryColorGlobal = textPrimaryColor;
Color textSecondaryColorGlobal = textSecondaryColor;
Color defaultLoaderBgColorGlobal = Colors.white;
List<LanguageDataModel> localeLanguageList = [];
LanguageDataModel? selectedLanguageDataModel;
late BaseLanguage language;
bool isCurrentlyOnNoInternet = false;

late List<FileModel> fileList = [];
bool mIsEnterKey = false;
String mSelectedImage = "assets/default_wallpaper.png";

ChatMessageService chatMessageService = ChatMessageService();
NotificationService notificationService = NotificationService();
UserService userService = UserService();

final navigatorKey = GlobalKey<NavigatorState>();

get getContext => navigatorKey.currentState?.overlay?.context;
late LocationPermission locationPermissionHandle;

Future<void> initialize({
  double? defaultDialogBorderRadius,
  List<LanguageDataModel>? aLocaleLanguageList,
  String? defaultLanguage,
}) async {
  localeLanguageList = aLocaleLanguageList ?? [];
  selectedLanguageDataModel = getSelectedLanguageModel(defaultLanguage: default_Language);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  });

  sharedPref = await SharedPreferences.getInstance();
  await initialize(aLocaleLanguageList: languageList());
  appStore.setLanguage(default_Language);

  await appStore.setLoggedIn(sharedPref.getBool(IS_LOGGED_IN) ?? false, isInitializing: true);
  await appStore.setUserId(sharedPref.getInt(USER_ID) ?? 0, isInitializing: true);
  await appStore.setUserEmail(sharedPref.getString(USER_EMAIL).validate(), isInitialization: true);
  await appStore.setUserProfile(sharedPref.getString(USER_PROFILE_PHOTO).validate());

  await OneSignal.shared.setAppId(mOneSignalAppId);
  if (appStore.isLoggedIn) {
    getUserDetail(userId: sharedPref.getInt(USER_ID)).then((value) async {
      sharedPref.setInt(IS_Verified_Driver, value.data!.is_verified_driver!);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
    connectivitySubscription.cancel();
  }

  void init() async {
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((e) {
      if (e == ConnectivityResult.none) {
        log('not connected');
        isCurrentlyOnNoInternet = true;
        launchScreen(navigatorKey.currentState!.overlay!.context, NoInternetScreen());
      } else {
        if (isCurrentlyOnNoInternet) {
          Navigator.pop(navigatorKey.currentState!.overlay!.context);
          isCurrentlyOnNoInternet = false;
          toast('Internet is connected.');
        }
        log('connected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Mighty Driver',
        theme: AppTheme.lightTheme,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        home: SplashScreen(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [
          AppLocalizations(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage.validate(value: default_Language)),
      );
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
