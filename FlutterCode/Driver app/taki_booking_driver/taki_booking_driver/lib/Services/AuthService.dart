import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxi_driver/components/OTPDialog.dart';
import 'package:taxi_driver/model/UserDetailModel.dart';
import 'package:taxi_driver/screens/DriverDashboardScreen.dart';
import 'package:taxi_driver/screens/VerifyDeliveryPersonScreen.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../model/LoginResponse.dart';
import '../network/RestApis.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  Future<void> updateUserData(UserData user) async {
    userService.updateDocument({
      'player_id': sharedPref.getString(PLAYER_ID),
      'updatedAt': Timestamp.now(),
    }, user.uid);
  }

  Future<void> signUpWithEmailPassword(
    context, {
    String? name,
    String? email,
    String? password,
    String? mobileNumber,
    String? fName,
    String? lName,
    String? userName,
    bool socialLoginName = false,
    String? userType,
    String? uID,
    bool isOtp = false,
    UserDetail? userDetail,
    int? serviceId,
    String? gender,
  }) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
    if (userCredential.user != null) {
      User currentUser = userCredential.user!;

      UserData userModel = UserData();

      /// Create user
      userModel.uid = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.contact_number = mobileNumber;
      userModel.username = userName;
      userModel.user_type = userType;
      userModel.display_name = fName! + " " + lName!;
      userModel.first_name = fName;
      userModel.last_name = lName;
      userModel.created_at = Timestamp.now().toDate().toString();
      userModel.updated_at = Timestamp.now().toDate().toString();
      userModel.player_id = sharedPref.getString(PLAYER_ID);

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        Map req = {
          'first_name': fName,
          'last_name': lName,
          'username': userName,
          'email': email,
          "user_type": "driver",
          "contact_number": mobileNumber,
          'password': password,
          "player_id": sharedPref.getString(PLAYER_ID).validate(),
          "uid": userModel.uid,
          "gender": gender,
          if (socialLoginName) 'login_type': isOtp ? 'mobile' : 'google',
          "user_detail": {
            'car_model': userDetail!.car_model,
            'car_color': userDetail.car_color,
            'car_plate_number': userDetail.car_plate_number,
            'car_production_year': userDetail.car_production_year,
          },
          'service_id': serviceId,
        };

        log(req);
        await signUpApi(req).then((value) {
          if (sharedPref.getInt(IS_Verified_Driver) == 1) {
            launchScreen(context, DriverDashboardScreen());
          } else {
            launchScreen(context, VerifyDeliveryPersonScreen(isShow: true), pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true);
          }
        }).catchError((error) {
          toast(error.toString());
          log(error.toString());
        });
        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    } else {
      throw "errorSomethingWentWrong";
    }
  }

  Future<void> signInWithEmailPassword(context, {required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
      appStore.setLoading(true);
      final User user = value.user!;
      UserData userModel = await userService.getUser(email: user.email);
      await updateUserData(userModel);

      appStore.setLoading(true);
      //Login Details to SharedPreferences
      sharedPref.setString(UID, userModel.uid.validate());
      sharedPref.setString(USER_EMAIL, userModel.email.validate());
      sharedPref.setBool(IS_LOGGED_IN, true);

      //Login Details to AppStore
      appStore.setUserEmail(userModel.email.validate());
      appStore.setUId(userModel.uid.validate());

      //
    }).catchError((e) {
      toast(e.toString());
      log(e.toString());
    });
  }

  Future<void> loginFromFirebaseUser(User currentUser, {LoginResponse? loginDetail, String? fullName, String? fName, String? lName}) async {
    UserData userModel = UserData();

    if (await userService.isUserExist(loginDetail!.data!.email)) {
      ///Return user data
      await userService.userByEmail(loginDetail.data!.email).then((user) async {
        userModel = user;
        appStore.setUserEmail(userModel.email.validate());
        appStore.setUId(userModel.uid.validate());

        await updateUserData(user);
      }).catchError((e) {
        log(e);
        throw e;
      });
    } else {
      /// Create user
      userModel.uid = currentUser.uid.validate();
      userModel.id = loginDetail.data!.id;
      userModel.email = loginDetail.data!.email.validate();
      userModel.username = loginDetail.data!.username.validate();
      userModel.contact_number = loginDetail.data!.contact_number.validate();
      userModel.username = loginDetail.data!.username.validate();
      userModel.email = loginDetail.data!.email.validate();

      if (Platform.isIOS) {
        userModel.username = fullName;
      } else {
        userModel.username = loginDetail.data!.username.validate();
      }

      userModel.contact_number = loginDetail.data!.contact_number.validate();
      userModel.profile_image = loginDetail.data!.profile_image.validate();
      userModel.player_id = sharedPref.getString(PLAYER_ID);

      sharedPref.setString(UID, currentUser.uid.validate());
      log(sharedPref.getString(UID)!);
      sharedPref.setString(USER_EMAIL, userModel.email.validate());
      sharedPref.setBool(IS_LOGGED_IN, true);

      log(userModel.toJson());

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) {
        //
      }).catchError((e) {
        throw e;
      });
    }
  }

  Future<void> loginWithOTP(BuildContext context, String phoneNumber) async {
    return await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          toast('The provided phone number is not valid.');
          throw 'The provided phone number is not valid.';
        } else {
          toast(e.toString());
          throw e.toString();
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.pop(context);
        appStore.setLoading(false);
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(content: OTPDialog(verificationId: verificationId, isCodeSent: true, phoneNumber: phoneNumber)),
          barrierDismissible: false,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //
      },
    );
  }

  Future deleteUserFirebase() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
    }
  }
}
