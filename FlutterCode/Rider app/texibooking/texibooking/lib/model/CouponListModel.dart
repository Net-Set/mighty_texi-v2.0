import 'package:taxibooking/model/CouponData.dart';
import 'package:taxibooking/model/PaginationModel.dart';

class CouponListModel {
  List<CouponData>? data;
  PaginationModel? pagination;

  CouponListModel({this.data, this.pagination});

  factory CouponListModel.fromJson(Map<String, dynamic> json) {
    return CouponListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => CouponData.fromJson(i)).toList() : null,
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
