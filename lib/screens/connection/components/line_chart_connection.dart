import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChartConnection extends StatelessWidget {

  final List<charts.Series> seriesList;
  final String title;

  const LineChartConnection({Key key, @required this.seriesList, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      animate: false,
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.end
        )
      ],
      defaultRenderer: charts.LineRendererConfig(
          includePoints: true
      ),
    );
  }
}