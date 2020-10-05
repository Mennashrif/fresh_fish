import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/categoryImage.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';

class itemsPage extends StatefulWidget {
  final category;
  final heroTag;
  final refreshHome;
  final bool searchPage;
  final String searchText;
  final List<categoryImage> imageSearch;
  final email ;
  itemsPage(
      {this.heroTag,this.category,this.refreshHome, this.searchPage,this.searchText,this.imageSearch,@required this.email});

  @override
  _itemsPageState createState() => _itemsPageState();
}


class _itemsPageState extends State<itemsPage> {
  List<item> fillListofcategory(List<item> items) {
    List<item> Listofcategory = [];
    if (items != null) {
      if (widget.searchPage) {
        print(widget.searchText);
        for (int i = 0; i < items.length; i++) {
          if (items[i].name.contains(widget.searchText)) {
            Listofcategory.add(items[i]);
          }
        }
      }
      else {
        for (int i = 0; i < items.length; i++) {
          if (items[i].category == widget.category) {
            Listofcategory.add(items[i]);
          }
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
    List<item> Listofcategory=fillListofcategory(items);
    print(MediaQuery.of(context).size.height);
    return Container(
      height: MediaQuery.of(context).size.height *0.748,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
      ),
      child: ListView(
          primary: false,
          padding: EdgeInsets.only(left: 25.0, right: 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.06),
              child: Container(
               height: MediaQuery.of(context).size.height*0.63,
                child: ListView.builder(
                    itemCount: Listofcategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  heroTag: widget.searchPage?widget.imageSearch[widget.imageSearch.indexWhere((element) => element.name==Listofcategory[index].category)].itemImage: widget.heroTag,
                                  order: false,
                                  refresh: refresh,
                                  Item: Listofcategory[index],
                                  isAdmin: widget.email == "fresh_fish@freshfish.com",)));
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
                                                " جم",
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
                                                    "جم",
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
                                    child: ExtendedImage.network(
                                      widget.searchPage?widget.imageSearch[widget.imageSearch.indexWhere((element) => element.name==Listofcategory[index].category)].itemImage: widget.heroTag,
                                      width: 75.0,
                                      height: 75.0,
                                      fit: BoxFit.cover,
                                      cache: true,
                                    ),),
                              ])),
                            ],
                          ));
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
