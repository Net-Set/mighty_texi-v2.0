class ProfileUpdate {
  Data? data;
  String? message;

  ProfileUpdate({this.data, this.message});

  ProfileUpdate.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? username;
  String? status;
  String? userType;
  String? address;
  String? contactNumber;
  String? gender;
  String? profileImage;
  String? loginType;
  String? latitude;
  String? longitude;
  String? uid;
  String? playerId;
  int? isOnline;
  int? isAvailable;
  String? timezone;
  String? fcmToken;
  UserDetail? userDetail;
  UserBankAccount? userBankAccount;
  int? serviceId;
  //Null? driverService;
  int? isVerifiedDriver;
  String? lastNotificationSeen;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.displayName,
        this.email,
        this.username,
        this.status,
        this.userType,
        this.address,
        this.contactNumber,
        this.gender,
        this.profileImage,
        this.loginType,
        this.latitude,
        this.longitude,
        this.uid,
        this.playerId,
        this.isOnline,
        this.isAvailable,
        this.timezone,
        this.fcmToken,
        this.userDetail,
        this.userBankAccount,
        this.serviceId,
       // this.driverService,
        this.isVerifiedDriver,
        this.lastNotificationSeen,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    email = json['email'];
    username = json['username'];
    status = json['status'];
    userType = json['user_type'];
    address = json['address'];
    contactNumber = json['contact_number'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    loginType = json['login_type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    uid = json['uid'];
    playerId = json['player_id'];
    isOnline = json['is_online'];
    isAvailable = json['is_available'];
    timezone = json['timezone'];
    fcmToken = json['fcm_token'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    userBankAccount = json['user_bank_account'] != null
        ? new UserBankAccount.fromJson(json['user_bank_account'])
        : null;
    serviceId = json['service_id'];
    //driverService = json['driver_service'];
    isVerifiedDriver = json['is_verified_driver'];
    lastNotificationSeen = json['last_notification_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['address'] = this.address;
    data['contact_number'] = this.contactNumber;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['login_type'] = this.loginType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['uid'] = this.uid;
    data['player_id'] = this.playerId;
    data['is_online'] = this.isOnline;
    data['is_available'] = this.isAvailable;
    data['timezone'] = this.timezone;
    data['fcm_token'] = this.fcmToken;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.userBankAccount != null) {
      data['user_bank_account'] = this.userBankAccount!.toJson();
    }
    data['service_id'] = this.serviceId;
    //data['driver_service'] = this.driverService;
    data['is_verified_driver'] = this.isVerifiedDriver;
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserDetail {
  int? id;
  int? userId;
  String? carModel;
  String? carColor;
  String? carPlateNumber;
  String? carProductionYear;
  String? workAddress;
  String? homeAddress;
  String? workLatitude;
  String? workLongitude;
  String? homeLatitude;
  String? homeLongitude;
  String? createdAt;
  String? updatedAt;

  UserDetail(
      {this.id,
        this.userId,
        this.carModel,
        this.carColor,
        this.carPlateNumber,
        this.carProductionYear,
        this.workAddress,
        this.homeAddress,
        this.workLatitude,
        this.workLongitude,
        this.homeLatitude,
        this.homeLongitude,
        this.createdAt,
        this.updatedAt});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carPlateNumber = json['car_plate_number'];
    carProductionYear = json['car_production_year'];
    workAddress = json['work_address'];
    homeAddress = json['home_address'];
    workLatitude = json['work_latitude'];
    workLongitude = json['work_longitude'];
    homeLatitude = json['home_latitude'];
    homeLongitude = json['home_longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['car_model'] = this.carModel;
    data['car_color'] = this.carColor;
    data['car_plate_number'] = this.carPlateNumber;
    data['car_production_year'] = this.carProductionYear;
    data['work_address'] = this.workAddress;
    data['home_address'] = this.homeAddress;
    data['work_latitude'] = this.workLatitude;
    data['work_longitude'] = this.workLongitude;
    data['home_latitude'] = this.homeLatitude;
    data['home_longitude'] = this.homeLongitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserBankAccount {
  int? id;
  int? userId;
  String? bankName;
  String? bankCode;
  String? accountHolderName;
  String? accountNumber;
  String? createdAt;
  String? updatedAt;

  UserBankAccount(
      {this.id,
        this.userId,
        this.bankName,
        this.bankCode,
        this.accountHolderName,
        this.accountNumber,
        this.createdAt,
        this.updatedAt});

  UserBankAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}