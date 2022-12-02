class ComplaintModel {
  String? complaintBy;
  String? createdAt;
  String? description;
  int? driverId;
  String? driverName;
  String? driverProfileImage;
  int? id;
  int? rideRequestId;
  int? riderId;
  String? riderName;
  String? riderProfileImage;
  String? status;
  String? subject;
  String? updatedAt;

  ComplaintModel({
    this.complaintBy,
    this.createdAt,
    this.description,
    this.driverId,
    this.driverName,
    this.driverProfileImage,
    this.id,
    this.rideRequestId,
    this.riderId,
    this.riderName,
    this.riderProfileImage,
    this.status,
    this.subject,
    this.updatedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintBy: json['complaint_by'],
      createdAt: json['created_at'],
      description: json['description'],
      driverId: json['driver_id'],
      driverName: json['driver_name'],
      driverProfileImage: json['driver_profile_image'],
      id: json['id'],
      rideRequestId: json['ride_request_id'],
      riderId: json['rider_id'],
      riderName: json['rider_name'],
      riderProfileImage: json['rider_profile_image'],
      status: json['status'],
      subject: json['subject'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complaint_by'] = this.complaintBy;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['driver_profile_image'] = this.driverProfileImage;
    data['id'] = this.id;
    data['ride_request_id'] = this.rideRequestId;
    data['rider_id'] = this.riderId;
    data['rider_name'] = this.riderName;
    data['rider_profile_image'] = this.riderProfileImage;
    data['status'] = this.status;
    data['subject'] = this.subject;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
