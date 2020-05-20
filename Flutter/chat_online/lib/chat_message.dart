import 'package:flutter/material.dart';
import 'package:chatonline/image_view.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data["senderPhotoUrl"]),
                    backgroundColor: Colors.blue[200],
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(data["senderName"],
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ),
                data["imgUrl"] != null
                    ? GestureDetector(
                        onTap: () {
                          _showImage(data, context);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              data["imgUrl"],
                              width: 250.0,
                            )))
                    : Container(
                        width: 200.0,
                        child: Text(data["text"],
                            textAlign: mine ? TextAlign.end : TextAlign.start,
                            style: TextStyle(fontSize: 16))),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "${DateTime.parse(data["time"].toDate().toString()).hour}:" +
                        "${(DateTime.parse(data["time"].toDate().toString()).minute) < 10 ? "0" + (DateTime.parse(data["time"].toDate().toString()).minute).toString() : (DateTime.parse(data["time"].toDate().toString()).minute)}",
                    style: TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data["senderPhotoUrl"]),
                    backgroundColor: Colors.blue[200],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _showImage(Map data, BuildContext context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageView(data)));
    }
}
