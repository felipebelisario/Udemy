import 'package:buscadorgifs/ui/gif_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null || _search.isEmpty) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=uLIOLxGqCnogEz9Gbfui7v0IZbOjhHlg&limit=24&rating=G");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=uLIOLxGqCnogEz9Gbfui7v0IZbOjhHlg&q=$_search&limit=23&offset=$_offset&rating=G&lang=en");
    }

    return json.decode(response.body);
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      _getGifs();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CachedNetworkImage(
          imageUrl:
              "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif",
          placeholder: (context, url) {
            return SpinKitWave(
              color: Colors.white,
              size: 30.0,
            );
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 18.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.only(top: 30.0, left: 15.0),
                  labelText: "Pesquisar GIF",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: SpinKitPulse(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createGifTable(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: GridView.builder(
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemCount: _getCount(snapshot.data["data"]),
            itemBuilder: (context, index) {
              if (_search == null || index < snapshot.data["data"].length)
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GifPage(snapshot.data["data"][index])));
                  },
                  onLongPress: () {
                    HapticFeedback.vibrate();
                    Share.share(snapshot.data["data"][index]["images"]
                        ["fixed_height"]["url"]);
                  },
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data["data"][index]["images"]
                        ["fixed_height"]["url"],
                    placeholder: (context, url) {
                      return SpinKitPulse(
                        color: Colors.white,
                        size: 30.0,
                      );
                    },
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                );
              else
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _offset += 23;
                        _getGifs();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white, size: 70.0),
                        Text(
                          "Carregar mais",
                          style: TextStyle(color: Colors.white, fontSize: 22.0),
                        )
                      ],
                    ),
                  ),
                );
            }));
  }
}
