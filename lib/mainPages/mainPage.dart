import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_fish/models/categoryImage.dart';
import 'package:fresh_fish/pages/Profile.dart';
import 'package:fresh_fish/pages/Home.dart';
import 'package:fresh_fish/pages/Offers.dart';
import 'package:fresh_fish/pages/aboutUs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<categoryImage> _category = [
    categoryImage("جمبرى لحم اماراتى","https://5.imimg.com/data5/BM/LW/MY-40538315/frozen-shrimp-pd-500x500.jpg","https://i.ibb.co/qk5jTBw/13604398-a-plate-of-shrimp-cocktail-from-above-removebg-preview.png"),
    categoryImage("جمبرى قشر أماراتى","https://kamelabdo.com/wp-content/uploads/2020/02/7-1.jpg","https://i.ibb.co/kSNChhN/800px-COLOURBOX3225621-removebg-preview.png"),
    categoryImage("جمبرى بلدى","https://i.ibb.co/ZJwqkny/shrimp-lead.jpg","https://i.ibb.co/tJjDdYh/39531-removebg-preview.png"),
    categoryImage("كابوريا","https://kamelabdo.com/wp-content/uploads/2020/02/40-1.jpg","https://i.ibb.co/rsj8DQ1/122749060-gorgeous-seafood-platter-image-removebg-preview.png"),
    categoryImage("سبيط و اخطابوت","https://kamelabdo.com/wp-content/uploads/2020/02/38-1.jpg","https://i.ibb.co/m5t8NZf/121851230-traditional-french-octopus-braised-cooked-with-salicornia-lemon-curd-and-spice-as-top-view.png"),
    categoryImage("جاندوفلى و بلح البحر","https://images.unsplash.com/photo-1448043552756-e747b7a2b2b8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=949&q=80","https://i.ibb.co/d2F7HYP/DSC01035-removebg-preview.png"),
    categoryImage("جزل","https://tonysmarket.com/wp-content/uploads/2017/03/ThinkstockPhotos-533985314.jpg","https://i.ibb.co/47WRwKn/182704-1820-removebg-preview.png"),
    categoryImage("سلمون","https://p0.pikrepo.com/preview/834/625/sliced-fish-meat-on-white-surface.jpg","https://i.ibb.co/7tw7zs2/vzxn0ykh7ppilpjm9k7g-removebg-preview.png"),
    categoryImage("بطارخ","https://www.italian-feelings.com/wp-content/uploads/2019/06/cid_3E213ACC-7341-4877-858A-BD557EAF7444.jpg","https://i.ibb.co/PCmfghy/71pb-S7-IHEi-L-SL1500-removebg-preview.png"),
    categoryImage("سى فود","https://images.unsplash.com/photo-1574653853117-0274131c2175?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80","https://i.ibb.co/cL1kCMG/51248830-cioppino-1x1-removebg-preview.png"),
    categoryImage("فيليه","https://d2j6dbq0eux0bg.cloudfront.net/images/13995032/1409097998.jpg","https://i.ibb.co/bm35L52/Fish-Piccata-feature-2-removebg-preview.png"),
    categoryImage("استاكوزا","https://images.unsplash.com/photo-1590759668628-05b0fc34bb70?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80","https://i.ibb.co/ByRhFmX/IMG-1458-84ff71c8-0fc4-43cf-8072-0a4c62979af1-530x-2x-removebg-preview.png"),
    categoryImage("الاسماك","https://www.fishing.net.nz/default/cache/file/ABCE2B3C-0BA2-4347-C5DECA7D1DBF64FF.jpg","https://i.ibb.co/YDgbMsC/plate-filled-with-fresh-uncooked-seafood-fish-23-2148637889-removebg-preview.png"),
    categoryImage("الطواجن","https://media.linkonlineworld.com/img/large/2018/9/17/2018_9_17_14_2_18_819.jpg","https://i.ibb.co/GstrpTz/3-Tajine-Kefta-Pdt-removebg-preview.png"),
    categoryImage("الوجبات","https://369t7u43n93dgc5pt43uc681-wpengine.netdna-ssl.com/wp-content/uploads/2017/06/Fish-in-Bulk-4-Easy-Quick-recipes.jpg","https://i.ibb.co/t26Grf6/img-4380-810x810-removebg-preview.png"),
    categoryImage("السندوتشات","https://www.fitness.com.hr/images/articles/7e80d98c-b2e2-4fb9-96c1-b75113007860.jpg","https://i.ibb.co/t26Grf6/img-4380-810x810-removebg-preview.png"),
    categoryImage("الارز","https://images.deliveryhero.io/image/talabat/MenuItems/Seafood_Paella_637116705339759832.jpg","https://i.ibb.co/S5LZmW5/5790760526-9e7a973e05-removebg-preview.png"),
    categoryImage("شوربه","https://kitchen.sayidaty.net/uploads/small/35/3598007db869f4c95c7a1dae6c6215f9_w750_h500.jpg","https://i.ibb.co/dcnqyQC/new-england-fish-chowder-56105952-removebg-preview.png"),
    categoryImage("السلطات","https://www.crunchycreamysweet.com/wp-content/uploads/2019/03/overhead-shot-of-salmon-salad.jpg","https://i.ibb.co/jDY2Whw/marketfish-article-740x1005-removebg-preview.png"),
  ];
  ProfileScreen _Profile = ProfileScreen();
  HomeScreen _Home = HomeScreen();
  OffersScreen _Offers = OffersScreen();
  aboutUsScreen _aboutUs = aboutUsScreen();
  Widget _showpage;
  int _index = 3;
  Widget _pageChooser(int page) {
    switch (page) {
      case 3:
        _Home.createState().Constractor(_category);
        return _Home;
        break;
      case 2:
        return _Profile;
        break;
      case 1:
        _Offers.createState().Constractor(_category);
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => storeAdminToken());
    FirebaseMessaging fcm = FirebaseMessaging();
    fcm.requestNotificationPermissions();
    fcm.configure(
      onMessage: (message) {
        print('onMessage' + message.toString());
        return;
      },
      onLaunch: (message) {
        print('onLaunch' + message.toString());
        return;
      },
      onResume: (message) {
        print('onResume' + message.toString());
        return;
      },
    );
  }

  Future<void> storeAdminToken() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult tokenResult = await user.getIdToken();
    if(user.email=='fresh_fish@freshfish.com')
    Firestore.instance
        .collection('Token').document(user.uid)
        .setData({'adminToken':tokenResult.token });
  }

  @override
  Widget build(BuildContext context) {
    changeTab(_index);

    return Scaffold(
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
    );
  }
}
