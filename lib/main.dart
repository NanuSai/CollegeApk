import 'package:flutter/material.dart';
import 'package:test_project/home_page.dart';

import 'login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WEB SERVICE",
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/second': (context) => HomePage()
      },
    );
  }
}

void main() => runApp(MyApp());
