import 'package:taxi_driver/model/UserDetailModel.dart';

class LoginResponse {
  UserData? data;
  String? message;
  bool? isUserExist;

  LoginResponse({this.data, this.message, this.isUserExist});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      message: json['message'],
      isUserExist: json['is_user_exist'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['is_user_exist'] = this.isUserExist;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

/*class UserModel {
  String? address;
  String? apiToken;
  String? contactNumber;
  String? createdAt;
  String? email;
  String? firstName;
  int? id;
  String? lastName;
  List<Role>? roles;
  String? updatedAt;
  String? userType;
  String? username;
  String? status;
  String? profileImage;
  String? gender;
  int? isOnline;
  UserDetail? userDetail;
  int? isVerifiedDriver;
  String? displayName;
  String? driverService;
  String? fcmToken;
  String? lastNotificationSeen;
  String? latitude;
  String? loginType;
  String? longitude;
  String? playerId;
  int? serviceId;
  String? timezone;
  String? uid;
  UserBankAccount? userBankAccount;

  UserModel({
    this.address,
    this.apiToken,
    this.contactNumber,
    this.createdAt,
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.roles,
    this.updatedAt,
    this.userType,
    this.username,
    this.status,
    this.profileImage,
    this.gender,
    this.isOnline,
    this.isVerifiedDriver,
    this.userDetail,
    this.latitude,
    this.longitude,
    this.displayName,
    this.driverService,
    this.fcmToken,
    this.lastNotificationSeen,
    this.loginType,
    this.playerId,
    this.serviceId,
    this.timezone,
    this.uid,
    this.userBankAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['address'],
      apiToken: json['api_token'],
      contactNumber: json['contact_number'],
      createdAt: json['created_at'],
      email: json['email'],
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
      roles: json['roles'] != null ? (json['roles'] as List).map((i) => Role.fromJson(i)).toList() : null,
      updatedAt: json['updated_at'],
      userType: json['user_type'],
      username: json['username'],
      status: json['status'],
      profileImage: json['profile_image'],
      gender: json['gender'],
      isOnline: json['is_online'],
      uid: json['uid'],
      isVerifiedDriver: json['is_verified_driver'],
      userDetail: json['user_detail'] != null ? UserDetail.fromJson(json['user_detail']) : null,
      userBankAccount: json['user_bank_account'] != null ? UserBankAccount.fromJson(json['user_bank_account']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['api_token'] = this.apiToken;
    data['contact_number'] = this.contactNumber;
    data['created_at'] = this.createdAt;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['last_name'] = this.lastName;
    data['updated_at'] = this.updatedAt;
    data['user_type'] = this.userType;
    data['username'] = this.username;
    data['status'] = this.status;
    data['profile_image'] = this.profileImage;
    data['uid'] = this.uid;
    data['gender'] = this.gender;
    data['is_online'] = this.isOnline;
    data['is_verified_driver'] = this.isVerifiedDriver;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.userBankAccount != null) {
      data['user_bank_account'] = this.userBankAccount!.toJson();
    }
    return data;
  }
}*/
/*

class Pivot {
  int? modelId;
  String? modelType;
  int? roleId;

  Pivot({this.modelId, this.modelType, this.roleId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      modelId: json['model_id'],
      modelType: json['model_type'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    data['role_id'] = this.roleId;
    return data;
  }
}

class Role {
  String? createdAt;
  String? guardName;
  int? id;
  String? name;
  Pivot? pivot;
  int? status;

  //Object? updated_at;

  Role({
    this.createdAt,
    this.guardName,
    this.id,
    this.name,
    this.pivot,
    this.status,
    */
/*this.updated_at*//*

  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      createdAt: json['created_at'],
      guardName: json['guard_name'],
      id: json['id'],
      name: json['name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
      status: json['status'],
      //updated_at: json['updated_at'] != null ? Object.fromJson(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['guard_name'] = this.guardName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    */
/* if (this.updated_at != null) {
            data['updated_at'] = this.updated_at!.toJson();
     }*//*

    return data;
  }
}
*/

/*class UserDetail {
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

  UserDetail(
      {this.car_color,
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
      this.work_longitude});

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
}*/
