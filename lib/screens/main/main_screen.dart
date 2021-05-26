import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speedometer/speedometer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _lowerValue = 140.0;
  double _upperValue = 260.0;
  int start = 0;
  int end = 400;
  PublishSubject<double> eventObservable = PublishSubject();

  List<double> testValues = [];
  double averageDownload = 0.0;
  double averageUpload = 0.0;
  String textValue = "Download";

  List<double> _executeTest() {
    List<double> list = [];
    var random = new Random();
    setState(() {
      Timer.periodic(Duration(milliseconds: 700), (timer) {
        double value = random.nextInt(end - 1) + random.nextDouble();
        if(list.length == 4) {
          setState(() {
            textValue = "Download";
          });
          timer.cancel();
        }
        eventObservable.add(value);
        list.add(value);
      });
    });
    return list;
  }

  double _calculateAverage(List<double> values) {
    double sumTotal = 0.0;
    values.forEach((element) => sumTotal += element);

    return (sumTotal / values.length);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    final ThemeData somTheme = ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.black,
        backgroundColor: Colors.grey);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultSize * 8, right: defaultSize * 8, top: defaultSize * 5),
          child: SpeedOMeter(
            start: start,
            end: end,
            highlightStart: (_lowerValue / end),
            highlightEnd: (_upperValue / end),
            themeData: somTheme,
            eventObservable: this.eventObservable
          )
        ),
        Text(textValue),
        SizedBox(height: defaultSize * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(averageDownload.toStringAsFixed(1)),
                Text("Download"),
              ],
            ),
            Container(height: defaultSize * 5, child: VerticalDivider(width: defaultSize * 5, color: Colors.black)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(averageUpload.toStringAsFixed(1)),
                Text("Upload"),
              ],
            )
          ],
        ),
        SizedBox(height: defaultSize * 5),
        FloatingActionButton(
          onPressed: () async {
            testValues = _executeTest();
            await Future.delayed(Duration(seconds: 6));
            setState(() {
              averageDownload = _calculateAverage(testValues);
            });
            testValues = _executeTest();
            await Future.delayed(Duration(seconds: 5));
            setState(() {
              averageUpload = _calculateAverage(testValues);
            });
          },
          child: Icon(Icons.network_check),
          elevation: 2.0,
        )
      ],
    );
  }
}
