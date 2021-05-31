import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speediest_app/service/connection_service.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';
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
  int max = 250;
  PublishSubject<double> eventObservable = PublishSubject();

  List<double> testValues = [];
  double averageDownload = 0.0;
  double averageUpload = 0.0;
  String textValue = "Download";

  List<double> _executeTest(bool isUpdate) {
    List<double> list = [];
    var random = new Random();
    setState(() {
      Timer.periodic(Duration(milliseconds: 700), (timer) {
        double value = 0;
        if(isUpdate) {
          value = random.nextInt(125 - 1) + random.nextDouble();
        } else {
          value = random.nextInt(max - 1) + random.nextDouble();
        }
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
        primaryColor: kSecondColor,
        accentColor: Colors.black,
        backgroundColor: Colors.grey);

    return SafeArea(
      child: Column(
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
          Text(textValue, style: TextStyle(fontSize: defaultSize * 2.5, fontWeight: FontWeight.bold),),
          SizedBox(height: defaultSize * 3.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(averageDownload.toStringAsFixed(1),
                    style: TextStyle(fontSize: defaultSize * 2.5, fontWeight: FontWeight.bold, color: kSeaGreen),),
                  Text("Download",
                    style: TextStyle(fontSize: defaultSize * 1.6, color: kSeaGreen),),
                ],
              ),
              Container(height: defaultSize * 5, child: VerticalDivider(width: defaultSize * 5, color: Colors.black)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(averageUpload.toStringAsFixed(1),
                    style: TextStyle(fontSize: defaultSize * 2.5, fontWeight: FontWeight.bold, color: kFireBrick),),
                  Text("Upload",
                    style: TextStyle(fontSize: defaultSize * 1.6, color: kFireBrick),),
                ],
              )
            ],
          ),
          SizedBox(height: defaultSize * 5),
          FloatingActionButton(
            onPressed: () async {
              testValues = _executeTest(false);
              await Future.delayed(Duration(seconds: 6));
              setState(() {
                averageDownload = _calculateAverage(testValues);
                textValue = "Upload";
              });
              testValues = _executeTest(true);
              await Future.delayed(Duration(seconds: 5));
              setState(() {
                averageUpload = _calculateAverage(testValues);
              });
              await Future.delayed(Duration(seconds: 3));
              ConnectionService service = ConnectionService();
              Response response = await service.saveTest(averageDownload, averageUpload);
            },
            child: Icon(Icons.network_check, color: Colors.white,),
            backgroundColor: kSecondColor,
            elevation: 2.0,
          )
        ],
      ),
    );
  }
}
