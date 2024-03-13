import 'dart:async';
import 'package:flutter/material.dart';

import 'home_page.dart';

class Splash extends StatefulWidget {
  bool? isProfileSwitch;

  Splash({Key? key, this.isProfileSwitch}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),(){
      _goto(context);
    });
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
        body: Center(child: Text("Mobigic Test",style: TextStyle(fontSize: 40,color: Colors.white),)));
  }

  _goto(BuildContext context) async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    }
}