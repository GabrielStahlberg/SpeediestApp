import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speediest_app/model/connection_history.dart';
import 'package:speediest_app/screens/history/components/history_item_card.dart';
import 'package:speediest_app/service/connection_service.dart';
import 'package:speediest_app/size_config.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future<List<dynamic>> fetchConnections() async {
    ConnectionService service = ConnectionService();
    http.Response response = await service.findAllConnections();
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load connections');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return FutureBuilder<List<dynamic>>(
      future: fetchConnections(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(top: defaultSize, bottom: defaultSize * 1.2),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ConnectionHistory history = ConnectionHistory.fromJson(snapshot.data[index]);
              return HistoryItemCard(history: history);
            },
          );
        }
      }
    );
  }
}