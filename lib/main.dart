import 'package:flutter/material.dart';
import 'package:fresh_fish/mainPages/splash.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        home:SplashScreen()
    );
  }
}