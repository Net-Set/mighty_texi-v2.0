class LDBaseResponse {
  int? orderId;
  bool? status;
  String? message;

  LDBaseResponse({this.status, this.message,this.orderId});

  LDBaseResponse.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
