class CouponData {
  String? code;
  String? couponType;
  String? createdAt;
  String? description;
  num? discount;
  String? discountType;
  String? endDate;
  int? id;
  int? maximumDiscount;
  int? minimumAmount;
  int? regionIds;
  int? serviceIds;
  String? startDate;
  int? status;
  String? title;
  String? updatedAt;
  int? usageLimitPerRider;

  CouponData({
    this.code,
    this.couponType,
    this.createdAt,
    this.description,
    this.discount,
    this.discountType,
    this.endDate,
    this.id,
    this.maximumDiscount,
    this.minimumAmount,
    this.regionIds,
    this.serviceIds,
    this.startDate,
    this.status,
    this.title,
    this.updatedAt,
    this.usageLimitPerRider,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) {
    return CouponData(
      code: json['code'],
      couponType: json['coupon_type'],
      createdAt: json['created_at'],
      description: json['description'],
      discount: json['discount'],
      discountType: json['discount_type'],
      endDate: json['end_date'],
      id: json['id'],
      maximumDiscount: json['maximum_discount'],
      minimumAmount: json['minimum_amount'],
      regionIds: json['region_ids'],
      serviceIds: json['service_ids'],
      startDate: json['start_date'],
      status: json['status'],
      title: json['title'],
      updatedAt: json['updated_at'],
      usageLimitPerRider: json['usage_limit_per_rider'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['coupon_type'] = this.couponType;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['end_date'] = this.endDate;
    data['id'] = this.id;
    data['maximum_discount'] = this.maximumDiscount;
    data['minimum_amount'] = this.minimumAmount;
    data['region_ids'] = this.regionIds;
    data['service_ids'] = this.serviceIds;
    data['start_date'] = this.startDate;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    data['usage_limit_per_rider'] = this.usageLimitPerRider;
    return data;
  }
}
