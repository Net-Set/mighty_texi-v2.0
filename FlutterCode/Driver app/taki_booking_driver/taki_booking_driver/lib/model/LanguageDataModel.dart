import 'package:flutter/material.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../../main.dart';
import '../utils/Common.dart';
import '../utils/Constants.dart';

class LanguageDataModel {
  int? id;
  String? name;
  String? languageCode;
  String? fullLanguageCode;
  String? flag;
  String? subTitle;

  LanguageDataModel({
    this.id,
    this.name,
    this.languageCode,
    this.flag,
    this.fullLanguageCode,
    this.subTitle,
  });

  static List<String> languages() {
    List<String> list = [];

    localeLanguageList.forEach((element) {
      list.add(element.languageCode.validate());
    });

    return list;
  }

  static List<Locale> languageLocales() {
    List<Locale> list = [];

    localeLanguageList.forEach((element) {
      list.add(Locale(element.languageCode.validate(), element.fullLanguageCode.validate()));
    });

    return list;
  }
}

LanguageDataModel? getSelectedLanguageModel({String? defaultLanguage}) {
  LanguageDataModel? data;

  localeLanguageList.forEach((element) {
    if (element.languageCode == (sharedPref.getString(SELECTED_LANGUAGE_CODE) ?? default_Language)) {
      data = element;
    }
  });

  return data;
}
