import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fresh_fish/mainPages/login.dart';
import 'package:flare_flutter/flare_actor.dart';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  _animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 300)
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animation.addListener(()=> this.setState((){}));
    _animationController.forward();*/

    Timer(Duration(seconds: 7), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                  callback: (String val){
                    LoginScreen();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}