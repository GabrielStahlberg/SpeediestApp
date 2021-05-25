import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:speediest_app/screens/home/components/bottom_navigator_bar.dart';
import 'package:speediest_app/screens/home/components/settings_action.dart';
import 'package:speediest_app/screens/main/main_screen.dart';
import 'package:speediest_app/store/home_store.dart';
import 'package:speediest_app/widgets/background.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var store = GetIt.I.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Speediest"),
          centerTitle: true,
          actions: [
            SettingsAction()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
          },
          child: Icon(Icons.network_check),
          elevation: 2.0,
        ),
        body: Background(
          child: store.screen,
        ),
        bottomNavigationBar: BottomNavBar(),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    store.changeScreen(MainScreen());
  }
}