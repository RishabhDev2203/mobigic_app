import 'package:flutter/material.dart';
import 'package:mobigic_app/splash.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobigic Test',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
