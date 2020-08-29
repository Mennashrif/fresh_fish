import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/models/user.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/fixedicon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Profile.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  String _email = '';
  String _address = '';
  String _phone = '';
  double sum() {
    double total = 0;
    setState(() {
      for (int i = 0; i < widget.cartItem.length; i++) {
        total += (widget.cartItem[i].price * widget.cartItem[i].quantity) +
            widget.cartItem[i].optionPrice*widget.cartItem[i].quantity;
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
                  Text('التسوق',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 25.0)),
                  SizedBox(width: 10.0),
                  Text('عربة',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
    final uid = Provider.of<User>(context);
    final user = Provider.of<DocumentSnapshot>(context);

    if (user !=null && user.exists) {
      _email = user.data['email'];
      _address = user.data['address'];
      _phone = user.data['phone'];
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
        ),
        child:uid.isAnon?  new Container(
          child:Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2-110),
            child: Column(
              children: <Widget>[
                Text(
                  "Please, Login First",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal),

                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await _auth.signOut();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Do you want to? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ): loading
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
                : ListView(
                    children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height *
                                  (1 / 30)),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.46,
                            child: ListView.builder(
                                itemCount: widget.cartItem.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.0, right: 16),
                                      child: InkWell(
                                          onTap: ()  {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => DetailsPage(
                                                    heroTag:
                                                    "assets/images/salmon.png",
                                                    order: true,
                                                    refresh: refresh,
                                                    isAdmin: _email == "fresh_fish@freshfish.com",
                                                    Item: widget.cartItem[index])));
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
                                                                  edit: true,
                                                                  index: index,
                                                                  order: true,
                                                                  refresh: refresh,
                                                                  isAdmin: _email == "fresh_fish@freshfish.com",
                                                                  Item: widget.cartItem[index])));
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
                                                                  " كيلو",
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
                                                                  " جم",
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
                                    "اجمالي المشتريات",
                                    style: TextStyle(
                                        color: Color(0xFF9BA7C6),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    sum().toString() + " " + "جم",
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
                                    "التوصيل",
                                    style: TextStyle(
                                        color: Color(0xFF9BA7C6),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "5 جم",
                                    style: TextStyle(
                                        color: Color(0xFF6C6D6D),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Divider(
                                height: 2.0,
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
                                    "الاجمالي",
                                    style: TextStyle(
                                        color: Color(0xFF9BA7C6),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (sum() + 5).toString() + " " + "جم",
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
                                onTap:(_address==null||_phone==null)?(){
                                  Fluttertoast.showToast(
                                      msg: "من فضلك اكمل بياناتك",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                                } :() async {

                                  setState(() => loading = true);
                                  bool res =
                                      await DatabaseService(uid: uid.uid)
                                          .addOrder(widget.cartItem);
                                  if (!res) {
                                    setState(() {
                                      loading = false;
                                      Fluttertoast.showToast(
                                          msg: "فشل ارسال الطلب",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "تم ارسال الطلب",
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
                                    color: Color(0xFF7A9BEE),
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ارسال الطلب",
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
