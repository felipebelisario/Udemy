import 'package:atividadecodetec/helpers/database_helper.dart';
import 'package:atividadecodetec/tiles/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String url = "http://f16c16d0.ngrok.io/";

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: helper.getData("equipes"),
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
                        return Material( child: HomeTile("grid",snapshot.data[index]), color: Colors.transparent);
                      }),
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index){
                      return Material( child: HomeTile("list",snapshot.data[index]), color: Colors.transparent);
                    },
                  )
                ]);
        });
  }
}
