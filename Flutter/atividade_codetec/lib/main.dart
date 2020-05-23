import 'package:atividadecodetec/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atividade CodeTec',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 83, 171),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
