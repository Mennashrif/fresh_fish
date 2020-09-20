import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/categoryImage.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/pages/ordersList.dart';
import 'package:fresh_fish/services/auth.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';
import 'items.dart';

class HomeScreen extends StatefulWidget {
  @override

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  String _email;
  final textStyle = TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold);
  static List<categoryImage> _category;
  final _textFieldController = TextEditingController();
  void Constractor(List<categoryImage> categorys){
       _category=categorys;
  }
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


  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<item>>(context);
    final user = Provider.of<DocumentSnapshot>(context);
    if (user !=null && user.exists) {
      _email = user.data['email'];

    }
    List<item> Listofcategory = fillListofcategory(items);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: ()async {
              fixedicon().createState().cleancart();
              AuthService auth = AuthService();
              await auth.signOut();
            },
            child: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            )),
        elevation: 0.0,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Visibility(
                visible:_email == "fresh_fish@freshfish.com" ,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrdersList()));
                      },
                      child:
                          Icon(Icons.local_shipping, color: Colors.black))),
              fixedicon(order: false, refresh: refreshHome),
            ],
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Center(
          child: SizedBox(
            height: 200, // card height
            child: PageView.builder(
              itemCount: Listofcategory.length,
              controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (con, i) {
                return InkWell(
                  onTap: ()  {
                   // print(categoryList.indexOf(Listofcategory[i].category));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            heroTag:_category[_category.indexWhere((element) => element.name==Listofcategory[i].category)].itemImage,
                            order: false,
                            refresh: refreshHome,
                            Item: Listofcategory[i],
                            isAdmin: _email == "fresh_fish@freshfish.com",)));
                  },
                  child: Transform.scale(
                    scale: i == _index ? 1 : 0.9,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        padding:EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center
                            ,children: [
                          Hero(
                              tag: i,
                              child:Container(
                                  child:ExtendedImage.network(
                                _category[_category.indexWhere((element) => element.name==Listofcategory[i].category)].itemImage,
                                fit: BoxFit.cover,
                                cache: true,
                              ),
                                width: 90.0,
                                height:90.0,),
                            /*Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:CachedNetworkImageProvider(_category[_category.indexWhere((element) => element.name==Listofcategory[i].category)].itemImage),
                                          fit: BoxFit.cover)),
                                  height: 90.0,
                                  width: 90.0)*/),
                          Column(
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
                                              "جم",
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
                                              "جم",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18.0,
                                            color: Colors.blue,
                                          ))
                                    ])
                              ]),
                        ]),
                      ),
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
                textInputAction: TextInputAction.done,
                onSubmitted: (value){
                  if (_textFieldController.text.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => itemsPage(
                            searchPage: true,
                            email: _email,
                            searchText:_textFieldController.text,
                            imageSearch: _category,
                            refreshHome: refreshHome)));
                    setState(() {
                      _textFieldController.clear();
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        onPressed: ()  {
                          if (_textFieldController.text.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => itemsPage(
                                    searchPage: true,
                                    email: _email,
                                    searchText:_textFieldController.text,
                                    imageSearch: _category,
                                    refreshHome: refreshHome)));
                            setState(() {
                              _textFieldController.clear();
                            });
                          }
                        },
                      )),
                  border: InputBorder.none,
                  hintText: "البحث",
                )),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(right: 20.0, left: 20),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount:_category.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => itemsPage(
                            heroTag: _category[index].itemImage,
                            searchPage: false,
                            email: _email,
                            category: _category[index].name,
                            refreshHome: refreshHome)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Stack(children: <Widget>[
                        ExtendedImage.network(
                          _category[index].categoryImages,
                          width: 340.0,
                          height: 230.0,
                          fit: BoxFit.cover,
                          cache: true,
                        ),
                        /*Container(
                          height: 230.0,
                          width: 340.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:  CachedNetworkImageProvider(
                                      _category[index].categoryImage,
                                    ),

                                    fit: BoxFit.cover)),
                        ),*/
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
                              _category[index].name,
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
    );
  }

  refreshHome() {
    setState(() {
//all the reload processes
    });
  }
}
