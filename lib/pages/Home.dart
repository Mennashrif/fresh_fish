import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/mainPages/mainPage.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/pages/ordersList.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';
import 'items.dart';

class HomeScreen extends StatefulWidget {
  // final FoodModel foodModel;

  // HomePage(this.foodModel);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Food> _foods = foods;

  int _index = 0;
  String _email;
  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  final List<String> categoryList = [
    "جمبرى لحم اماراتى",
    "جمبرى قشر أماراتى",
    "جمبرى بلدى",
    "كابوريا",
    "سبيط و اخطابوت",
    "جاندوفلى و بلح البحر",
    "جزل",
    "سلمون",
    "بطارخ",
    "سى فود",
    "فيليه",
    "استاكوزا",
    "الاسماك"
  ];
  final _textFieldController = TextEditingController();
  List<item> fillListofcategory(List<item> items) {
    List<item> Listofcategory = [];
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].Isoffered) {
          Listofcategory.add(items[i]);
        }
      }
    }
    return Listofcategory;
  }

  void getdata(final user, final uid) {
    if (user != null) {
      for (int i = 0; i < user.documents.length; i++) {
        if (user.documents[i].documentID == uid.uid) {
          _email = user.documents[i].data['email'];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<item>>(context);
    final uid = Provider.of<User>(context);
    final user = Provider.of<QuerySnapshot>(context);
    getdata(user, uid);
    List<item> Listofcategory = fillListofcategory(items);
    return WillPopScope(
      onWillPop: () {
        print('onWillPop in HOME Called');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new Container(),
          elevation: 0.0,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Visibility(child: GestureDetector(onTap:(){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>OrdersList()));},child: Icon(Icons.local_shipping, color: Colors.black))),
                fixedicon(order: false, refresh: refreshHome),
              ],
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                   fixedicon(),
              ],),*/
          Center(
            child: SizedBox(
              height: 200, // card height
              child: PageView.builder(
                itemCount: Listofcategory.length,
                controller: PageController(viewportFraction: 0.7),
                onPageChanged: (int index) => setState(() => _index = index),
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              heroTag: "assets/images/salmon.png",
                              foodName: Listofcategory[i].name,
                              foodPrice: (Listofcategory[i].price -
                                  Listofcategory[i].theOffer),
                              order: false,
                              isAdmin: _email == "fresh_fish@freshfish.com",
                              id: Listofcategory[i].id,
                              refresh: refreshHome)));
                    },
                    child: Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(children: [
                          Positioned(
                            top: 10.0,
                            left:
                                (MediaQuery.of(context).size.width / 2) - 115.0,
                            child: Hero(
                                tag: i,
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/salmon.png"),
                                            fit: BoxFit.cover)),
                                    height: 90.0,
                                    width: 90.0)),
                          ),
                          Positioned(
                              top: 103,
                              left: 25.0,
                              right: 10.0,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(Listofcategory[i].name,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold)),
                                    /*SizedBox(height: 1.0),*/
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              Listofcategory[i]
                                                      .price
                                                      .toString() +
                                                  " " +
                                                  "L.E",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          Text(
                                              (Listofcategory[i].price -
                                                          Listofcategory[i]
                                                              .theOffer)
                                                      .toString() +
                                                  " " +
                                                  "L.E",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 18.0,
                                                color: Colors.blue,
                                              ))
                                        ])
                                  ])),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: TextField(
                  controller: _textFieldController,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  cursorColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    suffixIcon: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            /*fixedicon().createState().cleancart();
                                    await _auth.signOut();*/
                            if (_textFieldController.text.isNotEmpty) {
                              DatabaseService databaseService =
                                  DatabaseService(uid: uid.uid);
                              List<item> result = await databaseService
                                  .fetchSearchResult(_textFieldController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => itemsPage(
                                      searchPage: true,
                                      email: _email,
                                      searchResult: result,
                                      refreshHome: refreshHome)));
                            }
                          },
                        )),
                    border: InputBorder.none,
                    hintText: "Search Foods",
                  )),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => itemsPage(
                              searchPage: false,
                              email: _email,
                              category: categoryList[index],
                              refreshHome: refreshHome)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: Stack(children: <Widget>[
                          Container(
                            height: 230.0,
                            width: 340.0,
                            child: new Image.network(
                              "https://images.unsplash.com/photo-1517115358639-5720b8e02219?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1054&q=80",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 0.0,
                            bottom: 0.0,
                            width: 340.0,
                            height: 60.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black, Colors.black12])),
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            right: 10.0,
                            child: Center(
                              child: Text(
                                categoryList[index],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }

  refreshHome() {
    setState(() {
//all the reload processes
    });
  }
}
