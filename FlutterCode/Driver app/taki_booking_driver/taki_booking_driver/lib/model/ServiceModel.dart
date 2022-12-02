import 'PaginationModel.dart';

class ServiceModel {
  List<ServiceList>? data;
  PaginationModel? pagination;

  ServiceModel({this.data, this.pagination});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => ServiceList.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
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
    return data;
  }
}

class ServiceList {
  int? adminCommission;
  int? baseFare;
  int? cancellationFee;
  int? capacity;
  String? commissionType;
  String? createdAt;
  int? fleetCommission;
  int? id;
  num ? minimumDistance;
  int? minimumFare;
  String? name;
  String? paymentMethod;
  int? perDistance;
  int? perDistancePriorCancel;
  int? perMinuteDrive;
  int? perMinutePriorCancel;
  int? perMinuteWait;
  Region? region;
  int? regionId;
  String? serviceImage;
  int? status;
  String? updatedAt;
  int? waitingTimeLimit;

  ///local
  bool isSelect;

  ServiceList({
    this.adminCommission,
    this.baseFare,
    this.cancellationFee,
    this.capacity,
    this.commissionType,
    this.createdAt,
    this.fleetCommission,
    this.id,
    this.minimumDistance,
    this.minimumFare,
    this.name,
    this.paymentMethod,
    this.perDistance,
    this.perDistancePriorCancel,
    this.perMinuteDrive,
    this.perMinutePriorCancel,
    this.perMinuteWait,
    this.region,
    this.regionId,
    this.serviceImage,
    this.status,
    this.updatedAt,
    this.waitingTimeLimit,
    this.isSelect = false,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      adminCommission: json['admin_commission'],
      baseFare: json['base_fare'],
      cancellationFee: json['cancellation_fee'],
      capacity: json['capacity'],
      commissionType: json['commission_type'],
      createdAt: json['created_at'],
      fleetCommission: json['fleet_commission'],
      id: json['id'],
      minimumDistance: json['minimum_distance'],
      minimumFare: json['minimum_fare'],
      name: json['name'],
      paymentMethod: json['payment_method'],
      perDistance: json['per_distance'],
      perDistancePriorCancel: json['per_distance_prior_cancel'],
      perMinuteDrive: json['per_minute_drive'],
      perMinutePriorCancel: json['per_minute_prior_cancel'],
      perMinuteWait: json['per_minute_wait'],
      region: json['region'] != null ? Region.fromJson(json['region']) : null,
      regionId: json['region_id'],
      serviceImage: json['service_image'],
      status: json['status'],
      updatedAt: json['updated_at'],
      waitingTimeLimit: json['waiting_time_limit'],
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
    data['fleet_commission'] = this.fleetCommission;
    data['id'] = this.id;
    data['minimum_distance'] = this.minimumDistance;
    data['minimum_fare'] = this.minimumFare;
    data['name'] = this.name;
    data['payment_method'] = this.paymentMethod;
    data['per_distance'] = this.perDistance;
    data['per_distance_prior_cancel'] = this.perDistancePriorCancel;
    data['per_minute_drive'] = this.perMinuteDrive;
    data['per_minute_prior_cancel'] = this.perMinutePriorCancel;
    data['per_minute_wait'] = this.perMinuteWait;
    data['region_id'] = this.regionId;
    data['service_image'] = this.serviceImage;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['waiting_time_limit'] = this.waitingTimeLimit;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    return data;
  }
}

class Region {
  String? createdAt;
  String? currencyCode;
  String? currencyName;
  String? distanceUnit;
  int? id;
  String? name;
  int? status;
  String? timezone;
  String? updatedAt;

  Region({this.createdAt, this.currencyCode, this.currencyName, this.distanceUnit, this.id, this.name, this.status, this.timezone, this.updatedAt});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      createdAt: json['created_at'],
      currencyCode: json['currency_code'],
      currencyName: json['currency_name'],
      distanceUnit: json['distance_unit'],
      id: json['id'],
      name: json['name'],
      status: json['status'],
      timezone: json['timezone'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['currency_code'] = this.currencyCode;
    data['currency_name'] = this.currencyName;
    data['distance_unit'] = this.distanceUnit;
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['timezone'] = this.timezone;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
