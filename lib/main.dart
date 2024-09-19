import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'more_info.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/more_info': (context) => MoreInfoScreen(),
      },
    );
  }
}
