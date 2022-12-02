import 'PaginationModel.dart';

class WalletListModel {
  List<WalletModel>? data;
  PaginationModel? pagination;
  UserWalletModel? walletBalance;

  WalletListModel({this.data, this.pagination, this.walletBalance});

  factory WalletListModel.fromJson(Map<String, dynamic> json) {
    return WalletListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => WalletModel.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination']) : null,
      walletBalance: json['wallet_balance'] != null ? UserWalletModel.fromJson(json['wallet_balance']) : null,
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
    if (this.walletBalance != null) {
      data['wallet_balance'] = this.walletBalance!.toJson();
    }
    return data;
  }
}

class WalletModel {
  var data;
  num? amount;
  num? balance;
  String? createdAt;
  String? currency;
  String? datetime;
  String? description;
  int? id;
  int? rideRequestId;
  String? transactionType;
  String? type;
  String? updatedAt;
  String? userDisplayName;
  int? userId;
  num? walletBalance;

  WalletModel({
    this.data,
    this.amount,
    this.balance,
    this.createdAt,
    this.currency,
    this.datetime,
    this.description,
    this.id,
    this.rideRequestId,
    this.transactionType,
    this.type,
    this.updatedAt,
    this.userDisplayName,
    this.userId,
    this.walletBalance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      data: json['data'],
      amount: json['amount'],
      balance: json['balance'],
      createdAt: json['created_at'],
      currency: json['currency'],
      datetime: json['datetime'],
      description: json['description'],
      id: json['id'],
      rideRequestId: json['ride_request_id'],
      transactionType: json['transaction_type'],
      type: json['type'],
      updatedAt: json['updated_at'],
      userDisplayName: json['user_display_name'],
      userId: json['user_id'],
      walletBalance: json['wallet_balance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['created_at'] = this.createdAt;
    data['currency'] = this.currency;
    data['datetime'] = this.datetime;
    data['description'] = this.description;
    data['id'] = this.id;
    data['ride_request_id'] = this.rideRequestId;
    data['transaction_type'] = this.transactionType;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['user_display_name'] = this.userDisplayName;
    data['user_id'] = this.userId;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}

class UserWalletModel {
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

  UserWalletModel({
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

  factory UserWalletModel.fromJson(Map<String, dynamic> json) {
    return UserWalletModel(
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
