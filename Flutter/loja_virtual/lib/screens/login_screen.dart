import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Form(
              child: Card(
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 0.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "E-mail",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            style: TextStyle(fontSize: 20.0),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 0.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Senha",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            style: TextStyle(fontSize: 20.0),
                          )
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(

                          children: <Widget> [
                            Expanded(child: RaisedButton(
                              onPressed: () {},
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "Entrar",
                                style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                              ),
                            )),
                          ]
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Não está registrado? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              " Registre-se",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ))),
        ));
  }
}
