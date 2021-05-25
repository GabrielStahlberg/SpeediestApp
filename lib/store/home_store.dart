import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:speediest_app/screens/main/main_screen.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  Widget screen = MainScreen();

  @action
  void changeScreen(Widget newScreen) => screen = newScreen;
}