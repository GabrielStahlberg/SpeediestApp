import 'package:flutter/material.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/route_generator.dart';

class SettingsAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: kPrimaryColor),
      onPressed: () {
        Navigator.pushNamed(context, RouteGenerator.SETTINGS_ROUTE);
      },
    );
  }
}
