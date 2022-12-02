class DriverRatting {
  String? comment;
  String? createdAt;
  int? driverId;
  int? id;
  int? rating;
  int? rideRequestId;
  int? riderId;
  String? updatedAt;

  DriverRatting({
    this.comment,
    this.createdAt,
    this.driverId,
    this.id,
    this.rating,
    this.rideRequestId,
    this.riderId,
    this.updatedAt,
  });

  factory DriverRatting.fromJson(Map<String, dynamic> json) {
    return DriverRatting(
      comment: json['comment'],
      createdAt: json['created_at'],
      driverId: json['driver_id'],
      id: json['id'],
      rating: json['rating'],
      rideRequestId: json['ride_request_id'],
      riderId: json['rider_id'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['driver_id'] = this.driverId;
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['ride_request_id'] = this.rideRequestId;
    data['rider_id'] = this.riderId;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
