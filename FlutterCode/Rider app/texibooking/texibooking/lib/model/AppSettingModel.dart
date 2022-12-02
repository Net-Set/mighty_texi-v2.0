import 'SettingModel.dart';

class AppSettingModel {
  Region? region;
  SettingModel? settingModel;
  List<RideSetting>? rideSetting;
  List<WalletSetting>? walletSetting;
  CurrencySetting? currencySetting;
  PrivacyPolicyModel? privacyPolicyModel;
  PrivacyPolicyModel? termsCondition;

  AppSettingModel({this.region, this.rideSetting, this.walletSetting, this.currencySetting, this.settingModel, this.privacyPolicyModel, this.termsCondition});

  AppSettingModel.fromJson(Map<String, dynamic> json) {
    region = json['region'] != null ? new Region.fromJson(json['region']) : null;
    settingModel = json['app_seeting'] != null ? new SettingModel.fromJson(json['app_seeting']) : null;
    if (json['ride_setting'] != null) {
      rideSetting = <RideSetting>[];
      json['ride_setting'].forEach((v) {
        rideSetting!.add(new RideSetting.fromJson(v));
      });
    }
    if (json['Wallet_setting'] != null) {
      walletSetting = <WalletSetting>[];
      json['Wallet_setting'].forEach((v) {
        walletSetting!.add(new WalletSetting.fromJson(v));
      });
    }
    currencySetting = json['currency_setting'] != null ? new CurrencySetting.fromJson(json['currency_setting']) : null;
    privacyPolicyModel = json['privacy_policy'] != null ? new PrivacyPolicyModel.fromJson(json['privacy_policy']) : null;
    termsCondition = json['terms_condition'] != null ? new PrivacyPolicyModel.fromJson(json['terms_condition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.settingModel != null) {
      data['app_seeting'] = this.settingModel!.toJson();
    }
    if (this.rideSetting != null) {
      data['ride_setting'] = this.rideSetting!.map((v) => v.toJson()).toList();
    }
    if (this.walletSetting != null) {
      data['Wallet_setting'] = this.walletSetting!.map((v) => v.toJson()).toList();
    }
    if (this.currencySetting != null) {
      data['currency_setting'] = this.currencySetting!.toJson();
    }
    if (this.privacyPolicyModel != null) {
      data['privacy_policy'] = this.privacyPolicyModel!.toJson();
    }
    if (this.termsCondition != null) {
      data['terms_condition'] = this.termsCondition!.toJson();
    }
    return data;
  }
}

class Region {
  int? id;
  String? name;
  String? currencyName;
  String? currencyCode;
  String? distanceUnit;
  int? status;
  String? timezone;
  String? createdAt;
  String? updatedAt;

  Region({
    this.id,
    this.name,
    this.currencyName,
    this.currencyCode,
    this.distanceUnit,
    this.status,
    this.timezone,
    this.createdAt,
    this.updatedAt,
  });

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    currencyName = json['currency_name'];
    currencyCode = json['currency_code'];
    distanceUnit = json['distance_unit'];
    status = json['status'];
    timezone = json['timezone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['currency_name'] = this.currencyName;
    data['currency_code'] = this.currencyCode;
    data['distance_unit'] = this.distanceUnit;
    data['status'] = this.status;
    data['timezone'] = this.timezone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class WalletSetting {
  int? id;
  String? key;
  String? type;
  String? value;

  WalletSetting({this.id, this.key, this.type, this.value});

  WalletSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class RideSetting {
  int? id;
  String? key;
  String? type;
  String? value;

  RideSetting({this.id, this.key, this.type, this.value});

  RideSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class CurrencySetting {
  String? name;
  String? code;
  String? symbol;
  String? position;

  CurrencySetting({this.name, this.code, this.position, this.symbol});

  CurrencySetting.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    position = json['position'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['position'] = this.position;
    data['symbol'] = this.symbol;
    return data;
  }
}

class PrivacyPolicyModel {
  int? id;
  String? key;
  String? type;
  String? value;

  PrivacyPolicyModel({this.id, this.key, this.type, this.value});

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      id: json['id'],
      key: json['key'],
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
