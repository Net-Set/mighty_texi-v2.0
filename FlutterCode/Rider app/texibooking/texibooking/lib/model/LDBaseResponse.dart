class LDBaseResponse {
  int? rideRequestId;
  bool? status;
  String? message;

  LDBaseResponse({this.status, this.message,this.rideRequestId});

  LDBaseResponse.fromJson(Map<String, dynamic> json) {
    rideRequestId = json['riderequest_id'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.rideRequestId;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
