import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';
import 'package:fresh_fish/utilities/bill_item.dart';
import 'package:provider/provider.dart';

class OrderListItem extends StatefulWidget {
  final String uId;
  final String orderId;
  final bool delivered;
  final String timeStamp;
  final String deliveryDate;
  final List<orderitem> orders;
  final String name;
  final String address;
  final String phone;
  OrderListItem(
      {this.orders,
      this.uId,
      this.timeStamp,
      this.orderId,
      this.delivered,
      this.deliveryDate,
      this.name,
      this.address,
      this.phone});

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  double price = 0;
  String _name = '';
  String _address = '';
  String _phone = '';
  @override
  void initState() {
    super.initState();
    deliveredCBValue = widget.delivered;
    for (int i = 0; i < widget.orders.length; i++)
      price += widget.orders[i].price +
          (widget.orders[i].optionPrice * widget.orders[i].quantity);
  }

  void getdata(final user, final uid) {
    if (user != null) {
      for (int i = 0; i < user.documents.length; i++) {
        if (user.documents[i].documentID == uid) {
          _name = user.documents[i].data['name'];
          _address = user.documents[i].data['address'];
          _phone = user.documents[i].data['phone'];
        }
      }
    }
  }

  bool deliveredCBValue;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuerySnapshot>(context);
    getdata(user, widget.uId);
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(45.0),
      ),
      child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("الاجمالي: " + price.toString() + ' جم',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text(_name + " : اسم الاكونت "),
                  Text(_address + " : عنوان الاكونت"),
                  Text("رقم هاتف الاكونت: " + _phone),
                  Text(widget.name + " : الأسم"),
                  Text(widget.address + " : العنوان"),
                  Text("رقم الهاتف : " + widget.phone),
                  Text(widget.timeStamp.substring(0, 10) +
                      " | " +
                      widget.timeStamp.substring(11, 16) +
                      " : تاريخ الطلب"),
                  Text(widget.timeStamp.substring(0, 10) +
                      " | " +
                      widget.deliveryDate.substring(11, 16) +
                      " : تاريخ التوصيل"),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xFF7A9BEE),
                        onPressed: () {
                          showEditScreen(context);
                        },
                        child: Text(
                          'عرض التفاصيل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'رسالة تأكيد',
                                style: TextStyle(color: Color(0xFF7A9BEE)),
                              ),
                              content: Text(
                                'تأكيد الغاء الطلب ؟',
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  color: Colors.red,
                                  child: Text('تأكيد'),
                                  onPressed: () async {
                                    await Firestore.instance
                                        .collection('Order')
                                        .document(widget.orderId)
                                        .delete();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(width: 5),
                                FlatButton(
                                  color: Colors.white,
                                  child: Text('خروج'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'الغاء الطلب',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('تم التوصيل'),
                      Checkbox(
                          value: deliveredCBValue,
                          onChanged: (val) async {
                            print(widget.orderId);
                            await Firestore.instance
                                .collection('Order')
                                .document(widget.orderId)
                                .updateData({'delivered': !deliveredCBValue});
                            setState(() {
                              deliveredCBValue = !deliveredCBValue;
                              print(deliveredCBValue);
                            });
                          }),
                    ],
                  ),
                  Divider()
                ]),
          )),
    );
  }

  void showEditScreen(var context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: widget.orders.length,
                      itemBuilder: (context, i) => BillItem(
                            item: widget.orders[i],
                          )),
                ),
              ),
            )));
  }
}
