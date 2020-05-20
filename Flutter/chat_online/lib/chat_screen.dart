import 'package:chatonline/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chatonline/chat_message.dart';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _currentUser;
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
      FirebaseAuth.instance.onAuthStateChanged.listen((user) {
        setState(() {
          _currentUser = user;
        });
      });
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return authResult.user;
    } catch (error) {
      return null;
    }
  }

  void _sendMessage({String text, File imageFile}) async {
    final FirebaseUser user = await _getUser();

    if (user == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Não foi possível fazer o login. Tente novamente!"),
        backgroundColor: Colors.red,
      ));
    }

    Map<String, dynamic> data = {
      "uid": _currentUser.uid,
      "senderName": _currentUser.displayName,
      "senderPhotoUrl": _currentUser.photoUrl,
      "time": Timestamp.now()
    };

    if (imageFile != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref().child(_currentUser.uid)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imageFile);

      setState(() {
        _isLoading = true;
      });

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data["imgUrl"] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if (text != null) {
      data["text"] = text;
    }

    Firestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser == null
        ? Container(
            child: Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.black38, width: 2.0)
                ),
                textColor: Colors.blue,
                child: Text("Login", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                onPressed: () {
                  _getUser().then((value) => null);
                },
              ),
            ),
            color: Colors.blue,
          )
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("${_currentUser.displayName}"),
              actions: <Widget>[
                _currentUser != null
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          googleSignIn.signOut();
                        },
                      )
                    : Container()
              ],
              elevation: 0,
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection("messages").orderBy("time").snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          List<DocumentSnapshot> documents =
                              snapshot.data.documents.reversed.toList();

                          return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              return ChatMessage(documents[index].data,
                              documents[index].data["uid"] == _currentUser?.uid);
                            },
                            reverse: true,
                          );
                      }
                    },
                  ),
                ),
                _isLoading ? LinearProgressIndicator() : Container(),
                TextComposer(_sendMessage),
              ],
            ));
  }
}
