import 'package:taxibooking/model/CouponData.dart';
import 'package:taxibooking/model/ExtraChargeRequestModel.dart';

class CurrentRequestModel {
  int? id;
  String? displayName;
  String? email;
  String? username;
  String? userType;
  String? profileImage;
  String? status;
  OnRideRequest? rideRequest;
  OnRideRequest? onRideRequest;
  Driver? driver;
  Payment? payment;

  CurrentRequestModel({
    this.id,
    this.displayName,
    this.email,
    this.username,
    this.userType,
    this.profileImage,
    this.status,
    this.rideRequest,
    this.onRideRequest,
    this.driver,
    this.payment,
  });

  CurrentRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    email = json['email'];
    username = json['username'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    status = json['status'];
    rideRequest = json['ride_request'] != null ? new OnRideRequest.fromJson(json['ride_request']) : null;
    onRideRequest = json['on_ride_request'] != null ? new OnRideRequest.fromJson(json['on_ride_request']) : null;
    driver = json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    payment = json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['user_type'] = this.userType;
    data['profile_image'] = this.profileImage;
    data['status'] = this.status;
    if (this.rideRequest != null) {
      data['ride_request'] = this.rideRequest!.toJson();
    }
    if (this.onRideRequest != null) {
      data['on_ride_request'] = this.onRideRequest!.toJson();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class OnRideRequest {
  int? id;
  int? riderId;
  int? serviceId;
  String? datetime;
  int? isSchedule;
  int? rideAttempt;
  String? otp;
  num? totalAmount;
  num? subtotal;
  num? extraChargesAmount;
  int? driverId;
  String? driverName;
  String? riderName;
  String? driverProfileImage;
  String? riderProfileImage;
  String? startLatitude;
  String? startLongitude;
  String? startAddress;
  String? endLatitude;
  String? endLongitude;
  String? endAddress;
  String? distanceUnit;
  String? startTime;
  String? endTime;
  num? distance;
  int? duration;
  int? seatCount;
  String? reason;
  String? status;
  int? baseFare;
  int? minimumFare;
  int? perDistance;
  int? perMinuteDrive;
  num? perMinuteWaiting;
  int? waitingTime;
  int? waitingTimeLimit;
  num? waitingTimeCharges;
  num? cancelationCharges;
  String? cancelBy;
  int? paymentId;
  String? paymentType;
  String? paymentStatus;
  List<ExtraChargeRequestModel>? extraCharges;
  num? couponDiscount;
  int? couponCode;
  CouponData? couponData;
  int? isRiderRated;
  int? isDriverRated;
  int? maxTimeForFindDriverForRideRequest;
  String? createdAt;
  String? updatedAt;
  num? perMinuteWaitingCharge;
  num? perMinuteDriveCharge;
  num? perDistanceCharge;
  String? driverContactNumber;
  String? riderContactNumber;
  String? driverEmail;
  String? riderEmail;

  OnRideRequest({
    this.id,
    this.riderId,
    this.serviceId,
    this.datetime,
    this.isSchedule,
    this.rideAttempt,
    this.otp,
    this.totalAmount,
    this.subtotal,
    this.extraChargesAmount,
    this.driverId,
    this.driverName,
    this.riderName,
    this.driverProfileImage,
    this.riderProfileImage,
    this.startLatitude,
    this.startLongitude,
    this.startAddress,
    this.endLatitude,
    this.endLongitude,
    this.endAddress,
    this.distanceUnit,
    this.startTime,
    this.endTime,
    this.distance,
    this.duration,
    this.seatCount,
    this.reason,
    this.status,
    this.baseFare,
    this.minimumFare,
    this.perDistance,
    this.perMinuteDrive,
    this.perMinuteWaiting,
    this.waitingTime,
    this.waitingTimeLimit,
    this.waitingTimeCharges,
    this.cancelationCharges,
    this.cancelBy,
    this.paymentId,
    this.paymentType,
    this.paymentStatus,
    this.extraCharges,
    this.couponDiscount,
    this.couponCode,
    this.couponData,
    this.isRiderRated,
    this.isDriverRated,
    this.maxTimeForFindDriverForRideRequest,
    this.createdAt,
    this.updatedAt,
    this.perDistanceCharge,
    this.perMinuteDriveCharge,
    this.perMinuteWaitingCharge,
    this.driverContactNumber,
    this.riderContactNumber,
    this.driverEmail,
    this.riderEmail,
  });

  OnRideRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    riderId = json['rider_id'];
    serviceId = json['service_id'];
    datetime = json['datetime'];
    isSchedule = json['is_schedule'];
    rideAttempt = json['ride_attempt'];
    otp = json['otp'];
    totalAmount = json['total_amount'];
    subtotal = json['subtotal'];
    extraChargesAmount = json['extra_charges_amount'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    riderName = json['rider_name'];
    driverProfileImage = json['driver_profile_image'];
    riderProfileImage = json['rider_profile_image'];
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    startAddress = json['start_address'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    endAddress = json['end_address'];
    distanceUnit = json['distance_unit'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    distance = json['distance'];
    duration = json['duration'];
    seatCount = json['seat_count'];
    reason = json['reason'];
    status = json['status'];
    baseFare = json['base_fare'];
    minimumFare = json['minimum_fare'];
    perDistance = json['per_distance'];
    perMinuteDrive = json['per_minute_drive'];
    perMinuteWaiting = json['per_minute_waiting'];
    waitingTime = json['waiting_time'];
    waitingTimeLimit = json['waiting_time_limit'];
    waitingTimeCharges = json['waiting_time_charges'];
    cancelationCharges = json['cancelation_charges'];
    cancelBy = json['cancel_by'];
    paymentId = json['payment_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    if (json['extra_charges'] != null) {
      extraCharges = <ExtraChargeRequestModel>[];
      json['extra_charges'].forEach((v) {
        extraCharges!.add(new ExtraChargeRequestModel.fromJson(v));
      });
    }
    couponDiscount = json['coupon_discount'];
    couponCode = json['coupon_code'];
    couponData = json['coupon_data'] != null ? CouponData.fromJson(json['coupon_data']) : null;
    isRiderRated = json['is_rider_rated'];
    isDriverRated = json['is_driver_rated'];
    maxTimeForFindDriverForRideRequest = json['max_time_for_find_driver_for_ride_request'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    perDistanceCharge = json['per_distance_charge'];
    perMinuteDriveCharge = json['per_minute_drive_charge'];
    perMinuteWaitingCharge = json['per_minute_waiting_charge'];
    driverContactNumber = json['driver_contact_number'];
    riderContactNumber = json['rider_contact_number'];
    riderEmail = json['rider_email'];
    driverEmail = json['driver_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rider_id'] = this.riderId;
    data['service_id'] = this.serviceId;
    data['datetime'] = this.datetime;
    data['is_schedule'] = this.isSchedule;
    data['ride_attempt'] = this.rideAttempt;
    data['otp'] = this.otp;
    data['total_amount'] = this.totalAmount;
    data['subtotal'] = this.subtotal;
    data['extra_charges_amount'] = this.extraChargesAmount;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['rider_name'] = this.riderName;
    data['driver_profile_image'] = this.driverProfileImage;
    data['rider_profile_image'] = this.riderProfileImage;
    data['start_latitude'] = this.startLatitude;
    data['start_longitude'] = this.startLongitude;
    data['start_address'] = this.startAddress;
    data['end_latitude'] = this.endLatitude;
    data['end_longitude'] = this.endLongitude;
    data['end_address'] = this.endAddress;
    data['distance_unit'] = this.distanceUnit;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['seat_count'] = this.seatCount;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['base_fare'] = this.baseFare;
    data['minimum_fare'] = this.minimumFare;
    data['per_distance'] = this.perDistance;
    data['per_minute_drive'] = this.perMinuteDrive;
    data['per_minute_waiting'] = this.perMinuteWaiting;
    data['waiting_time'] = this.waitingTime;
    data['waiting_time_limit'] = this.waitingTimeLimit;
    data['waiting_time_charges'] = this.waitingTimeCharges;
    data['cancelation_charges'] = this.cancelationCharges;
    data['cancel_by'] = this.cancelBy;
    data['payment_id'] = this.paymentId;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    if (this.extraCharges != null) {
      data['extra_charges'] = this.extraCharges!.map((v) => v.toJson()).toList();
    }
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_code'] = this.couponCode;
    data['coupon_data'] = this.couponData;
    data['is_rider_rated'] = this.isRiderRated;
    data['is_driver_rated'] = this.isDriverRated;
    data['max_time_for_find_driver_for_ride_request'] = this.maxTimeForFindDriverForRideRequest;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['per_distance_charge'] = this.perDistanceCharge;
    data['per_minute_drive_charge'] = this.perMinuteDriveCharge;
    data['per_minute_waiting_charge'] = this.perMinuteWaitingCharge;
    data['rider_contact_number'] = this.riderContactNumber;
    data['driver_contact_number'] = this.driverContactNumber;
    data['driver_email'] = this.driverEmail;
    data['rider_email'] = this.riderEmail;
    return data;
  }
}

class Driver {
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
  var userBankAccount;
  int? serviceId;
  DriverService? driverService;
  int? isVerifiedDriver;
  var lastNotificationSeen;
  String? createdAt;
  String? updatedAt;

  Driver({
    this.id,
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
    this.driverService,
    this.isVerifiedDriver,
    this.lastNotificationSeen,
    this.createdAt,
    this.updatedAt,
  });

  Driver.fromJson(Map<String, dynamic> json) {
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
    userDetail = json['user_detail'] != null ? new UserDetail.fromJson(json['user_detail']) : null;
    userBankAccount = json['user_bank_account'];
    serviceId = json['service_id'];
    driverService = json['driver_service'] != null ? new DriverService.fromJson(json['driver_service']) : null;
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
    data['user_bank_account'] = this.userBankAccount;
    data['service_id'] = this.serviceId;
    if (this.driverService != null) {
      data['driver_service'] = this.driverService!.toJson();
    }
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

  UserDetail({
    this.id,
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
    this.updatedAt,
  });

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

class DriverService {
  int? id;
  String? name;
  int? regionId;
  int? capacity;
  int? baseFare;
  int? minimumFare;
  int? minimumDistance;
  int? perDistance;
  int? perMinuteDrive;
  int? perMinuteWait;
  int? waitingTimeLimit;
  int? cancellationFee;
  int? perMinutePriorCancel;
  int? perDistancePriorCancel;
  String? paymentMethod;
  String? commissionType;
  int? adminCommission;
  int? fleetCommission;
  int? status;
  String? createdAt;
  String? updatedAt;

  DriverService({
    this.id,
    this.name,
    this.regionId,
    this.capacity,
    this.baseFare,
    this.minimumFare,
    this.minimumDistance,
    this.perDistance,
    this.perMinuteDrive,
    this.perMinuteWait,
    this.waitingTimeLimit,
    this.cancellationFee,
    this.perMinutePriorCancel,
    this.perDistancePriorCancel,
    this.paymentMethod,
    this.commissionType,
    this.adminCommission,
    this.fleetCommission,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  DriverService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    regionId = json['region_id'];
    capacity = json['capacity'];
    baseFare = json['base_fare'];
    minimumFare = json['minimum_fare'];
    minimumDistance = json['minimum_distance'];
    perDistance = json['per_distance'];
    perMinuteDrive = json['per_minute_drive'];
    perMinuteWait = json['per_minute_wait'];
    waitingTimeLimit = json['waiting_time_limit'];
    cancellationFee = json['cancellation_fee'];
    perMinutePriorCancel = json['per_minute_prior_cancel'];
    perDistancePriorCancel = json['per_distance_prior_cancel'];
    paymentMethod = json['payment_method'];
    commissionType = json['commission_type'];
    adminCommission = json['admin_commission'];
    fleetCommission = json['fleet_commission'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['region_id'] = this.regionId;
    data['capacity'] = this.capacity;
    data['base_fare'] = this.baseFare;
    data['minimum_fare'] = this.minimumFare;
    data['minimum_distance'] = this.minimumDistance;
    data['per_distance'] = this.perDistance;
    data['per_minute_drive'] = this.perMinuteDrive;
    data['per_minute_wait'] = this.perMinuteWait;
    data['waiting_time_limit'] = this.waitingTimeLimit;
    data['cancellation_fee'] = this.cancellationFee;
    data['per_minute_prior_cancel'] = this.perMinutePriorCancel;
    data['per_distance_prior_cancel'] = this.perDistancePriorCancel;
    data['payment_method'] = this.paymentMethod;
    data['commission_type'] = this.commissionType;
    data['admin_commission'] = this.adminCommission;
    data['fleet_commission'] = this.fleetCommission;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Payment {
  int? id;
  int? rideRequestId;
  int? riderId;
  String? riderName;
  String? datetime;
  num? totalAmount;
  var receivedBy;
  num? adminCommission;
  num? fleetCommission;
  num? driverFee;
  int? driverTips;
  var driverCommission;
  var txnId;
  String? paymentType;
  String? paymentStatus;
  var transactionDetail;
  String? createdAt;
  String? updatedAt;

  Payment({
    this.id,
    this.rideRequestId,
    this.riderId,
    this.riderName,
    this.datetime,
    this.totalAmount,
    this.receivedBy,
    this.adminCommission,
    this.fleetCommission,
    this.driverFee,
    this.driverTips,
    this.driverCommission,
    this.txnId,
    this.paymentType,
    this.paymentStatus,
    this.transactionDetail,
    this.createdAt,
    this.updatedAt,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rideRequestId = json['ride_request_id'];
    riderId = json['rider_id'];
    riderName = json['rider_name'];
    datetime = json['datetime'];
    totalAmount = json['total_amount'];
    receivedBy = json['received_by'];
    adminCommission = json['admin_commission'];
    fleetCommission = json['fleet_commission'];
    driverFee = json['driver_fee'];
    driverTips = json['driver_tips'];
    driverCommission = json['driver_commission'];
    txnId = json['txn_id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    transactionDetail = json['transaction_detail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ride_request_id'] = this.rideRequestId;
    data['rider_id'] = this.riderId;
    data['rider_name'] = this.riderName;
    data['datetime'] = this.datetime;
    data['total_amount'] = this.totalAmount;
    data['received_by'] = this.receivedBy;
    data['admin_commission'] = this.adminCommission;
    data['fleet_commission'] = this.fleetCommission;
    data['driver_fee'] = this.driverFee;
    data['driver_tips'] = this.driverTips;
    data['driver_commission'] = this.driverCommission;
    data['txn_id'] = this.txnId;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['transaction_detail'] = this.transactionDetail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
