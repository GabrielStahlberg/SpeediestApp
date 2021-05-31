import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/screens/history/components/history_content_card.dart';
import 'package:speediest_app/size_config.dart';

class HistoryItemCard extends StatelessWidget {

  final ConnectionHistory history;

  const HistoryItemCard({this.history, Key key}) : super(key: key);

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
            height: defaultSize * 16,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              elevation: 5.0,
              shadowColor: Colors.black,
              clipBehavior: Clip.antiAlias,
              child: HistoryContentCard(history: history),
            ),
          ),
        ],
      ),
    );
  }
}