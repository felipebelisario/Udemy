import 'package:flutter/material.dart';
import 'package:listacontatos/helpers/contact_helper.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'contact_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();

    _getContacts();
  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        contacts.sort((a,b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a,b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) =>
            <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderaz,),
              const PopupMenuItem<OrderOptions>(child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderza,)
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _buildList(context, index);
          }),
    );
  }

  Widget _buildList(context, index) {
    final _phoneController = MaskedTextController(
        mask: '(00) 00000-0000', text: contacts[index].phone);

    return GestureDetector(
      onTap: () {
        _showOptions(context, index);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacts[index].img != null
                            ? FileImage(File(contacts[index].img))
                            : AssetImage("images/person.png"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 165.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contacts[index].name ?? "",
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          Text(contacts[index].email ?? "",
                              style: TextStyle(
                                  fontSize: 18.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          Text(_phoneController.text ?? "",
                              style: TextStyle(
                                  fontSize: 18.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  _deleteConfirmation(index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja excluir esse contato?"),
            content: Text("Caso sim você não poderá recuperá-lo."),
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
                  helper.deleteContact(contacts[index].id);

                  setState(() {
                    contacts.removeAt(index);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
              )
            ],
          );
        });
  }

  _showOptions(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: FlatButton(
                        child: Text("Ligar",
                            style:
                            TextStyle(color: Colors.red, fontSize: 20.0)),
                        onPressed: () {
                          launch("tel:${contacts[index].phone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: FlatButton(
                        child: Text("Editar",
                            style:
                            TextStyle(color: Colors.red, fontSize: 20.0)),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContactPage(contact: contacts[index]);
                        },
                      ),
                    ),
                    Divider(
                      thickness: 0.3,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: FlatButton(
                          child: Text("Excluir",
                              style:
                              TextStyle(color: Colors.red, fontSize: 20.0)),
                          onPressed: () {
                            _deleteConfirmation(index);
                          }),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _getContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));

    if (recContact != null) {
      // Caso ele tenha me enviado de volta algum contato
      if (contact != null) {
        // Caso eu tenha enviado algum contato (UPDATE)
        await helper.updateContact(recContact);
      } else {
        // Caso eu nao tenha enviado algum contato (NEW)
        await helper.saveContact(recContact);
      }
      _getContacts();
    }
  }
}
