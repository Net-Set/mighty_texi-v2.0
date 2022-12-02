import 'package:taxi_driver/model/PaginationModel.dart';

class DriverDocumentList {
  List<DriverDocumentModel>? data;
  PaginationModel? pagination;

  DriverDocumentList({this.data, this.pagination});

  factory DriverDocumentList.fromJson(Map<String, dynamic> json) {
    return DriverDocumentList(
      data: json['data'] != null ? (json['data'] as List).map((i) => DriverDocumentModel.fromJson(i)).toList() : null,
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

class DriverDocumentModel {
  String? createdAt;
  int? documentId;
  String? documentName;
  String? driverDocument;
  int? driverId;
  String? driverName;
  String? expireDate;
  int? id;
  int? isVerified;
  String? updatedAt;

  DriverDocumentModel({
    this.createdAt,
    this.documentId,
    this.documentName,
    this.driverDocument,
    this.driverId,
    this.driverName,
    this.expireDate,
    this.id,
    this.isVerified,
    this.updatedAt,
  });

  factory DriverDocumentModel.fromJson(Map<String, dynamic> json) {
    return DriverDocumentModel(
      createdAt: json['created_at'],
      documentId: json['document_id'],
      documentName: json['document_name'],
      driverDocument: json['driver_document'],
      driverId: json['driver_id'],
      driverName: json['driver_name'],
      expireDate: json['expire_date'],
      id: json['id'],
      isVerified: json['is_verified'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['document_id'] = this.documentId;
    data['document_name'] = this.documentName;
    data['driver_document'] = this.driverDocument;
    data['driver_id'] = this.driverId;
    data['driver_name'] = this.driverName;
    data['expire_date'] = this.expireDate;
    data['id'] = this.id;
    data['is_verified'] = this.isVerified;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
