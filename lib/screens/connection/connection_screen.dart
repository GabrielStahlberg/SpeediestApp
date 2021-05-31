import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/screens/connection/components/line_chart_connection.dart';
import 'package:speediest_app/screens/home/home_screen.dart';
import 'package:speediest_app/service/connection_service.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/utils_impl.dart';
import 'package:http/http.dart' as http;

class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {

  int pingValue = 5;

  Future<dynamic> fetchCurrentConnection() async {
    ConnectionService service = ConnectionService();
    http.Response response = await service.findCurrentConnectionStats();
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load connections');
  }

  static getData(List<dynamic> json, Color color) {
    List<ConnectionStats> data = [];
    for (var i = 0; i < json.length; i++) {
      data.add(ConnectionStats((i+1), json[i], color));
    }
    return data;
  }

  _startTimer() {
    var random = new Random();
    Timer.periodic(Duration(
        seconds: 1
    ), (Timer t) {
      if(mounted) {
        setState(() {
          pingValue = random.nextInt(20) + 3;
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
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return FutureBuilder<dynamic>(
      future: fetchCurrentConnection(),
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              SizedBox(height: defaultSize * 1.5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ping: " + pingValue.toString() + " ms", style: TextStyle(fontSize: defaultSize * 3),),
                ],
              ),
              SizedBox(
                height: defaultSize * 22,
                child: GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  padding: EdgeInsets.all(defaultSize),
                  childAspectRatio: 2,
                  children: [
                    ChartsItems(chartTitle: UtilsImpl.getTranslated(context, "average_stats"), downloadData: getData(snapshot.data["downloadAverages"], kSeaGreen), uploadData: getData(snapshot.data["uploadAverages"], kFireBrick),),
                  ],
                ),
              ),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    padding: EdgeInsets.all(defaultSize * 0.8),
                    childAspectRatio: 2,
                    children: [
                      DetailsItems(infoValue: UtilsImpl.getTranslated(context, "connection_duration"), infoName: HomeScreen.timeToDisplay),
                      DetailsItems(infoValue: UtilsImpl.getTranslated(context, "general_avg_download"), infoName: snapshot.data["downloadGeneralAverage"].toString() + " Mbps"),
                      DetailsItems(infoValue: UtilsImpl.getTranslated(context, "general_avg_upload"), infoName: snapshot.data["uploadGeneralAverage"].toString() + " Mbps"),
                      DetailsItems(infoValue: UtilsImpl.getTranslated(context, "location"), infoName: "Araraquara-SP / Brasil"),
                    ],
                  )
              )
            ],
          );
        }
      },
    );
  }
}

class DetailsItems extends StatelessWidget {

  final String infoValue, infoName;

  const DetailsItems({Key key, @required this.infoValue, @required this.infoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TwoLineItem(infoValue: infoValue, infoName: infoName),
    );
  }
}

class TwoLineItem extends StatelessWidget {
  final String infoValue, infoName;

  const TwoLineItem({Key key, @required this.infoValue, @required this.infoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          infoValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: defaultSize * 1.5,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: defaultSize),
        Text(
          infoName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: defaultSize * 1.4,
            color: kPrimaryColor,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}

class ChartsItems extends StatelessWidget {

  final String chartTitle;
  final downloadData;
  final uploadData;

  const ChartsItems({Key key, @required this.chartTitle, @required this.downloadData, @required this.uploadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(defaultSize * 0.5),
        child: SizedBox(
            child: LineChartConnection(seriesList: UtilsImpl.getLineChartConnectionsSeries(downloadData, uploadData), title: chartTitle)
        ),
      ),
    );
  }
}