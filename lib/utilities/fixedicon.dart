import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/pages/Order.dart';
import 'package:shared_preferences/shared_preferences.dart';
class fixedicon extends StatefulWidget {
  final order;
  final refresh;
  final refreshHome;
  fixedicon({this.order, this.refresh, this.refreshHome});
  @override
  _fixediconState createState() => _fixediconState();
}

class _fixediconState extends State<fixedicon>
    with SingleTickerProviderStateMixin {

  static List<orderitem> cartItem = [];
   get getCart{
    return cartItem;
  }
  void increasecart(orderitem item) {
    cartItem.add(item);
    savecartItem();
  }

  void decreasecart(int index) {
    cartItem.removeAt(index);
    savecartItem();
  }

  void editcart(int index, orderitem item) {
    cartItem[index] = item;
    savecartItem();
  }

  void cleancart()  {
    cartItem.removeRange(0, cartItem.length);
  }
 void savecartItem() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   final String s=orderitem.encodeMusics(cartItem);
  prefs.setString('cartItem', s);
 }
 void getcartItem() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   cartItem=orderitem.decodeMusics(prefs.getString('cartItem'));
 }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.order) {
          widget.refresh();
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  OrderScreen(cartItem: cartItem, refresh: widget.refresh)));
        }
      },
      child: new Stack(
        children: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              if (widget.order) {
                widget.refresh();
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderScreen(
                        cartItem: cartItem, refresh: widget.refresh)));
              }
            },
          ),
          cartItem.length == 0
              ? new Container()
              : new Positioned(
                  child: new Stack(
                  children: <Widget>[
                    new Icon(Icons.brightness_1,
                        size: 20.0, color: Colors.green[800]),
                    new Positioned(
                        top: 3.0,
                        right: 4.0,
                        child: new Center(
                          child: new Text(
                            cartItem.length.toString(),
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ],
                )),
        ],
      ),
    );
  }
}
