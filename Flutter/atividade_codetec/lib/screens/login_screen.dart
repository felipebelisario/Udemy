import 'package:atividadecodetec/helpers/database_helper.dart';
import 'package:atividadecodetec/screens/register_screen.dart';
import 'package:atividadecodetec/widgets/bezierContainer.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_login_signup/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

//import 'Widget/bezierContainer.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;

  DatabaseHelper helper = DatabaseHelper();
  DBCrypt dBCrypt = DBCrypt();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _focusTF1 = new FocusNode();
  FocusNode _focusTF2 = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusTF1.addListener(_onFocusChange);
    _focusTF2.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if(_focusTF1.hasFocus || _focusTF2.hasFocus)
      _scaffoldKey.currentState.removeCurrentSnackBar();
  }

//  Widget _backButton() {
//    return InkWell(
//      onTap: () {
//        Navigator.pop(context);
//      },
//      child: Container(
//        padding: EdgeInsets.symmetric(horizontal: 10),
//        child: Row(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _entryField(String title, TextEditingController controller, FocusNode focus, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            focusNode: focus,
            controller: controller,
            style: TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              prefixIcon: isPassword == true ? Icon(Icons.lock) : Icon(Icons.alternate_email),
              filled: true,
              fillColor: Color(0xfff3f3f4),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                BorderSide(color: Color.fromARGB(255, 5, 104, 219), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius:
                  BorderRadius.circular(20.0)),
            ),
            keyboardType: !isPassword ? TextInputType.emailAddress : null,
            obscureText: isPassword,

//              decoration: InputDecoration(
//                  border: InputBorder.none,
//                  fillColor: Color(0xfff3f3f4),
//                  filled: true)
          )
        ],
      ),
    );
  }

  Future<int> _pickCurrentUserId(String email) async {
    List users;

    users = await helper.getData("users");

    for (int i = 0; i < users.length; i++) {
      if (dBCrypt.checkpw(email, users[i]["email"])) {
        return users[i]["id"];
      }
    }

    return null;
  }

  void _registerValidation() async {

    setState(() {
      isLoading = true;
    });

    helper.getData("users").then((value) async {
      for(int i = 0; i < value.length; i++){
        if(dBCrypt.checkpw(_emailController.text, value[i]["email"]) && dBCrypt.checkpw(_passwordController.text, value[i]["senha"])){
          prefs = await SharedPreferences
              .getInstance();

          prefs.setInt("userId", await _pickCurrentUserId(_emailController.text));

          setState(() {
            isLoading = false;
          });

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder:
                      (BuildContext ctx) =>
                      HomeScreen()));
        }
      }

      setState(() {
        isLoading = false;
      });

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Email/senha inválido(s)!"),
        backgroundColor: Colors.red,
      ));
    });
  }

  Widget _submitButton() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color.fromARGB(255, 5, 104, 219),),
          child: InkWell(
              onTap: () {
                _scaffoldKey.currentState.removeCurrentSnackBar();
                FocusScope.of(context).requestFocus(FocusNode());

                if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Preencha todos os campos!"),
                    backgroundColor: Colors.red,
                  ));
                } else {
                  _registerValidation();
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: isLoading == false ? Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ) : CircularProgressIndicator(backgroundColor: Colors.white,),
              ))
      ),
        );
  }

  Widget _createAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Não tem uma conta?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text(
                'Registre-se',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      );
  }

  Widget _title() {
    return BorderedText(
        strokeWidth: 3.0,
        strokeColor: Colors.black,
        child: Text(
          'Atividade\nCodeTec',
          style: TextStyle(
            fontFamily: "Cocogoose",
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ), textAlign: TextAlign.center,),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("E-mail", _emailController, _focusTF1),
        _entryField("Senha ", _passwordController, _focusTF2, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
          body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 66, 125, 255),
                      Color.fromARGB(255, 137, 174, 255),
                      Color.fromARGB(255, 173, 199, 255)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                height: height,
                child: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child:  ListView(
                          children: <Widget>[
                            SizedBox(height: height * .1),
                            _title(),
                            SizedBox(height: 50),
                            _emailPasswordWidget(),
                            SizedBox(height: 20),
                            _submitButton(),
//                            Container(
//                              padding: EdgeInsets.symmetric(vertical: 10),
//                              alignment: Alignment.centerRight,
//                              child: Text('Esqueceu a senha?',
//                                  style: TextStyle(
//                                      fontSize: 14, fontWeight: FontWeight.w500)),
//                            ),
                            SizedBox(height: height * .04),
                            _createAccountLabel(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )))
    );
  }
}
