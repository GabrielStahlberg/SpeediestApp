import 'package:flutter/material.dart';
import 'package:speediest_app/screens/home/home_screen.dart';
import 'package:speediest_app/screens/settings/settings_screen.dart';

class RouteGenerator {
  static const String SETTINGS_ROUTE = "/settings_screen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => HomeScreen()
        );
      case SETTINGS_ROUTE:
        return MaterialPageRoute(
            builder: (_) => SettingsScreen()
        );
      default:
        return _routeError();
    }
  }
  static Route<dynamic> _routeError() {
    return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(title: Text("Screen Not Found!"),),
            body: Center(
              child: Text("Screen Not Found!"),
            ),
          );
        }
    );
  }
}