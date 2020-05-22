import 'dart:convert';
import 'package:atividadecodetec/tiles/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String url = "http://localhost:3000/";

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<List> _getData(String jsonPath) async {
    http.Response response;
    response = await http.get(url + jsonPath);

    print(json.decode(response.body).runtimeType);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData("equipes"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                      padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 1.5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data[0]["nome"]);
                        return Material( child: HomeTile("grid",snapshot.data[index]), color: Colors.transparent);
                      }),
                  Container()
                ]);
        });
  }
}
