import 'package:flutter/material.dart';

class InfoItem extends StatefulWidget {
  final String text;
  final String txt;
  final Function function;

  InfoItem({
    this.text,
    this.txt,
    this.function,
  });

  @override
  _InfoItemState createState() => _InfoItemState();
}

class _InfoItemState extends State<InfoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
            visible: widget.text != 'البريد الالكتروني',
            child: GestureDetector(
                onTap: () {
                  widget.function();
                },
                child: Icon(
                  Icons.edit,
                  color: Color(0xFF527DAA),
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.text,
                style: TextStyle(
                    color: Color(0xFF527DAA),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.txt ?? 'فارغ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
