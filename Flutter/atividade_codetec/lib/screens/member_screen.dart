import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberScreen extends StatelessWidget {

  final Map<String, dynamic> team;
  final Future<List> Function(String) _getData;

  MemberScreen(this.team, this._getData);

  Future<List> _getMembers() async{

    List listFiltered = await _getData("membros");

    listFiltered = listFiltered.where((member) =>
      member["equipeId"] == team["id"]
    ).toList();

    listFiltered.sort((a, b) => a["cargoId"] > b["cargoId"] ? 1 : -1);
    return listFiltered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team["nome"]),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getMembers(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
//                    _showOptions(context, index);
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: snapshot.data[index]["foto"] != null
                                        ? FileImage(File(snapshot.data[index]["foto"].toString()))
                                        : AssetImage("images/person.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                              child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 165.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snapshot.data[index]["nome"] ?? "",
                                          style: TextStyle(
                                              fontSize: 22.0, fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                      Text(snapshot.data[index]["email"] ?? "",
                                          style: TextStyle(
                                              fontSize: 18.0),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
