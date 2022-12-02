import 'PaginationModel.dart';

class PaymentListModel {
  List<PaymentModel>? data;
  PaginationModel? pagination;

  PaymentListModel({this.data, this.pagination});

  factory PaymentListModel.fromJson(Map<String, dynamic> json) {
    return PaymentListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => PaymentModel.fromJson(i)).toList() : null,
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

class PaymentModel {
  String? createdAt;
  String? gatewayLogo;
  int? id;
  int? isTest;
  LiveValue? liveValue;
  int? status;
  LiveValue? testValue;
  String? title;
  String? type;
  String? updatedAt;

  PaymentModel({
    this.createdAt,
    this.gatewayLogo,
    this.id,
    this.isTest,
    this.liveValue,
    this.status,
    this.testValue,
    this.title,
    this.type,
    this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      createdAt: json['created_at'],
      gatewayLogo: json['gateway_image'],
      id: json['id'],
      isTest: json['is_test'],
      liveValue: json['live_value'] != null ? LiveValue.fromJson(json['live_value']) : null,
      status: json['status'],
      testValue: json['test_value'] != null ? LiveValue.fromJson(json['test_value']) : null,
      title: json['title'],
      type: json['type'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['gateway_image'] = this.gatewayLogo;
    data['id'] = this.id;
    data['is_test'] = this.isTest;
    data['status'] = this.status;
    data['title'] = this.title;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    if (this.liveValue != null) {
      data['live_value'] = this.liveValue!.toJson();
    }
    if (this.testValue != null) {
      data['test_value'] = this.testValue!.toJson();
    }
    return data;
  }
}

class LiveValue {
  String? publishableKey;
  String? url;
  String? secretId;
  String? keyId;
  String? publicKey;
  String? secretKey;
  String? tokenizationKey;
  String? accessToken;
  String? encryptionKey;
  String? profileId;
  String? serverKey;
  String? clientKey;
  String? merchantId;
  String? merchantKey;

  LiveValue({
    this.publishableKey,
    this.secretKey,
    this.url,
    this.secretId,
    this.keyId,
    this.publicKey,
    this.tokenizationKey,
    this.accessToken,
    this.encryptionKey,
    this.profileId,
    this.serverKey,
    this.clientKey,
    this.merchantId,
    this.merchantKey,
  });

  factory LiveValue.fromJson(Map<String, dynamic> json) {
    return LiveValue(
      publishableKey: json['publishable_key'],
      secretKey: json['secret_key'],
      url: json['url'],
      secretId: json['secret_id'],
      keyId: json['key_id'],
      publicKey: json['public_key'],
      tokenizationKey: json['tokenization_key'],
      accessToken: json['access_token'],
      encryptionKey: json['encryption_key'],
      profileId: json['profile_id'],
      serverKey: json['server_key'],
      clientKey: json['client_key'],
      merchantId: json['merchant_id'],
      merchantKey: json['merchant_key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishable_key'] = this.publishableKey;
    data['secret_key'] = this.secretKey;
    data['url'] = this.url;
    data['secret_id'] = this.secretId;
    data['key_id'] = this.keyId;
    data['public_key'] = this.publicKey;
    data['tokenization_key'] = this.tokenizationKey;
    data['access_token'] = this.accessToken;
    data['encryption_key'] = this.encryptionKey;
    data['profile_id'] = this.profileId;
    data['server_key'] = this.serverKey;
    data['client_key'] = this.clientKey;
    data['merchant_id'] = this.merchantId;
    data['merchant_key'] = this.merchantKey;

    return data;
  }
}
