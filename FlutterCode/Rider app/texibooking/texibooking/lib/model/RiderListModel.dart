import 'package:taxibooking/model/OrderHistory.dart';
import 'package:taxibooking/model/RiderModel.dart';

import 'CouponData.dart';
import 'PaginationModel.dart';

class RiderListModel {
  List<RiderModel>? data;
  PaginationModel? pagination;
  List<RideHistory>? rideHistory;

  RiderListModel({this.data, this.pagination, this.rideHistory});

  factory RiderListModel.fromJson(Map<String, dynamic> json) {
    return RiderListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => RiderModel.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
      rideHistory: json['ride_history'] != null ? (json['ride_history'] as List).map((i) => RideHistory.fromJson(i)).toList() : null,
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
    if (this.rideHistory != null) {
      data['ride_history'] = this.rideHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
