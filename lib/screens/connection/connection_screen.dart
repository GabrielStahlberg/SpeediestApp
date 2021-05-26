import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/screens/connection/components/line_chart_connection.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/utils_impl.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {

  static getConnectionsData() {
    return [
      ConnectionStats(1, 80, Colors.blue),
      ConnectionStats(2, 66, Colors.blue),
      ConnectionStats(3, 23, Colors.blue),
      ConnectionStats(4, 5, Colors.blue),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

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
              ChartsItems(chartTitle: "Estatística de Médias", data: getConnectionsData()),
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
              DetailsItems(infoValue: "Média nesse período", infoName: "78.7 Mbps"),
              DetailsItems(infoValue: "Localização", infoName: "Araraquara-SP / Brasil"),
            ],
          )
        )
      ],
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
  final data;

  const ChartsItems({Key key, @required this.chartTitle, @required this.data}) : super(key: key);

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
            child: LineChartConnection(seriesList: UtilsImpl.getLineChartConnectionsSeries(data), title: chartTitle)
        ),
      ),
    );
  }
}