import 'package:fresh_fish/mainPages/signUp.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fresh_fish/mainPages/login.dart';
import 'package:fresh_fish/mainPages/mainPage.dart';

class Wrapper extends StatelessWidget {
  @override


  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return MainScreen();
    }

  }
}