import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/screens/connection/components/line_chart_connection.dart';
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
              SizedBox(
                height: defaultSize * 22,
                child: GridView.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  padding: EdgeInsets.all(defaultSize),
                  childAspectRatio: 2,
                  children: [
                    ChartsItems(chartTitle: "Estatística de Médias", downloadData: getData(snapshot.data["downloadAverages"], Colors.green), uploadData: getData(snapshot.data["uploadAverages"], Colors.red),),
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
                      DetailsItems(infoValue: "Tempo conectado", infoName: "02:32:11"),
                      DetailsItems(infoValue: "Próximo teste em:", infoName: "43:21:54"),
                      DetailsItems(infoValue: "Média geral Download", infoName: snapshot.data["downloadGeneralAverage"].toString() + " Mbps"),
                      DetailsItems(infoValue: "Média geral Upload", infoName: snapshot.data["uploadGeneralAverage"].toString() + " Mbps"),
                      DetailsItems(infoValue: "Ping", infoName: "10 ms"),
                      DetailsItems(infoValue: "Localização", infoName: "Araraquara-SP / Brasil"),
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
          style: TextStyle(
            fontSize: defaultSize * 1.8,
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          infoName,
          style: TextStyle(
            fontSize: defaultSize * 1.6,
            color: kPrimaryColor,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}

/* ----------------------------------- */

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