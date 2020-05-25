import 'dart:convert';
import 'package:http/http.dart' as http;

final String url = "http://d8f68942.ngrok.io/";

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<List> getData(String jsonPath) async {

    http.Response response;
    response = await http.get(url + jsonPath);

    return json.decode(response.body);
  }

  Future<int> deleteData(String jsonPath) async {

    http.Response response;
    response = await http.delete(url + jsonPath);

    return response.statusCode;
  }
}