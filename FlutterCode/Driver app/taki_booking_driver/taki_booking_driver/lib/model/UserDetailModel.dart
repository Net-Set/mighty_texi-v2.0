import 'package:taxi_driver/model/ServiceModel.dart';

class UserDetailModel {
  UserData? data;
  String? message;

  UserDetailModel({this.data, this.message});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? address;
  String? contact_number;
  String? created_at;
  String? apiToken;
  String? display_name;
  ServiceList? driver_service;
  String? email;
  String? fcm_token;
  String? first_name;
  String? gender;
  var id;
  int? is_online;
  int? is_verified_driver;
  String? last_name;
  String? last_notification_seen;
  String? latitude;
  String? login_type;
  String? longitude;
  String? player_id;
  String? profile_image;
  int? service_id;
  String? status;
  String? timezone;
  String? uid;
  String? updated_at;
  UserBankAccount? user_bank_account;
  UserDetail? user_detail;
  String? user_type;
  String? username;

  UserData({
    this.address,
    this.contact_number,
    this.created_at,
    this.display_name,
    this.driver_service,
    this.email,
    this.fcm_token,
    this.first_name,
    this.gender,
    this.id,
    this.is_online,
    this.is_verified_driver,
    this.last_name,
    this.last_notification_seen,
    this.latitude,
    this.login_type,
    this.longitude,
    this.player_id,
    this.profile_image,
    this.service_id,
    this.status,
    this.timezone,
    this.uid,
    this.updated_at,
    this.user_bank_account,
    this.user_detail,
    this.user_type,
    this.username,
    this.apiToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      address: json['address'],
      contact_number: json['contact_number'],
      created_at: json['created_at'],
      display_name: json['display_name'],
      email: json['email'],
      fcm_token: json['fcm_token'],
      first_name: json['first_name'],
      gender: json['gender'],
      id: json['id'],
      is_online: json['is_online'],
      is_verified_driver: json['is_verified_driver'],
      last_name: json['last_name'],
      last_notification_seen: json['last_notification_seen'],
      latitude: json['latitude'],
      login_type: json['login_type'],
      longitude: json['longitude'],
      player_id: json['player_id'],
      profile_image: json['profile_image'],
      service_id: json['service_id'],
      status: json['status'],
      timezone: json['timezone'],
      uid: json['uid'],
      updated_at: json['updated_at'],
      user_detail: json['user_detail'] != null ? UserDetail.fromJson(json['user_detail']) : null,
      user_bank_account: json['user_bank_account'] != null ? UserBankAccount.fromJson(json['user_bank_account']) : null,
      driver_service: json['driver_service'] != null ? ServiceList.fromJson(json['driver_service']) : null,
      user_type: json['user_type'],
      username: json['username'],
      apiToken: json['api_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['contact_number'] = this.contact_number;
    data['created_at'] = this.created_at;
    data['display_name'] = this.display_name;
    data['email'] = this.email;
    data['fcm_token'] = this.fcm_token;
    data['first_name'] = this.first_name;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['is_online'] = this.is_online;
    data['is_verified_driver'] = this.is_verified_driver;
    data['last_name'] = this.last_name;
    data['last_notification_seen'] = this.last_notification_seen;
    data['latitude'] = this.latitude;
    data['login_type'] = this.login_type;
    data['longitude'] = this.longitude;
    data['player_id'] = this.player_id;
    data['profile_image'] = this.profile_image;
    data['service_id'] = this.service_id;
    data['status'] = this.status;
    data['timezone'] = this.timezone;
    data['uid'] = this.uid;
    data['updated_at'] = this.updated_at;
    data['user_type'] = this.user_type;
    data['username'] = this.username;
    data['api_token'] = this.apiToken;
    if (this.user_detail != null) {
      data['user_detail'] = this.user_detail!.toJson();
    }
    if (this.user_bank_account != null) {
      data['user_bank_account'] = this.user_bank_account!.toJson();
    }
    if (this.driver_service != null) {
      data['driver_service'] = this.driver_service!.toJson();
    }
    return data;
  }
}

class UserDetail {
  String? car_color;
  String? car_model;
  String? car_plate_number;
  String? car_production_year;
  String? created_at;
  String? home_address;
  String? home_latitude;
  String? home_longitude;
  int? id;
  String? updated_at;
  int? user_id;
  String? work_address;
  String? work_latitude;
  String? work_longitude;

  UserDetail({
    this.car_color,
    this.car_model,
    this.car_plate_number,
    this.car_production_year,
    this.created_at,
    this.home_address,
    this.home_latitude,
    this.home_longitude,
    this.id,
    this.updated_at,
    this.user_id,
    this.work_address,
    this.work_latitude,
    this.work_longitude,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      car_color: json['car_color'],
      car_model: json['car_model'],
      car_plate_number: json['car_plate_number'],
      car_production_year: json['car_production_year'],
      created_at: json['created_at'],
      home_address: json['home_address'],
      home_latitude: json['home_latitude'],
      home_longitude: json['home_longitude'],
      id: json['id'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
      work_address: json['work_address'],
      work_latitude: json['work_latitude'],
      work_longitude: json['work_longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_color'] = this.car_color;
    data['car_model'] = this.car_model;
    data['car_plate_number'] = this.car_plate_number;
    data['car_production_year'] = this.car_production_year;
    data['created_at'] = this.created_at;
    data['home_address'] = this.home_address;
    data['home_latitude'] = this.home_latitude;
    data['home_longitude'] = this.home_longitude;
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    data['user_id'] = this.user_id;
    data['work_address'] = this.work_address;
    data['work_latitude'] = this.work_latitude;
    data['work_longitude'] = this.work_longitude;
    return data;
  }
}

class UserBankAccount {
  String? account_holder_name;
  String? account_number;
  String? bank_code;
  String? bank_name;
  String? created_at;
  int? id;
  String? updated_at;
  int? user_id;

  UserBankAccount({
    this.account_holder_name,
    this.account_number,
    this.bank_code,
    this.bank_name,
    this.created_at,
    this.id,
    this.updated_at,
    this.user_id,
  });

  factory UserBankAccount.fromJson(Map<String, dynamic> json) {
    return UserBankAccount(
      account_holder_name: json['account_holder_name'],
      account_number: json['account_number'],
      bank_code: json['bank_code'],
      bank_name: json['bank_name'],
      created_at: json['created_at'],
      id: json['id'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_holder_name'] = this.account_holder_name;
    data['account_number'] = this.account_number;
    data['bank_code'] = this.bank_code;
    data['bank_name'] = this.bank_name;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['updated_at'] = this.updated_at;
    data['user_id'] = this.user_id;
    return data;
  }
}
