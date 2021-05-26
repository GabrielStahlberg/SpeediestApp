import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_stats.dart';
import 'package:speediest_app/screens/connection/components/line_chart_connection.dart';
import 'package:speediest_app/size_config.dart';
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

    return SafeArea(
      child: GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        padding: EdgeInsets.all(defaultSize),
        childAspectRatio: 2,
        children: [
          ChartsItems(chartTitle: "Connections", data: getConnectionsData()),
        ],
      ),
    );
  }
}

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