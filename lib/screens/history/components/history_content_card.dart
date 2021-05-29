import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';

class HistoryContentCard extends StatelessWidget {

  final ConnectionHistory history;

  const HistoryContentCard({this.history, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Padding(
      padding:
      EdgeInsets.all(defaultSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: defaultSize * 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.name,
                      style: TextStyle(
                          fontSize: defaultSize * 1.5, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize),
                    Text(
                      history.location,
                      style: TextStyle(
                          fontSize: defaultSize * 2,
                          fontWeight: FontWeight.bold,
                          color: kSecondColor,
                      ),
                    ),
                    SizedBox(height: defaultSize),
                    Text(
                      history.duration.toString(),
                      style: TextStyle(
                        fontSize: defaultSize * 2,
                        fontWeight: FontWeight.bold,
                        color: kSecondColor,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    history.date,
                    style: TextStyle(
                      fontSize: defaultSize,
                      fontWeight: FontWeight.bold,
                      color: kSecondColor,
                    ),
                  ),
                  SizedBox(height: defaultSize * 5),
                  Text(
                    history.downloadAverage.toString(),
                    style: TextStyle(
                      fontSize: defaultSize,
                      fontWeight: FontWeight.bold,
                      color: kSecondColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}