import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String url = "http://9171e356777f.ngrok.io/";
SharedPreferences prefs;
int loggedUser;

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<int> init() async {
    prefs = await SharedPreferences.getInstance();

    loggedUser = prefs.getInt("userId");
  }


  Future<List> getData(String jsonPath) async {

    http.Response response;
    response = await http.get(url + jsonPath);

    return json.decode(response.body);
  }

  Future<int> postData(String jsonPath, Map data) async {

    http.Response response;
    response = await http.post(url + jsonPath, body: json.encode(data), headers: {"Accept": "application/json", "content-type": "application/json"});

    return response.statusCode;
  }

  Future<int> deleteData(String jsonPath) async {

    http.Response response;
    response = await http.delete(url + jsonPath);

    return response.statusCode;
  }
}