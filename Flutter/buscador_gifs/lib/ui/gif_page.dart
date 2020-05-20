import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              Share.share(_gifData["images"]["fixed_height"]["url"]);
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(right: 10.0, left: 10.0),
        child: CachedNetworkImage(
          imageUrl: _gifData["images"]["fixed_height"]["url"],
          placeholder: (context, url) {
            return SpinKitPulse(
              color: Colors.white,
              size: 30.0,
            );
          },
          height: 300.0,
          fit: BoxFit.cover,
        ),
      )),
    );
  }
}
