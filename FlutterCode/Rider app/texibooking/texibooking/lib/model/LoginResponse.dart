class LoginResponse {
  UserModel? data;
  String? message;
  bool? isUserExist;

  LoginResponse({this.data, this.message, this.isUserExist});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
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

class UserModel {
  var id;
  String? firstName;
  String? lastName;
  String? email;
  String? contactNumber;
  String? username;
  String? gender;
  String? emailVerifiedAt;
  String? address;
  String? userType;
  String? playerId;
  String? fleetId;
  String? latitude;
  String? longitude;
  String? lastNotificationSeen;
  String? status;
  int? isOnline;
  String? uid;
  String? displayName;
  String? loginType;
  String? timezone;
  String? createdAt;
  String? updatedAt;
  String? apiToken;
  String? profileImage;
  int? isVerifiedDriver;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.contactNumber,
    this.gender,
    this.emailVerifiedAt,
    this.address,
    this.userType,
    this.playerId,
    this.fleetId,
    this.latitude,
    this.longitude,
    this.lastNotificationSeen,
    this.status,
    this.isOnline,
    this.uid,
    this.displayName,
    this.loginType,
    this.timezone,
    this.createdAt,
    this.updatedAt,
    this.apiToken,
    this.profileImage,
    this.isVerifiedDriver,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      username: json['username'],
      contactNumber: json['contact_number'],
      gender: json['gender'],
      emailVerifiedAt: json['email_verified_at'],
      address: json['address'],
      userType: json['user_type'],
      playerId: json['player_id'],
      fleetId: json['fleet_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      lastNotificationSeen: json['last_notification_seen'],
      status: json['status'],
      isOnline: json['is_online'],
      uid: json['uid'],
      displayName: json['display_name'],
      loginType: json['login_type'],
      timezone: json['timezone'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      apiToken: json['api_token'],
      profileImage: json['profile_image'],
      isVerifiedDriver: json['is_verified_driver'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['contact_number'] = this.contactNumber;
    data['gender'] = this.gender;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['address'] = this.address;
    data['user_type'] = this.userType;
    data['player_id'] = this.playerId;
    data['fleet_id'] = this.fleetId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['status'] = this.status;
    data['is_online'] = this.isOnline;
    data['uid'] = this.uid;
    data['display_name'] = this.displayName;
    data['login_type'] = this.loginType;
    data['timezone'] = this.timezone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['api_token'] = this.apiToken;
    data['profile_image'] = this.profileImage;
    data['is_verified_driver'] = this.isVerifiedDriver;
    return data;
  }
}

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
    /*this.updated_at*/
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
    /* if (this.updated_at != null) {
            data['updated_at'] = this.updated_at!.toJson();
     }*/
    return data;
  }
}
