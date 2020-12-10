import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(this.pageController);

  final PageController pageController;

  Widget _buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 211, 118, 130),
          Color.fromARGB(255, 253, 181, 168)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Stack(
            children: <Widget>[
              _buildDrawerBack(),
              ListView(
                padding: EdgeInsets.only(left: 32.0, top: 16.0),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                    height: 220.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 8.0,
                          left: 100.0,
                          child: Text(
                            "Flutter's\nClothing",
                            style: TextStyle(
                                fontSize: 55.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'SweetPurple'),
                          ),
                        ),
                        Positioned(
                          top: 35.0,
                          left: 0.0,
                          child: Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage('images/blue-shirt.png'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(50.0)),
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        if(!model.isLoggedIn())
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                        else
                                          model.signOut();
                                      },
                                      child: Text(
                                        !model.isLoggedIn() ? "Entre ou cadastre-se >" : "Sair",
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  DrawerTile(Icons.home, "Início", pageController, 0),
                  DrawerTile(Icons.list, "Produtos", pageController, 1),
                  DrawerTile(Icons.location_on, "Lojas", pageController, 2),
                  DrawerTile(
                      Icons.playlist_add_check, "Meus pedidos", pageController, 3),
                ],
              ),
            ],
          ),
        );
  }
}
