import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speediest_app/localization/app_localization.dart';
import 'package:speediest_app/main.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/model/language.dart';
import 'package:speediest_app/service/connection_service.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/widgets/alert_dialog_popup.dart';
import 'package:speediest_app/widgets/dropdown.dart';

import 'contants.dart';

class UtilsImpl {

  static dateFormatter(String date) {
    String dateSplitted = date.split(".")[0];
    String replaced1 = dateSplitted.replaceAll(RegExp(r"-"), "");
    String replaced2 = replaced1.replaceAll(RegExp(r":"), "");
    DateTime dateTime = DateTime.parse(replaced2);
    String formatted = DateFormat("dd/MM/yyyy hh:mm").format(dateTime);
    return formatted;
  }

  static getLineChartConnectionsSeries(var downloadData, var uploadData) {
    return [
      charts.Series<ConnectionStats, int>(
          id: "Download",
          domainFn: (ConnectionStats stats, _) => stats.id,
          measureFn: (ConnectionStats stats, _) => stats.average,
          colorFn: (ConnectionStats stats, _) =>
              charts.ColorUtil.fromDartColor(stats.color),
          data: downloadData
      ),
      charts.Series<ConnectionStats, int>(
          id: "Upload",
          domainFn: (ConnectionStats stats, _) => stats.id,
          measureFn: (ConnectionStats stats, _) => stats.average,
          colorFn: (ConnectionStats stats, _) =>
              charts.ColorUtil.fromDartColor(stats.color),
          data: uploadData
      )
    ];
  }

  static showPeriodicTestDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    _controller.text = "30";

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogPopup(
            title: "Teste periódico",
            negativeButton: UtilsImpl.getTranslated(context, "cancel"),
            positiveButton: UtilsImpl.getTranslated(context, "confirm"),
            onPress: () async {
              ConnectionService service = ConnectionService();
              Response response = await service.changePeriod(_controller.text);
              if(response.statusCode == 204) {
                Navigator.pop(context);
              }
            },
            content: StatefulBuilder(builder: (context, setState) {
              double defaultSize = SizeConfig.defaultSize;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informe em minutos:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: defaultSize * 1.7),
                  ),
                  SizedBox(height: defaultSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(icon: Icon(Icons.remove_circle_outline, color: kSecondColor), iconSize: defaultSize * 2.5,
                        onPressed: (){
                          int minutes = int.parse(_controller.text);
                          minutes--;
                          _controller.text = minutes.toString();
                        },
                      ),
                      SizedBox(
                        width: defaultSize * 5,
                        child: TextField(
                          controller: _controller,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "min"),
                        ),
                      ),
                      IconButton(icon: Icon(Icons.add_circle_outline, color: kSecondColor), iconSize: defaultSize * 2.5,
                        onPressed: (){
                          int minutes = int.parse(_controller.text);
                          minutes++;
                          _controller.text = minutes.toString();
                        },
                      ),
                    ],
                  )
                ],
              );
            }),
          );
        });
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
        },
    );
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