import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/categories_tab.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawerEnableOpenDragGesture: true,
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          drawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: 30.0,
          body: CategoriesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Container(color: Colors.green,)
      ],
    );
  }
}
