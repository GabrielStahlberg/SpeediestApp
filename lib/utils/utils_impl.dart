import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speediest_app/localization/app_localization.dart';
import 'package:speediest_app/main.dart';
import 'package:speediest_app/model/language.dart';

import 'contants.dart';

class UtilsImpl {

  static Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "pt";
    return _locale(languageCode);
  }


  static _changeLanguage(BuildContext context, Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    SpeediestApp.setLocale(context, _locale);
  }

  static String getTranslated(BuildContext context, String key) {
    return AppLocalizations.of(context).translate(key);
  }

  static Locale _locale(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        return Locale(ENGLISH, 'US');
      default:
        return Locale(PORTUGUESE, 'BR');
    }
  }

  static Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(LAGUAGE_CODE, languageCode);
    return _locale(languageCode);
  }
}