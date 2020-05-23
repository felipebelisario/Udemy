import 'package:atividadecodetec/screens/member_screen.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  HomeTile(this.type, this.team, this._getData);

  final String type;
  final Map<String, dynamic> team;
  final Future<List> Function(String) _getData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MemberScreen(team, _getData)));
      },
      child: Padding(
          padding: EdgeInsets.only(bottom: type == "grid" ? 0.0 : 8.0),
          child: Card(
          child: type == "grid"
              ? Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: Text(team["nome"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5.0),
                      child: Align(
                        child: Text("ID: ${team["id"]}", style: TextStyle(color: Colors.grey[500]),),
                        alignment: Alignment.topRight,
                      ),
                    ),
                    Align(
                      child: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500],),
                      alignment: Alignment.bottomCenter,
                    ),
                  ],
                ),
              )
            ],
              )
              : Stack(
            children: <Widget>[
              Container(
                height: 55.0,
                child: Stack(
                  children: <Widget>[

                    Align(
                      child: Text(team["nome"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Align(
                        child: Text("ID: ${team["id"]}", style: TextStyle(color: Colors.grey[500]),),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Align(
                      child: Icon(Icons.keyboard_arrow_right, color: Colors.grey[500],),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              )
            ],
          ))
      ),
    );
  }
}
