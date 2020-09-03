import 'package:flutter/material.dart';

class aboutUsScreen extends StatefulWidget {
  @override
  _aboutUsScreenState createState() => _aboutUsScreenState();
}

class _aboutUsScreenState extends State<aboutUsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('عن التطبيق',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 32),
                  AboutUsUIItem(
                    title: 'العنوان',
                    details: 'مدينة نصر - الحي السادس',
                  ),
                  AboutUsUIItem(
                    title: 'تليفون',
                    details: '01155393933',
                  ),
                  AboutUsUIItem(
                    title: 'فيسبوك',
                    details: 'LINK',
                  ),
                  AboutUsUIItem(
                    title: 'المطورين',
                    details: 'Ahmed Mostafa & Menna Shrif',
                  ),
                  AboutUsUIItem(
                    title: 'الاصدار',
                    details: '1.0.0',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

class AboutUsUIItem extends StatelessWidget {
  final String title, details;

  const AboutUsUIItem({Key key, this.title, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                color: Color(0xFF527DAA),
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Text(
          details,
          style: TextStyle(color: Colors.grey),
        ),
        Divider()
      ],
    );
  }
}