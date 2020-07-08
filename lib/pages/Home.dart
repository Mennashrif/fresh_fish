import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final List<String> categoryList =
  ["جمبري قشر اماراتي ","جمبري لحم اماراتي ","جمبري بلدي ","كابوريا","بطارخ","فيليه","الاسماك"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
          padding: EdgeInsets.only(top:50.0,left: 20.0, right: 20.0),
          children: <Widget>[
            Center(
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
            SizedBox(height: 20,),
            Material(
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
                            onPressed: ()=>print("search icon pressed"),
                          )),
                      border: InputBorder.none,
                      hintText: "Search Foods")),
            ),
            SizedBox( height:12),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index){
                    return Container(
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
                    );

                      }
                    ),

              ),
            ]
            ),
    );
  }
}
