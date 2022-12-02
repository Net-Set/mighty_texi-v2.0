class RideHistory {
  int? id;
  int? rideRequestId;
  String? datetime;
  String? historyType;
  String? historyMessage;
  HistoryData? historyData;
  String? createdAt;
  String? updatedAt;

  RideHistory(
      {this.id,
        this.rideRequestId,
        this.datetime,
        this.historyType,
        this.historyMessage,
        this.historyData,
        this.createdAt,
        this.updatedAt});

  RideHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rideRequestId = json['ride_request_id'];
    datetime = json['datetime'];
    historyType = json['history_type'];
    historyMessage = json['history_message'];
    historyData = json['history_data'] != null
        ? new HistoryData.fromJson(json['history_data'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ride_request_id'] = this.rideRequestId;
    data['datetime'] = this.datetime;
    data['history_type'] = this.historyType;
    data['history_message'] = this.historyMessage;
    if (this.historyData != null) {
      data['history_data'] = this.historyData!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class HistoryData {
  int? riderId;
  String? riderName;
  int? driverId;
  String? driverName;

  HistoryData({this.riderId, this.riderName, this.driverId, this.driverName});

  HistoryData.fromJson(Map<String, dynamic> json) {
    riderId = json['rider_id'];
    riderName = json['rider_name'];
    driverId = json['driver_id'];
    driverName = json['driver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rider_id'] = this.riderId;
    data['rider_name'] = this.riderName;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    return data;
  }
}
