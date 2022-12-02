import 'package:taxi_driver/model/PaginationModel.dart';

import 'CouponData.dart';
import 'RiderModel.dart';

class RiderListModel {
  List<RiderModel>? data;
  PaginationModel? pagination;

  RiderListModel({this.data, this.pagination});

  factory RiderListModel.fromJson(Map<String, dynamic> json) {
    return RiderListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => RiderModel.fromJson(i)).toList() : null,
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
