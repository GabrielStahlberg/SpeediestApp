import 'package:flutter/material.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/utils_impl.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    final items = [
      SettingsItems(Icon(Icons.language), "language", (){UtilsImpl.showLanguageDialog(context);}),
    ];

    return Padding(
      padding: EdgeInsets.all(defaultSize),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return Padding(
              padding: EdgeInsets.only(top: defaultSize),
              child: Card(
                child: ListTile(
                  leading: item.icon,
                  title: Text(UtilsImpl.getTranslated(context, item.name), style: TextStyle(fontSize: defaultSize * 1.8)),
                  onTap: item.function,
                ),
              ),
            );
          }
      ),
    );
  }
}

class SettingsItems {
  final Icon icon;
  final String name;
  final Function function;

  SettingsItems(this.icon, this.name, this.function);
}