import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speediest_app/utils/contants.dart';

import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kBackgroundFirst, kBackgroundSecond, kBackgroundFirst],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.repeated
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Image.asset("assets/images/Logo.png"),
        ),
      ),
    );
  }
}
