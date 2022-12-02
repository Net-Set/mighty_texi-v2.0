
import 'PaginationModel.dart';

class ContactNumberListModel {
  List<ContactModel>? data;
  PaginationModel? pagination;

  ContactNumberListModel({this.data, this.pagination});

  factory ContactNumberListModel.fromJson(Map<String, dynamic> json) {
    return ContactNumberListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => ContactModel.fromJson(i)).toList() : null,
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

class ContactModel {
  int? addedBy;
  String? contactNumber;
  String? createdAt;
  int? id;
  String? region;
  String? regionId;
  String? status;
  String? title;
  String? updatedAt;

  ContactModel({
    this.addedBy,
    this.contactNumber,
    this.createdAt,
    this.id,
    this.region,
    this.regionId,
    this.status,
    this.title,
    this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      addedBy: json['added_by'],
      contactNumber: json['contact_number'],
      createdAt: json['created_at'],
      id: json['id'],
      region: json['region'],
      regionId: json['region_id'],
      status: json['status'],
      title: json['title'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['added_by'] = this.addedBy;
    data['contact_number'] = this.contactNumber;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['region'] = this.region;
    data['region_id'] = this.regionId;
    data['status'] = this.status;
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
