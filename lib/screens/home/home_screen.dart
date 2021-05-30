import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:speediest_app/screens/home/components/bottom_navigator_bar.dart';
import 'package:speediest_app/screens/home/components/settings_action.dart';
import 'package:speediest_app/screens/main/main_screen.dart';
import 'package:speediest_app/store/home_store.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/widgets/background.dart';

class HomeScreen extends StatefulWidget {

  static String timeToDisplay = "0";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var storeHome = GetIt.I.get<HomeStore>();

  _startTimer() {
    int timeForTimer = 0;

    Timer.periodic(Duration(
        seconds: 1
    ), (Timer t) {
      if(mounted) {
        setState(() {
          if(timeForTimer < 60) {
            HomeScreen.timeToDisplay = timeForTimer.toString();
            timeForTimer++;
          } else if(timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            HomeScreen.timeToDisplay = m.toString() + ":" + s.toString();
            timeForTimer++;
          } else {
            int h = timeForTimer ~/ 3600;
            int t = timeForTimer - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            HomeScreen.timeToDisplay = h.toString() + ":" + m.toString() + ":" + s.toString();
            timeForTimer++;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Speediest", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          actions: [
            SettingsAction()
          ],
          backgroundColor: kSecondColor,
        ),
        body: Background(
          child: storeHome.screen,
        ),
        bottomNavigationBar: BottomNavBar(),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    storeHome.changeScreen(MainScreen());
  }
}