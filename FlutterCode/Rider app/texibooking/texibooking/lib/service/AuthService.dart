import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/OTPDialog.dart';
import '../main.dart';
import '../utils/Extensions/app_common.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> loginWithOTP(BuildContext context, String phoneNumber) async {
  appStore.setLoading(true);
  return await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {},
    verificationFailed: (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        toast('The provided phone number is not valid.');
        throw 'The provided phone number is not valid.';
      } else {
        log('**************${e.toString()}');
        //toast(e.toString());
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
