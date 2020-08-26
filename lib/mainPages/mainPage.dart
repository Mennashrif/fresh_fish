import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_fish/pages/Profile.dart';
import 'package:fresh_fish/pages/Home.dart';
import 'package:fresh_fish/pages/Offers.dart';
import 'package:fresh_fish/pages/aboutUs.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  ProfileScreen _Profile = ProfileScreen();
  HomeScreen _Home = HomeScreen();
  OffersScreen _Offers = OffersScreen();
  aboutUsScreen _aboutUs = aboutUsScreen();
  Widget _showpage;
  int _index = 3;

  Widget _pageChooser(int page) {
      switch (page) {
        case 3:
          return _Home;
          break;
        case 2:
          return _Profile;
          break;
        case 1:
          return _Offers;
          break;
        case 0:
          return _aboutUs;
          break;
      }
    return null;
  }

  void changeTab(int index) {
    setState(() {
      _showpage = _pageChooser(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    changeTab(_index);
    return WillPopScope(
      onWillPop: () {
        print('onWillPop in Main Called');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        return;
      },
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xFF7A9BEE),
          height: 60,
          items: <Widget>[
                  Icon(Icons.live_help, size: 25),
                  Icon(Icons.local_offer, size: 25),
                  Icon(Icons.account_circle, size: 25),
                  Icon(Icons.home, size: 25),
                ],
          index: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
        //body: Container(color: Colors.blueAccent),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(children: <Widget>[
              Center(
                child: Container(
                  child: _showpage,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
