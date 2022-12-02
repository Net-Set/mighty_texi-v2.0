import 'package:taxi_driver/model/PaginationModel.dart';

class AdditionalFeesList {
  List<AdditionalFeesModel>? data;
  PaginationModel? pagination;

  AdditionalFeesList({this.data, this.pagination});

  factory AdditionalFeesList.fromJson(Map<String, dynamic> json) {
    return AdditionalFeesList(
      data: json['data'] != null ? (json['data'] as List).map((i) => AdditionalFeesModel.fromJson(i)).toList() : null,
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

class AdditionalFeesModel {
  String? createdAt;
  int? id;
  int? status;
  String? title;
  String? updatedAt;

  AdditionalFeesModel({this.createdAt, this.id, this.status, this.title, this.updatedAt});

  factory AdditionalFeesModel.fromJson(Map<String, dynamic> json) {
    return AdditionalFeesModel(
      createdAt: json['created_at'],
      id: json['id'],
      status: json['status'],
      title: json['title'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
