import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_fish/mainPages/splash.dart';
import 'package:fresh_fish/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
