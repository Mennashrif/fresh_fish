import 'package:flutter/material.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/services/auth.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';

import 'items.dart';

class HomeScreen extends StatefulWidget {
  // final FoodModel foodModel;

  // HomePage(this.foodModel);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Food> _foods = foods;

  @override
  void initState() {
    super.initState();

  }
  int _index = 0;
  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  final AuthService _auth = AuthService();
  final List<String> categoryList =
  ["جمبرى لحم اماراتى","جمبرى قشر أماراتى","جمبرى بلدى","كابوريا","مشكل","بطارخ","فيليه","الاسماك"];
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<item>>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new Container(),
        elevation: 0.0,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              fixedicon(),
            ],),
        ],
      ),
      body: ListView(
          padding: EdgeInsets.only(top:20.0,left: 20.0),
          children: <Widget>[
           /* Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                 fixedicon(),
            ],),*/
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: SizedBox(
                  height: 200, // card height
                  child: PageView.builder(
                    itemCount: 10,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) => setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Card ${i + 1}",
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                                onPressed: () async {
                                  await _auth.signOut();
                                },
                            )),
                        border: InputBorder.none,
                        hintText: "Search Foods")),
              ),
            ),
            SizedBox( height:12),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => itemsPage(category:categoryList[index],items:items,refreshHome:refreshHome)
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        child:Stack(
                          children:<Widget>[
                            Container(
                              height: 230.0,
                              width: 340.0,
                               child: new Image.network("https://images.unsplash.com/photo-1517115358639-5720b8e02219?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1054&q=80",
                                 fit: BoxFit.cover,),

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

                           ]
                          ),
                          ),
                      ),
                    );

                      }
                    ),
            ),
            ]
            ),
    );
  }
  refreshHome() {
    setState(() {
//all the reload processes
    });
  }
}
