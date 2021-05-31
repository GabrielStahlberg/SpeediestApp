import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/size_config.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/utils_impl.dart';

class HistoryContentCard extends StatelessWidget {

  final ConnectionHistory history;

  const HistoryContentCard({this.history, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    String dateFormatted = UtilsImpl.dateFormatter(history.date);
    String date = dateFormatted.split(" ")[0];
    String time = dateFormatted.split(" ")[1];

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
                width: defaultSize * 35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          history.name,
                          style: TextStyle(
                              fontSize: defaultSize * 2.3, fontWeight: FontWeight.bold, color: kSecondColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: defaultSize * 1.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: defaultSize * 1.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: defaultSize),
                    Row(
                      children: [
                        Icon(MdiIcons.mapMarkerRadiusOutline),
                        SizedBox(width: defaultSize,),
                        Text(
                          history.location,
                          style: TextStyle(
                              fontSize: defaultSize * 1.8,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: defaultSize,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.download, size: defaultSize * 3,),
                            SizedBox(width: defaultSize,),
                            Text(
                              history.downloadAverage.toString() + " Mbps",
                              style: TextStyle(
                                fontSize: defaultSize * 1.8,
                                fontWeight: FontWeight.bold,
                                color: kSeaGreen,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.upload, size: defaultSize * 3,),
                            SizedBox(width: defaultSize,),
                            Text(
                              history.uploadAverage.toString() + " Mbps",
                              style: TextStyle(
                                fontSize: defaultSize * 1.8,
                                fontWeight: FontWeight.bold,
                                color: kFireBrick,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}