// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$screenAtom = Atom(name: '_HomeStore.screen');

  @override
  Widget get screen {
    _$screenAtom.reportRead();
    return super.screen;
  }

  @override
  set screen(Widget value) {
    _$screenAtom.reportWrite(value, super.screen, () {
      super.screen = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void changeScreen(Widget newScreen) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.changeScreen');
    try {
      return super.changeScreen(newScreen);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
screen: ${screen}
    ''';
  }
}
