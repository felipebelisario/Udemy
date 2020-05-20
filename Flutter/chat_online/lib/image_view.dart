import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final Map _imgData;

  ImageView(this._imgData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(_imgData["senderName"]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text("${DateTime.parse(_imgData["time"].toDate().toString()).hour}:" +
                  "${(DateTime.parse(_imgData["time"].toDate().toString()).minute) < 10 ? "0" + (DateTime.parse(_imgData["time"].toDate().toString()).minute).toString() : (DateTime.parse(_imgData["time"].toDate().toString()).minute)}",
                style: TextStyle(fontSize: 15.0),),
            )
          ],
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 0.0, left: 0.0),
            child: Image.network(_imgData["imgUrl"])
          )));
  }
}