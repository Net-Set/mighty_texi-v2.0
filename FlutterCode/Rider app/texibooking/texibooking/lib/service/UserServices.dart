import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:taxibooking/main.dart';
import 'package:taxibooking/model/LoginResponse.dart';
import 'package:taxibooking/utils/Extensions/StringExtensions.dart';
import '../utils/Constants.dart';
import 'BaseServices.dart';

class UserService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  UserService() {
    ref = fireStore.collection(USER_COLLECTION);
  }

  Future<void> updateUserInfo(Map data, String id, {File? profileImage}) async {
    if (profileImage != null) {
      String fileName = basename(profileImage.path);
      Reference storageRef = _storage.ref().child("$USER_PROFILE_PHOTO/$fileName");
      UploadTask uploadTask = storageRef.putFile(profileImage);
      await uploadTask.then((e) async {
        await e.ref.getDownloadURL().then((value) {
          sharedPref.setString(USER_PROFILE_PHOTO, value);
          data.putIfAbsent("photoUrl", () => value);
        });
      });
    }

    return ref!.doc(id).update(data as Map<String, Object?>);
  }

  Future<void> updateUserStatus(Map data, String id) async {
    return ref!.doc(id).update(data as Map<String, Object?>);
  }

  Future<UserModel> getUser({String? email}) {
    return ref!.where("email", isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'User Not found';
      }
    });
  }

  Stream<List<UserModel>> users({String? searchText}) {
    return ref!.where('caseSearch', arrayContains: searchText.validate().isEmpty ? null : searchText!.toLowerCase()).snapshots().map((x) {
      return x.docs.map((y) {
        return UserModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<UserModel> userByEmail(String? email) async {
    return await ref!.where('email', isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'No User Found';
      }
    });
  }

  Stream<UserModel> singleUser(String? id, {String? searchText}) {
    log('id-----'+id.toString());
    return ref!.where('uid', isEqualTo: id).limit(1).snapshots().map((event) {
      log(event.docs.first.data().toString());
      return UserModel.fromJson(event.docs.first.data() as Map<String, dynamic>);
    });
  }

  Future<UserModel> userByMobileNumber(String? phone) async {
    log("Phone $phone");
    return await ref!.where('phoneNumber', isEqualTo: phone).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw "No user found";
      }
    });
  }
}
