import 'package:flutter/material.dart';

import '../model/LanguageDataModel.dart';
import '../model/TextModel.dart';

List<TexIModel> getBookList() {
  List<TexIModel> list = [];
  list.add(TexIModel(title: 'Home', iconData: Icons.home));
  list.add(TexIModel(title: 'Work', iconData: Icons.work));
  list.add(TexIModel(title: 'Recently', iconData: Icons.history));
  return list;
}

List<TexIModel> getCarList() {
  List<TexIModel> list = [];
  list.add(TexIModel(title: 'Premium', img: 'images/ic_Premium.png', subTitle: '75'));
  list.add(TexIModel(title: 'Economy', img: 'images/ic_economy.png', subTitle: '25'));
  list.add(TexIModel(title: 'Standard', img: 'images/ic_standard.png', subTitle: '45'));
  return list;
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', subTitle: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', subTitle: 'हिंदी', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_india.png'),
    LanguageDataModel(id: 3, name: 'Arabic', subTitle: 'عربي', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'),
    LanguageDataModel(id: 4, name: 'Spanish', subTitle: 'Española', languageCode: 'es', fullLanguageCode: 'es-ES', flag: 'images/flag/ic_spain.png'),
    LanguageDataModel(id: 5, name: 'Afrikaans', subTitle: 'Afrikaans', languageCode: 'af', fullLanguageCode: 'af-AF', flag: 'images/flag/ic_south_africa.png'),
    LanguageDataModel(id: 6, name: 'French', subTitle: 'Français', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'images/flag/ic_france.png'),
    LanguageDataModel(id: 7, name: 'German', subTitle: 'Deutsch', languageCode: 'de', fullLanguageCode: 'de-DE', flag: 'images/flag/ic_germany.png'),
    LanguageDataModel(id: 8, name: 'Indonesian', subTitle: 'bahasa Indonesia', languageCode: 'id', fullLanguageCode: 'id-ID', flag: 'images/flag/ic_indonesia.png'),
    LanguageDataModel(id: 9, name: 'Portuguese', subTitle: 'Português', languageCode: 'pt', fullLanguageCode: 'pt-PT', flag: 'images/flag/ic_portugal.png'),
    LanguageDataModel(id: 10, name: 'Turkish', subTitle: 'Türkçe', languageCode: 'tr', fullLanguageCode: 'tr-TR', flag: 'images/flag/ic_turkey.png'),
    LanguageDataModel(id: 11, name: 'vietnamese', subTitle: 'Tiếng Việt', languageCode: 'vi', fullLanguageCode: 'vi-VI', flag: 'images/flag/ic_vitnam.png'),
    LanguageDataModel(id: 12, name: 'Dutch', subTitle: 'Nederlands', languageCode: 'nl', fullLanguageCode: 'nl-NL', flag: 'images/flag/ic_dutch.png'),
    LanguageDataModel(id: 13, name: 'Panjabi', subTitle: 'ਪੰਜਾਬੀ', languageCode: 'pa', fullLanguageCode: 'pa-IN', flag: 'images/flag/ic_india.png'),
    LanguageDataModel(id: 14, name: 'Tamil', subTitle: 'தமிழ்', languageCode: 'ta', fullLanguageCode: 'ta-IN', flag: 'images/flag/ic_india.png'),
    LanguageDataModel(id: 15, name: 'Urdu', subTitle: 'اردو', languageCode: 'ur', fullLanguageCode: 'ur-IN', flag: 'images/flag/ic_india.png'),
  ];
}
