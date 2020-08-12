import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_fish/models/item.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';

class OrderScreen extends StatefulWidget {
  @override
  final List<orderitem> cartItem;
  final refresh;
  final refreshHome;
  OrderScreen({this.cartItem, this.refresh, this.refreshHome});
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  double sum() {
    double total = 0;
    setState(() {
      for (int i = 0; i < widget.cartItem.length; i++) {
        total += (widget.cartItem[i].price * widget.cartItem[i].quantity) +
            widget.cartItem[i].optionPrice;
      }
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.refresh();
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
                    widget.refresh();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Shopping',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('Cart',
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
    final user = Provider.of<User>(context);
    return Container(
      height: MediaQuery.of(context).size.height - 185.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
      ),
      child: loading
          ? Container(
              color: Color(0xFF478DE0),
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.brown[100],
                  size: 50.0,
                ),
              ),
            )
          : widget.cartItem.length == 0
              ? new Container(
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://freedesignfile.com/upload/2017/06/Different-practices-delicious-fish-dishes-Stock-Photo-07.jpg"),
                    // fit: BoxFit.cover,
                  ),
                ))
              : ListView(
                  primary: false,
                  padding: EdgeInsets.only(left: 25.0, right: 20.0),
                  children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 45.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 450.0,
                          child: ListView.builder(
                              itemCount: widget.cartItem.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                  heroTag:
                                                      "assets/images/salmon.png",
                                                  foodName: widget
                                                      .cartItem[index].name,
                                                  foodPrice: widget
                                                      .cartItem[index].price,
                                                  order: true,
                                                  refresh: refresh)));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .remove_shopping_cart),
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        fixedicon()
                                                            .createState()
                                                            .decreasecart(
                                                                index);
                                                      });
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.edit),
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        Navigator.of(context).push(MaterialPageRoute(
                                                            builder: (context) => DetailsPage(
                                                                heroTag:
                                                                    "assets/images/salmon.png",
                                                                foodName: widget
                                                                    .cartItem[
                                                                        index]
                                                                    .name,
                                                                foodPrice: widget
                                                                    .cartItem[
                                                                        index]
                                                                    .price,
                                                                edit: true,
                                                                index: index,
                                                                order: true,
                                                                refresh:
                                                                    refresh)));
                                                      });
                                                    },
                                                  ),
                                                ]),
                                            Container(
                                                child: Row(children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        widget.cartItem[index]
                                                            .name,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        (widget.cartItem[index]
                                                                    .quantity)
                                                                .toString() +
                                                            " " +
                                                            "Kg",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.grey)),
                                                    Text(
                                                        (widget.cartItem[index]
                                                                            .price *
                                                                        widget
                                                                            .cartItem[
                                                                                index]
                                                                            .quantity +
                                                                    widget
                                                                        .cartItem[
                                                                            index]
                                                                        .optionPrice)
                                                                .toString() +
                                                            " " +
                                                            "L.e",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.grey)),
                                                    widget.cartItem[index].optionName ==
                                                            ''
                                                        ? new Container()
                                                        : Text(
                                                            widget
                                                                .cartItem[index]
                                                                .optionName,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .blue)),
                                                  ]),
                                              Hero(
                                                  tag: index,
                                                  child: Image(
                                                      image: NetworkImage(
                                                          "http://chikk.net/wp-content/uploads/2017/02/Delicious-Fish-Recipes-to-Try-for-Lunch-This-Week-660x330.jpg"),
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
                      Container(
                        height: 230.0,
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 10,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      color: Color(0xFF9BA7C6),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  sum().toString() + " " + "L.e",
                                  style: TextStyle(
                                      color: Color(0xFF6C6D6D),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Delivery",
                                  style: TextStyle(
                                      color: Color(0xFF9BA7C6),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "5 L.e",
                                  style: TextStyle(
                                      color: Color(0xFF6C6D6D),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              height: 2.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Cart Total",
                                  style: TextStyle(
                                      color: Color(0xFF9BA7C6),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  (sum() + 5).toString() + " " + "L.e",
                                  style: TextStyle(
                                      color: Color(0xFF6C6D6D),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() => loading = true);
                                bool res = await DatabaseService(uid: user.uid)
                                    .addOrder(widget.cartItem);
                                if (!res) {
                                  setState(() {
                                    loading = false;
                                    Fluttertoast.showToast(
                                        msg: "Order Failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Order Successfull",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    fixedicon().createState().cleancart();
                                    loading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(35.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Proceed To Checkout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
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
