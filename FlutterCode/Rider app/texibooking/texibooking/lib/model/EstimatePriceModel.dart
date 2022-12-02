import 'package:taxibooking/model/PaginationModel.dart';

import 'CouponData.dart';

class EstimatePriceModel {
  List<ServicesListData>? data;
  PaginationModel? pagination;
  String? message;

  EstimatePriceModel({this.data, this.pagination, this.message});

  factory EstimatePriceModel.fromJson(Map<String, dynamic> json) {
    return EstimatePriceModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => ServicesListData.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ServicesListData {
  double? adminCommission;
  int? baseFare;
  int? cancellationFee;
  int? capacity;
  String? commissionType;
  String? createdAt;
  num? discountAmount;
  var distance;
  var distancePrice;
  num? duration;
  int? fleetCommission;
  int? id;
  var minimumDistance;
  var minimumDistanceInKm;
  int? minimumFare;
  String? name;
  String? paymentMethod;
  int? perDistance;
  int? perMinuteDrive;
  int? perMinuteWait;
  int? pickupDuration;
  Region? region;
  int? regionId;
  String? serviceImage;
  var status;
  num? subtotal;
  num? timePrice;
  num? totalAmount;
  String? updatedAt;
  int? waitDuration;
  int? waitingTimeLimit;
  String? startLatitude;
  String? startLongitude;
  String? startAddress;
  String? endLatitude;
  String? endLongitude;
  String? endAddress;
  CouponData? couponData;
  int? serviceId;

  ServicesListData({
    this.adminCommission,
    this.baseFare,
    this.cancellationFee,
    this.capacity,
    this.commissionType,
    this.createdAt,
    this.discountAmount,
    this.distance,
    this.distancePrice,
    this.duration,
    this.fleetCommission,
    this.id,
    this.minimumDistance,
    this.minimumDistanceInKm,
    this.minimumFare,
    this.name,
    this.paymentMethod,
    this.perDistance,
    this.perMinuteDrive,
    this.perMinuteWait,
    this.pickupDuration,
    this.region,
    this.regionId,
    this.serviceImage,
    this.status,
    this.subtotal,
    this.timePrice,
    this.totalAmount,
    this.updatedAt,
    this.waitDuration,
    this.waitingTimeLimit,
    this.couponData,
    this.endAddress,
    this.endLongitude,
    this.startAddress,
    this.startLatitude,
    this.startLongitude,
    this.serviceId,
    this.endLatitude,
  });

  factory ServicesListData.fromJson(Map<String, dynamic> json) {
    return ServicesListData(
      adminCommission: json['admin_commission'],
      baseFare: json['base_fare'],
      cancellationFee: json['cancellation_fee'],
      capacity: json['capacity'],
      commissionType: json['commission_type'],
      createdAt: json['created_at'],
      discountAmount: json['discount_amount'],
      distance: json['distance'],
      distancePrice: json['distance_price'],
      duration: json['duration'],
      fleetCommission: json['fleet_commission'],
      id: json['id'],
      minimumDistance: json['minimum_distance'],
      minimumDistanceInKm: json['minimum_distance_in_km'],
      minimumFare: json['minimum_fare'],
      name: json['name'],
      paymentMethod: json['payment_method'],
      perDistance: json['per_distance'],
      perMinuteDrive: json['per_minute_drive'],
      perMinuteWait: json['per_minute_wait'],
      pickupDuration: json['pickup_duration'],
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      regionId: json['region_id'],
      serviceImage: json['service_image'],
      status: json['status'],
      subtotal: json['subtotal'],
      timePrice: json['time_price'],
      totalAmount: json['total_amount'],
      updatedAt: json['updated_at'],
      waitDuration: json['wait_duration'],
      waitingTimeLimit: json['waiting_time_limit'],
      serviceId: json['service_id'],
      endAddress: json['end_address'],
      endLongitude: json['end_longitude'],
      startAddress: json['start_address'],
      startLatitude: json['start_latitude'],
      startLongitude: json['start_longitude'],
      endLatitude: json['end_latitude'],
      couponData: json['coupon_data'] != null ? CouponData.fromJson(json['coupon_data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_commission'] = this.adminCommission;
    data['base_fare'] = this.baseFare;
    data['cancellation_fee'] = this.cancellationFee;
    data['capacity'] = this.capacity;
    data['commission_type'] = this.commissionType;
    data['created_at'] = this.createdAt;
    data['discount_amount'] = this.discountAmount;
    data['distance'] = this.distance;
    data['distance_price'] = this.distancePrice;
    data['duration'] = this.duration;
    data['fleet_commission'] = this.fleetCommission;
    data['id'] = this.id;
    data['minimum_distance'] = this.minimumDistance;
    data['minimum_distance_in_km'] = this.minimumDistanceInKm;
    data['minimum_fare'] = this.minimumFare;
    data['name'] = this.name;
    data['payment_method'] = this.paymentMethod;
    data['per_distance'] = this.perDistance;
    data['per_minute_drive'] = this.perMinuteDrive;
    data['per_minute_wait'] = this.perMinuteWait;
    data['pickup_duration'] = this.pickupDuration;
    data['region_id'] = this.regionId;
    data['service_image'] = this.serviceImage;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['time_price'] = this.timePrice;
    data['total_amount'] = this.totalAmount;
    data['updated_at'] = this.updatedAt;
    data['wait_duration'] = this.waitDuration;
    data['waiting_time_limit'] = this.waitingTimeLimit;
    data['service_id'] = this.serviceId;
    data['start_address'] = this.startAddress;
    data['start_latitude'] = this.startLatitude;
    data['start_longitude'] = this.startLongitude;
    data['end_address'] = this.endAddress;
    data['end_latitude'] = this.endLatitude;
    data['end_longitude'] = this.endLongitude;
    data['service_id'] = this.serviceId;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.couponData != null) {
      data['coupon_data'] = this.region!.toJson();
    }
    return data;
  }
}

class Region {
  String? createdAt;
  String? distanceUnit;
  int? id;
  String? name;
  int? status;
  String? timezone;
  String? updated_at;

  Region({this.createdAt, this.distanceUnit, this.id, this.name, this.status, this.timezone, this.updated_at});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      createdAt: json['created_at'],
      distanceUnit: json['distance_unit'],
      id: json['id'],
      name: json['name'],
      status: json['status'],
      timezone: json['timezone'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['distance_unit'] = this.distanceUnit;
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['timezone'] = this.timezone;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
