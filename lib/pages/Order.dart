import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
class OrderScreen extends StatefulWidget {
  @override

  final List<orderitem> cartItem;
  OrderScreen({this.cartItem});
  _OrderScreenState createState() => _OrderScreenState();


}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return widget.cartItem.length==0 ? null: Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: widget.cartItem.length,
          itemBuilder: (context, index){
          return Container(
            child: Text(
              widget.cartItem[index].quantity,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
          },
      ),
    );
  }
}
