import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';

class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
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

  String _email;
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
    final uid = Provider.of<User>(context);
    final user = Provider.of<QuerySnapshot>(context);
    getdata(user, uid);
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              fixedicon(order: false, refresh: refresh),
            ],
          ),
        ),
        SizedBox(height: 25.0),
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Row(
            children: <Widget>[
              Text('Fresh',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              SizedBox(width: 10.0),
              Text('Fish',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 25.0))
            ],
          ),
        ),
        SizedBox(height: 40.0),
        _buildFoodItem(),
      ]),
    );
  }

  Widget _buildFoodItem() {
    final items = Provider.of<List<item>>(context);
    List<item> Listofcategory = fillListofcategory(items);
    return Container(
      height: MediaQuery.of(context).size.height - 185.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
      ),
      child: ListView(
          primary: false,
          padding: EdgeInsets.only(left: 25.0, right: 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 45.0),
              child: Container(
                height: MediaQuery.of(context).size.height *0.6,
                child: ListView.builder(
                    itemCount: Listofcategory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        heroTag: "assets/images/salmon.png",
                                        foodName: Listofcategory[index].name,
                                        foodPrice:
                                            (Listofcategory[index].price -
                                                Listofcategory[index].theOffer),
                                        order: false,
                                        quantity: Listofcategory[index].quantity,
                                        id: Listofcategory[index].id,
                                        isAdmin: _email ==
                                            "fresh_fish@freshfish.com",
                                        refresh: refresh)));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.add, color: Colors.black),
                                  Container(
                                      child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(Listofcategory[index].name,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                Listofcategory[index]
                                                        .price
                                                        .toString() +
                                                    " " +
                                                    "جم",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                )),
                                            Text(
                                                (Listofcategory[index].price -
                                                            Listofcategory[
                                                                    index]
                                                                .theOffer)
                                                        .toString() +
                                                    " " +
                                                    "جم",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15.0,
                                                  color: Colors.blue,
                                                ))
                                          ]),
                                    ),
                                    Hero(
                                        tag: index,
                                        child: Image(
                                            image: AssetImage(
                                                "assets/images/salmon.png"),
                                            fit: BoxFit.cover,
                                            height: 75.0,
                                            width: 75.0)),
                                    SizedBox(width: 10.0),
                                  ])),
                                ],
                              )));
                    }),
              ),
            ),
          ]),
    );
  }

  refresh() {
    setState(() {
//all the reload processes
    });
  }
}
