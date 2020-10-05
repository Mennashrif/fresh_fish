import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fresh_fish/mainPages/login.dart';
import 'package:fresh_fish/mainPages/mainPage.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return LoginScreen();
    } else {
      fixedicon().createState().getcartItem();
      return MultiProvider(
          providers: [
            StreamProvider<DocumentSnapshot>.value(value: DatabaseService(uid: user.uid).user),
            StreamProvider<List<item>>.value(value: DatabaseService().items)
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MainScreen(),
          ));
    }
  }
}
