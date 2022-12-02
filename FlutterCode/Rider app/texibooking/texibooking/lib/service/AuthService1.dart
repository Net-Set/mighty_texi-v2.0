import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxibooking/model/LoginResponse.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';

import '../main.dart';
import '../screens/RiderDashBoardScreen.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';
import '../network/RestApis.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthServices {
  Future<void> updateUserData(UserModel user) async {
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
  }) async {
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
    if (userCredential.user != null) {
      User currentUser = userCredential.user!;

      UserModel userModel = UserModel();

      /// Create user
      userModel.uid = currentUser.uid;
      userModel.email = currentUser.email;
      userModel.contactNumber = mobileNumber;
      userModel.username = userName;
      userModel.userType = userType;
      userModel.displayName = fName.validate() + " " + lName.validate();
      userModel.firstName = fName;
      userModel.lastName = lName;
      userModel.createdAt = Timestamp.now().toDate().toString();
      userModel.updatedAt = Timestamp.now().toDate().toString();
      userModel.playerId = sharedPref.getString(PLAYER_ID);

      await userService.addDocumentWithCustomId(currentUser.uid, userModel.toJson()).then((value) async {
        Map req = {
          'first_name': fName,
          'last_name': lName,
          'username': userName,
          'email': email,
          "user_type": "rider",
          "contact_number": mobileNumber,
          'password': password,
          "player_id": sharedPref.getString(PLAYER_ID).validate(),
          "uid": userModel.uid,
          if (socialLoginName) 'login_type': isOtp ? 'mobile' : 'google',
        };

        log(req);
        await signUpApi(req).then((value) {
          launchScreen(context, RiderDashBoardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
        }).catchError((error) {
          toast(error.toString());
        });
        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    }
  }

    Future<void> signInWithEmailPassword(context, {required String email, required String password}) async {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        appStore.setLoading(true);
        final User user = value.user!;
        UserModel userModel = await userService.getUser(email: user.email);
        //await updateUserData(userModel);

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
        log(e.toString());
      });
    }

    Future<void> loginFromFirebaseUser(User currentUser, {LoginResponse? loginDetail, String? fullName, String? fName, String? lName}) async {
      UserModel userModel = UserModel();

      if (await userService.isUserExist(loginDetail!.data!.email)) {
        ///Return user data
        await userService.userByEmail(loginDetail.data!.email).then((user) async {
          userModel = user;
          appStore.setUserEmail(userModel.email.validate());
          appStore.setUId(userModel.uid.validate());

          // await updateUserData(user);
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
        userModel.contactNumber = loginDetail.data!.contactNumber.validate();
        userModel.username = loginDetail.data!.username.validate();
        userModel.email = loginDetail.data!.email.validate();

        if (Platform.isIOS) {
          userModel.username = fullName;
        } else {
          userModel.username = loginDetail.data!.username.validate();
        }

        userModel.contactNumber = loginDetail.data!.contactNumber.validate();
        userModel.profileImage = loginDetail.data!.profileImage.validate();
        userModel.playerId = sharedPref.getString(PLAYER_ID);

        sharedPref.setString(UID, currentUser.uid.validate());
        log(sharedPref.getString(UID));
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

  Future deleteUserFirebase() async {
    if(FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.currentUser!.delete();
      await FirebaseAuth.instance.signOut();
    }
  }

  }

