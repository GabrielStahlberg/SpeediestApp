import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ConnectionService {

  final String baseUrl = "http://192.168.15.31:8080/connections";

  Future<Response> findAllConnections() async {
    return await http.get(Uri.parse(baseUrl));
  }

  Future<Response> changePeriod(String minutes) async {
    return await http.post(
      Uri.parse(baseUrl + "/changePeriodTime"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "period": minutes,
      }),
    );
  }

  Future<Response> saveTest(double averageDownload, double averageUpload) async {
    return await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, dynamic>{
        "name": "Connection_Gabriel_Test",
        "location": "Araraquara-SP",
        "durationMinutes": "40",
        "downloadAverage": averageDownload,
        "uploadAverage": averageUpload
      }),
    );
  }
}