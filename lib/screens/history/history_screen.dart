import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/screens/history/components/history_item_card.dart';
import 'package:speediest_app/size_config.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  static _getHistory() {
    return [
      ConnectionHistory(1, "connection1", "Araraquara-SP/Brasil", "01:32h", "78.4 Mbps", "02/09/2020"),
      ConnectionHistory(2, "connection2", "São Paulo-SP/Brasil", "00:43h", "102.1 Mbps", "14/08/2020"),
      ConnectionHistory(3, "connection3", "São Carlos-SP/Brasil", "04:30h", "21.1 Mbps", "20/04/2020"),
      ConnectionHistory(4, "connection4", "Curitiba-PR/Brasil", "01:02h", "15.6 Mbps", "15/03/2020"),
      ConnectionHistory(5, "connection5", "Américo Brasiliense-SP/Brasil", "05:21h", "10.2 Mbps", "22/01/2020"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    List<ConnectionHistory> historyList = _getHistory();

    return ListView.builder(
      padding: EdgeInsets.only(top: defaultSize, bottom: defaultSize * 1.2),
      itemCount: historyList.length,
      itemBuilder: (BuildContext context, int index) {
        ConnectionHistory history = historyList[index];
        return HistoryItemCard(history: history, historyList: historyList);
      }
    );
  }
}