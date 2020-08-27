import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fresh_fish/mainPages/login.dart';
import 'package:fresh_fish/mainPages/mainPage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either the Home or Authenticate widget
    if (user == null) {
      return LoginScreen();
    } else {
      return StreamProvider<List<item>>.value(
          value: DatabaseService().items,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MultiProvider(providers: [
              StreamProvider<QuerySnapshot>.value(
                  value: DatabaseService().users),
            ], child: MainScreen()),
          ));
    }
  }
}
