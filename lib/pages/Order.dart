import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'detailsPage.dart';

class OrderScreen extends StatefulWidget {
  final List<orderitem> cartItem;
  final refresh;
  OrderScreen({this.cartItem, this.refresh});
  @override
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
    return WillPopScope(
      onWillPop: () async {
        widget.refresh();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        body: SafeArea(
          child: Column(children: <Widget>[
            Row(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.046),
            _buildFoodItem(),
          ]),
        ),
      ),
    );
  }

  Widget _buildFoodItem() {
    final user = Provider.of<User>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
        ),
        child: loading
            ? Container(
                color: Colors.white,
                child: Center(
                  child: SpinKitChasingDots(
                    color: Color(0xFF478DE0),
                    size: 50.0,
                  ),
                ),
              )
            : widget.cartItem.length == 0
                ? new Container(
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/20170329-shopping-1-large.jpg"),
                      // fit: BoxFit.cover,
                    ),
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*(1/30)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                                itemCount: widget.cartItem.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.0, right: 16),
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
                                                    isAdmin: _email ==
                                                        "fresh_fish@freshfish.com",
                                                    refresh: refresh)));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                                  isAdmin: _email ==
                                                                      "fresh_fish@freshfish.com",
                                                                  order: true,
                                                                  refresh:
                                                                      refresh)));
                                                        });
                                                      },
                                                    ),
                                                  ]),
                                              Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              widget
                                                                  .cartItem[
                                                                      index]
                                                                  .name,
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize:
                                                                      17.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(
                                                              (widget
                                                                          .cartItem[
                                                                              index]
                                                                          .quantity)
                                                                      .toString() +
                                                                  " Kg",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .grey)),
                                                          Text(
                                                              (widget.cartItem[index].price * widget.cartItem[index].quantity +
                                                                          widget
                                                                              .cartItem[
                                                                                  index]
                                                                              .optionPrice)
                                                                      .toString() +
                                                                  " L.E",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .grey)),
                                                          widget.cartItem[index]
                                                                      .optionName ==
                                                                  ''
                                                              ? new Container()
                                                              : Text(
                                                                  widget
                                                                      .cartItem[
                                                                          index]
                                                                      .optionName,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontSize:
                                                                          15.0,
                                                                      color: Colors
                                                                          .blue)),
                                                        ]),
                                                    SizedBox(width: 5),
                                                    Hero(
                                                        tag: index,
                                                        child: Image(
                                                            image: AssetImage(
                                                                "assets/images/salmon.png"),
                                                            fit: BoxFit.cover,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.1,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.1)),
                                                  ])),
                                            ],
                                          )));
                                }),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() => loading = true);
                                  bool res =
                                      await DatabaseService(uid: user.uid)
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
                                  height: MediaQuery.of(context).size.height *
                                      (1 / 15),
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
                            ],
                          ),
                        ),
                      ]),
      ),
    );
  }

  refresh() {
    setState(() {
//all the reload processes
    });
  }
}
