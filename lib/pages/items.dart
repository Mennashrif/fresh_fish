import 'package:flutter/material.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';

class itemsPage extends StatefulWidget {
  final category;
  //final items;
  final refreshHome;
  final bool searchPage;
  final List<item> searchResult;
  final email ;
  itemsPage(
      {this.category, this.refreshHome, this.searchPage, this.searchResult,@required this.email});

  @override
  _itemsPageState createState() => _itemsPageState();
}

class _itemsPageState extends State<itemsPage> {
  List<item> fillListofcategory(List<item> items) {
    List<item> Listofcategory = [];
    if (items != null) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].category == widget.category) {
          print(items[i].name);
          Listofcategory.add(items[i]);
        }
      }
    }
    return Listofcategory;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.refreshHome();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    widget.refreshHome();
                    Navigator.of(context).pop();
                  },
                ),
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
      ),
    );
  }

  Widget _buildFoodItem() {
    final items = Provider.of<List<item>>(context);
    List<item> Listofcategory =
        widget.searchPage ? widget.searchResult : fillListofcategory(items);
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
                height: MediaQuery.of(context).size.height - 300.0,
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
                                        foodPrice: Listofcategory[index]
                                                .Isoffered
                                            ? (Listofcategory[index].price -
                                                Listofcategory[index].theOffer)
                                            : Listofcategory[index].price,
                                        order: false,
                                        isAdmin: widget.email=="fresh_fish@freshfish.com",
                                        id: Listofcategory[index].id,
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
                                                    "L.e",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15.0,
                                                  color: Colors.grey,
                                                  decoration:
                                                      Listofcategory[index]
                                                              .Isoffered
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null,
                                                )),
                                            Listofcategory[index].Isoffered
                                                ? Text(
                                                    (Listofcategory[index]
                                                                    .price -
                                                                Listofcategory[
                                                                        index]
                                                                    .theOffer)
                                                            .toString() +
                                                        " " +
                                                        "L.e",
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 15.0,
                                                      color: Colors.blue,
                                                    ))
                                                : new Container(),
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
