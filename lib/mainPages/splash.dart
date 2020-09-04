import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fresh_fish/mainPages/login.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:fresh_fish/mainPages/wrapper.dart';
import 'mainPage.dart';
// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  bool _appStart = true;
  @override
  void initState() {
    super.initState();

    // TODO: implement initState

    Timer(Duration(seconds: 5), (){
      if(_appStart) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
         _appStart = false;
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(

                child: FlareActor(
                  "assets/logos/New File.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  animation: "Untitled Duplicate Duplicate",

                ),

              ),
            ],
          ),
        ),
      ),
    );

  }

}