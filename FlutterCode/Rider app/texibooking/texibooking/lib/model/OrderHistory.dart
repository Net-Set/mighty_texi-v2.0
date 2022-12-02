class RideHistory {
  String? createdAt;
  String? datetime;
  HistoryData? historyData;
  String? historyMessage;
  String? historyType;
  int? id;
  int? rideRequestId;
  String? updatedAt;

  RideHistory({
    this.createdAt,
    this.datetime,
    this.historyData,
    this.historyMessage,
    this.historyType,
    this.id,
    this.rideRequestId,
    this.updatedAt,
  });

  factory RideHistory.fromJson(Map<String, dynamic> json) {
    return RideHistory(
      createdAt: json['created_at'],
      datetime: json['datetime'],
      historyData: json['history_data'] != null ? HistoryData.fromJson(json['history_data']) : null,
      historyMessage: json['history_message'],
      historyType: json['history_type'],
      id: json['id'],
      rideRequestId: json['ride_request_id'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['datetime'] = this.datetime;
    data['history_message'] = this.historyMessage;
    data['history_type'] = this.historyType;
    data['id'] = this.id;
    data['ride_request_id'] = this.rideRequestId;
    data['updated_at'] = this.updatedAt;
    if (this.historyData != null) {
      data['history_data'] = this.historyData!.toJson();
    }
    return data;
  }
}

class HistoryData {
  int? driverId;
  String? driverName;

  HistoryData({this.driverId, this.driverName});

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      driverId: json['driver_id'],
      driverName: json['driver_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    return data;
  }
}
