import 'package:taxi_driver/model/PaginationModel.dart';

class WithDrawListModel {
  List<WithDrawModel>? data;
  PaginationModel? pagination;
  WalletBalance? wallet_balance;

  WithDrawListModel({this.data, this.pagination, this.wallet_balance});

  factory WithDrawListModel.fromJson(Map<String, dynamic> json) {
    return WithDrawListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => WithDrawModel.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
      wallet_balance: json['wallet_balance'] != null ? WalletBalance.fromJson(json['wallet_balance']) : null,
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
    if (this.wallet_balance != null) {
      data['wallet_balance'] = this.wallet_balance!.toJson();
    }
    return data;
  }
}

class WithDrawModel {
  num? amount;
  String? created_at;
  String? currency;
  int? id;
  int? status;
  String? updated_at;
  String? user_display_name;
  int? user_id;

  WithDrawModel({
    this.amount,
    this.created_at,
    this.currency,
    this.id,
    this.status,
    this.updated_at,
    this.user_display_name,
    this.user_id,
  });

  factory WithDrawModel.fromJson(Map<String, dynamic> json) {
    return WithDrawModel(
      amount: json['amount'],
      created_at: json['created_at'],
      currency: json['currency'],
      id: json['id'],
      status: json['status'],
      updated_at: json['updated_at'],
      user_display_name: json['user_display_name'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['created_at'] = this.created_at;
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['status'] = this.status;
    data['updated_at'] = this.updated_at;
    data['user_display_name'] = this.user_display_name;
    data['user_id'] = this.user_id;
    return data;
  }
}

class WalletBalance {
  String? collectedCash;
  String? createdAt;
  String? currency;
  int? id;
  String? manualReceived;
  String? onlineReceived;
  num? totalAmount;
  num? totalWithdrawn;
  String? updatedAt;
  int? userId;

  WalletBalance({
    this.collectedCash,
    this.createdAt,
    this.currency,
    this.id,
    this.manualReceived,
    this.onlineReceived,
    this.totalAmount,
    this.totalWithdrawn,
    this.updatedAt,
    this.userId,
  });

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      collectedCash: json['collected_cash'],
      createdAt: json['created_at'],
      currency: json['currency'],
      id: json['id'],
      manualReceived: json['manual_received'],
      onlineReceived: json['online_received'],
      totalAmount: json['total_amount'],
      totalWithdrawn: json['total_withdrawn'],
      updatedAt: json['updated_at'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collected_cash'] = this.collectedCash;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['manual_received'] = this.manualReceived;
    data['online_received'] = this.onlineReceived;
    data['total_amount'] = this.totalAmount;
    data['total_withdrawn'] = this.totalWithdrawn;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}
