import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/pages/Order.dart';


class fixedicon extends StatefulWidget {
  @override

  _fixediconState createState() => _fixediconState();

}

 class _fixediconState extends State<fixedicon> with SingleTickerProviderStateMixin {

   static List<orderitem> cartItem=[];
   void increasecart(orderitem item){

       cartItem.add(item);


   }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderScreen(cartItem:cartItem)));
      },
      child: new Stack(
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.shopping_cart,
            color: Colors.black,),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderScreen(cartItem:cartItem)));
            },
          ),
          cartItem.length ==0 ? new Container() :
          new Positioned(

              child: new Stack(
                children: <Widget>[
                  new Icon(
                      Icons.brightness_1,
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
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )),


                ],
              )),

        ],
      ),
    );
  }
}
