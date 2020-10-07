import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/services/database.dart';
import 'package:fresh_fish/utilities/loading.dart';
import 'package:fresh_fish/utilities/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('قائمة الطلبات',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
              ),
              color: Colors.white),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('Order')
                .orderBy('timeStamp')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Loading());
              final orders = snapshot.data.documents.reversed;
              List<OrderListItem> ordersWidgets = [];
              for (var order in orders) {
                List<orderitem> orderItems = [];
                int c = 0;
                while (order.data['content'].length > c) {
                  orderItems.add(orderitem(
                    null,
                    null,
                    order.data['content'][c]['name'],
                    order.data['content'][c]['price'],
                    null,
                    order.data['content'][c]['quantity'],
                    order.data['content'][c]['Isoffered'],
                    order.data['content'][c]['optionName'],
                    order.data['content'][c]['optionPrice'],
                    null,
                    null,
                  ));
                  c++;
                }
                ordersWidgets.add(OrderListItem(
                  timeStamp: order.data['timeStamp'],
                  uId: order.data['uid'],
                  delivered: order.data['delivered'],
                  deliveryDate: order.data['deliveryDate'],
                  orderId: order.documentID,
                  orders: orderItems,
                  name: order.data['name'],
                  address: order.data['address'],
                  phone: order.data['phone'],
                ));
              }
              return MultiProvider(
                providers: [
                  StreamProvider<QuerySnapshot>.value(
                      value: DatabaseService().users)
                ],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(children: ordersWidgets),
                ),
              );
            },
          ),
        ));
  }
}
