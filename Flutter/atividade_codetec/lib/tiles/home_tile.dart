import 'package:atividadecodetec/screens/member_screen.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  HomeTile(this.type, this.team);

  final String type;
  final Map<String, dynamic> team;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(bottom: type == "grid" ? 0.0 : 5.0),
    child: InkWell(
      splashColor: Colors.grey[500],
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MemberScreen(team)));
      },
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
