import 'package:taxi_driver/model/PaginationModel.dart';

class DocumentListModel {
  List<DocumentModel>? data;
  PaginationModel? pagination;

  DocumentListModel({this.data, this.pagination});

  factory DocumentListModel.fromJson(Map<String, dynamic> json) {
    return DocumentListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => DocumentModel.fromJson(i)).toList() : null,
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

class DocumentModel {
  String? createdAt;
  int? hasExpiryDate;
  int? id;
  int? isRequired;
  String? name;
  int? status;
  String? updatedAt;

  DocumentModel({this.createdAt, this.hasExpiryDate, this.id, this.isRequired, this.name, this.status, this.updatedAt});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      createdAt: json['created_at'],
      hasExpiryDate: json['has_expiry_date'],
      id: json['id'],
      isRequired: json['is_required'],
      name: json['name'],
      status: json['status'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['has_expiry_date'] = this.hasExpiryDate;
    data['id'] = this.id;
    data['is_required'] = this.isRequired;
    data['name'] = this.name;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
