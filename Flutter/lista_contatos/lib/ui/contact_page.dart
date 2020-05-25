import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = MaskedTextController(mask: '(00) 00000-0000');

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _showCameraOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Abrir com..."),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);

                        ImagePicker.pickImage(source: ImageSource.camera)
                            .then((file) {
                          if (file == null)
                            return;
                          else {
                            setState(() {
                              _editedContact.img = file.path;
                              print(file.runtimeType);
                            });
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.camera_alt),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text("Câmera"),
                          )
                        ],
                      ),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);

                        ImagePicker.pickImage(source: ImageSource.gallery)
                            .then((file) {
                          if (file == null)
                            return;
                          else {
                            setState(() {
                              _editedContact.img = file.path;
                            });
                          }
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.collections),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text("Galeria"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editedContact.name ?? "Novo contato"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {
              if (_editedContact.name != null &&
                  _editedContact.name.isNotEmpty) {
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            backgroundColor: Colors.red,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _showCameraOptions();
                  },
                  child: Container(
                    child: _editedContact.img == null ? Icon(Icons.camera_alt, size: 50.0, color: Colors.black,) :
                    Icon(Icons.camera_alt, size: 50.0, color: Colors.white,),
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: _editedContact.img != null
                                ? FileImage(File(_editedContact.img))
                                : AssetImage("images/person.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
                TextField(
                  focusNode: _nameFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
                  style: TextStyle(fontSize: 20.0),
                  controller: _nameController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (text) {
                      _userEdited = true;
                      _editedContact.email = text;
                    },
                    style: TextStyle(fontSize: 20.0),
                    controller: _emailController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Phone"),
                    onChanged: (text) {
                      String _stringPhone = _phoneController.text;

                      _stringPhone = _stringPhone.replaceAll('(', '');
                      _stringPhone = _stringPhone.replaceAll(')', '');
                      _stringPhone = _stringPhone.replaceAll('-', '');
                      _stringPhone = _stringPhone.replaceAll(' ', '');

                      _userEdited = true;
                      _editedContact.phone = _stringPhone;
                    },
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    controller: _phoneController,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
