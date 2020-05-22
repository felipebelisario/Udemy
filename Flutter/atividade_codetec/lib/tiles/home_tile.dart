import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  HomeTile(this.type, this.team);

  final String type;
  final Map<String, dynamic> team;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("aaa");
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
          child: type == "grid"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                      team["nome"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    )),
                    Expanded(child:
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.arrow_drop_down),
                          Text(
                            "Id: ${team["id"]}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                                color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                    )
                  ],
                )
              : Container()),
    );
  }
}
