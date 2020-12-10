import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text("Criar Conta"),
            centerTitle: true
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.isLoading) return Container(
              child: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),),
              ),
            );
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.0, 35.0, 16.0, 16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    // ignore: missing_return
                    validator: (text){
                      if(text.isEmpty) return "Nome inválido!";
                    },
                    decoration: InputDecoration(
                        hintText: "Nome",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                    },
                    decoration: InputDecoration(
                        hintText: "E-mail",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passController,
                    // ignore: missing_return
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida!";
                    },
                    decoration: InputDecoration(
                        hintText: "Senha",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    obscureText: true,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    // ignore: missing_return
                    validator: (text){
                      if(text.isEmpty) return "Endereço inválido!";
                    },
                    decoration: InputDecoration(
                        hintText: "Endereço",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 40.0,),
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                      child: Text("Registrar",
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSucess: _onSucess,
                              onFail: _onFail
                          );


                        }
                      },
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSucess(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );

    Future.delayed(Duration(
      seconds: 2,
    )).then((_){
      cleanFields();
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        )
    );
  }

  void cleanFields(){
    _nameController.text = "";
    _emailController.text = "";
    _passController.text = "";
    _addressController.text = "";
  }

}