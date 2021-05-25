import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:speediest_app/screens/connection/connection_screen.dart';
import 'package:speediest_app/screens/history/history_screen.dart';
import 'package:speediest_app/screens/main/main_screen.dart';
import 'package:speediest_app/store/home_store.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/utils_impl.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1;
  var store = GetIt.I.get<HomeStore>();

  List<Widget> screens = [
    HistoryScreen(),
    MainScreen(),
    ConnectionScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {store.changeScreen(screens[index]); currentIndex = index;},
      type: BottomNavigationBarType.fixed,
      fixedColor: kSecondColor,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
            label: UtilsImpl.getTranslated(context, "history"),
            icon: Icon(Icons.equalizer, color: currentIndex == 0 ? kSecondColor : kPrimaryColor)
        ),
        BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, color: currentIndex == 1 ? kSecondColor : kPrimaryColor)
        ),
        BottomNavigationBarItem(
            label: UtilsImpl.getTranslated(context, "connection"),
            icon: Icon(Icons.home, color: currentIndex == 2 ? kSecondColor : kPrimaryColor)
        )
      ],
    );
  }
}
