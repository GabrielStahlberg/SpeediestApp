import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ConnectionService {

  final String baseUrl = "https://speediest-api.herokuapp.com/connections";

  Future<Response> findAllConnections() async {
    return await http.get(Uri.parse(baseUrl));
  }

  Future<Response> findCurrentConnectionStats() async {
    return await http.get(Uri.parse(baseUrl + "/currentConnection"));
  }

  Future<Response> changePeriod(String minutes) async {
    return await http.post(
      Uri.parse(baseUrl + "/changePeriodTime"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "value": minutes,
      }),
    );
  }

  Future<Response> changeMinAcceptable(String downloadMin, String uploadMin) async {
    return await http.post(
      Uri.parse(baseUrl + "/minAcceptable"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "downloadValue": downloadMin,
        "uploadValue": uploadMin,
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
        "name": "My_Connection",
        "location": "Araraquara-SP",
        "durationMinutes": "40",
        "downloadAverage": averageDownload,
        "uploadAverage": averageUpload
      }),
    );
  }
}