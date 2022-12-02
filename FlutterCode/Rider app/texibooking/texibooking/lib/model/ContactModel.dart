import 'package:cloud_firestore/cloud_firestore.dart';

class ContactDataModel {
  String? uid;
  Timestamp? addedOn;

  ContactDataModel({this.uid, this.addedOn});

  factory ContactDataModel.fromJson(Map<String, dynamic> json) {
    return ContactDataModel(
      uid: json['uid'],
      addedOn: json['addedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['addedOn'] = this.addedOn;

    return data;
  }
}
