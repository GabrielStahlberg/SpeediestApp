import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speediest_app/localization/app_localization.dart';
import 'package:speediest_app/main.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/model/language.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/widgets/alert_dialog_popup.dart';
import 'package:speediest_app/widgets/dropdown.dart';

import 'contants.dart';

class UtilsImpl {

  static getLineChartConnectionsSeries(var data) {
    return [
      charts.Series<ConnectionStats, int>(
          id: "Connections",
          domainFn: (ConnectionStats stats, _) => stats.id,
          measureFn: (ConnectionStats stats, _) => stats.average,
          colorFn: (ConnectionStats stats, _) =>
              charts.ColorUtil.fromDartColor(stats.color),
          data: data
      )
    ];
  }

  static showLanguageDialog(BuildContext context) async {
    List<DropdownMenuItem<String>> _languagesItems = getDropDownMenuItems(Language.flagNameList());
    Locale _locale = await getLocale();
    String _currentLang = _locale.languageCode == "pt"
        ? _languagesItems[0].value
        : _languagesItems[1].value;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogPopup(
            title: UtilsImpl.getTranslated(context, "idioms"),
            negativeButton: UtilsImpl.getTranslated(context, "cancel"),
            positiveButton: UtilsImpl.getTranslated(context, "confirm"),
            onPress: () {
              _currentLang.split("  ")[1] == "English"
                  ? _changeLanguage(context, Language(2, "English", "flag2", "en"))
                  : _changeLanguage(context, Language(1, "Português", "flag1", "pt"));
              Navigator.pop(context);
            },
            content: StatefulBuilder(builder: (context, setState) {
              double defaultSize = SizeConfig.defaultSize;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    UtilsImpl.getTranslated(context, "select") + ":",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultSize * 1.7),
                  ),
                  DropDown(
                    value: _currentLang,
                    items: _languagesItems,
                    onChanged: (value) {
                      setState(() {
                        _currentLang = value;
                      });
                    },
                    textSize: defaultSize * 1.6,
                    isExpanded: true,
                  )
                ],
              );
            }),
          );
        });
  }

  static List<DropdownMenuItem<String>> getDropDownMenuItems(
      List<String> list) {
    List<DropdownMenuItem<String>> items = new List();
    for (String item in list) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

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