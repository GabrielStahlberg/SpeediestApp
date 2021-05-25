import 'package:flutter/material.dart';
import 'package:speediest_app/utils/contants.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kBackgroundFirst, kBackgroundSecond, kBackgroundFirst],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.repeated
        ),
      ),
      child: child,
    );
  }
}
