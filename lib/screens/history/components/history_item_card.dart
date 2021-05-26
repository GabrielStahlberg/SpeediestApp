import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/screens/history/components/history_content_card.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';

class HistoryItemCard extends StatelessWidget {

  final ConnectionHistory history;
  final List<ConnectionHistory> historyList;

  const HistoryItemCard({this.history, this.historyList, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Padding(
      padding: EdgeInsets.only(
          left: defaultSize * 1.1,
          right: defaultSize * 1.1,
          bottom: defaultSize),
      child: Column(
        children: [
          SizedBox(
            height: defaultSize * 15,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              elevation: 2.0,
              shadowColor: kPrimaryColor,
              clipBehavior: Clip.antiAlias,
              child: HistoryContentCard(history: history, historyList: historyList),
            ),
          ),
        ],
      ),
    );
  }
}