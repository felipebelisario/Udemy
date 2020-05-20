import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum CameraOptions { camera, galeria }

// ignore: must_be_immutable
class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({String text, File imageFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: () {
                  _attachBottomSheet();
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0
                      ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(12.0))
                  ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100.0,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 7.0),
                    child: Scrollbar(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.multiline,
                              maxLength: null,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enviar uma mensagem",
                                  contentPadding: EdgeInsets.all(10.0)),
                              onChanged: (text) {
                                setState(() {
                                  _isComposing = text.isNotEmpty;
                                });
                              },
                              controller: _messageController,
                            )
                        )),
                  )
                  ),
                )),
              Container(
                width: 55.0,
                height: 55.0,
                padding: EdgeInsets.only(left: 10.0),
                child: FloatingActionButton(
                  child: Icon(Icons.send),
                  onPressed: _isComposing
                      ? () {
                          widget.sendMessage(text: _messageController.text);
                          _messageController.clear();

                          setState(() {
                            _isComposing = false;
                          });
                        }
                      : null,
                ),
              ),
            ],
          ),
        ));
  }

  void _attachBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                      ImagePicker.pickImage(source: ImageSource.camera)
                          .then((file) {
                        if (file == null)
                          return;
                        else {
                          setState(() {
                            widget.sendMessage(imageFile: file.absolute);
                          });
                        }
                      });
                    }),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null)
                        return;
                      else {
                        setState(() {
                          widget.sendMessage(imageFile: file.absolute);
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
