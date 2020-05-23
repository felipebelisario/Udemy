import 'package:atividadecodetec/tabs/home_tab.dart';
import 'package:atividadecodetec/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack(Widget _child) => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 20, 126, 203),
            Color.fromARGB(255, 80, 148, 197),
            Color.fromARGB(255, 105, 169, 217)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: _child,
    );

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Equipes"),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on),),
                Tab(icon: Icon(Icons.list))
              ],
            ),
          ),
          drawerEnableOpenDragGesture: true,
          body: _buildBodyBack(HomeTab()),
          drawer: CustomDrawer(_pageController),
        )
      ),
//        Scaffold(
//          appBar: AppBar(
//            title: Text("Categorias"),
//            centerTitle: true,
//          ),
//          drawerEnableOpenDragGesture: true,
//          drawerEdgeDragWidth: 30.0,
//          body: CategoriesTab(),
//          drawer: CustomDrawer(_pageController),
//        ),
        Container(color: Colors.green,)
      ],
    );
  }
}