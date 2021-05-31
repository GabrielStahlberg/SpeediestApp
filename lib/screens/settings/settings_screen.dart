import 'package:flutter/material.dart';
import 'package:speediest_app/screens/settings/components/body.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/utils_impl.dart';
import 'package:speediest_app/widgets/background.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(UtilsImpl.getTranslated(context, "settings"), style: TextStyle(color: Colors.white),),
        backgroundColor: kSecondColor,
      ),
      body: Background(child: Body()),
    );
  }
}