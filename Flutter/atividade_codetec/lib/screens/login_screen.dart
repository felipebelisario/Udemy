import 'package:atividadecodetec/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget _buildBodyBack(Widget _child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 20, 126, 203),
          Color.fromARGB(255, 80, 148, 197),
          Color.fromARGB(255, 105, 169, 217)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: _child,
      );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return _buildBodyBack(Container(
        child: Center(
      child: Form(
          key: _formKey,
          child: Container(
              width: queryData.size.width - 50.0,
              height: queryData.size.height - 260.0,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text("Login",
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold)))),
                      SizedBox(
                        height: 50.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: Colors.blue[500]),
                                ),
                                hintText: "E-mail",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 15.0,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Senha",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: Colors.blue[500]),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonTheme(
                                    minWidth: 250.0,
                                    height: 70.0,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.setInt("userId", 1);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext ctx) =>
                                                      HomeScreen()));
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        "Entrar",
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white),
                                      ),
                                    )),
                              ]),
                        ],
                      )),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Row(
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
                            ),
                            SizedBox(
                              height: 100.0,
                            )
                          ],
                        ),
                      )
                    ],
                  )))),
    )));
  }
}
