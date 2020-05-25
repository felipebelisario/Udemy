import 'dart:convert';
import 'dart:io';
import 'package:atividadecodetec/helpers/database_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

final String defaultImage =
    "https://www.pinclipart.com/picdir/big/18-181421_png-transparent-download-person-svg-png-icon-person.png";

class MemberScreen extends StatelessWidget {
  final DatabaseHelper helper = DatabaseHelper();
  final Map<String, dynamic> team;

  MemberScreen(this.team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${team["nome"]}"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: helper
            .getData("membros?equipeId=${team["id"]}&_sort=cargoId&_order=asc"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
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
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data[index]["foto"] == null
                                    ? defaultImage
                                    : snapshot.data[index]["foto"],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                                errorWidget: (context, url, error) {
                                  return Image.network(defaultImage);
                                },
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 165.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(snapshot.data[index]["nome"] ?? "",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                      FutureBuilder(
                                        future: helper.getData(
                                            "cargos?id=${snapshot.data[index]["cargoId"]}"),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data[0]["nome"],
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1);
                                          } else {
                                            return SpinKitWave(
                                              size: 5.0,
                                              color: Colors.grey[500],
                                            );
                                          }
                                        },
                                      ),
                                      Text(snapshot.data[index]["email"] ?? "",
                                          style: TextStyle(fontSize: 18.0),
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
