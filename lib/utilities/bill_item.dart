import 'package:flutter/material.dart';
import 'package:fresh_fish/models/orderitem.dart';

class BillItem extends StatelessWidget {
  final orderitem item;
  const BillItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(item.name,
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  Text(
                    ' السعر : ' + item.price.toString() + ' جم',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text('الوزن : ' + item.quantity.toString() + " كيلو",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  SizedBox(height: 3),
                  Visibility(
                    child: Row(
                      children: <Widget>[
                        Text(
                            'طريقة التحضير : ' +
                                item.optionName.toString() +
                                " | ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        Text('الثمن : ' + item.optionPrice.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 15))
                      ],
                    ),
                  )
                ]),
          ),
          Image.asset(
            "assets/images/salmon.png",
            width: 100,
            height: 100,
          ),
        ]),
        Divider()
      ],
    );
  }
}
