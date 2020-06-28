import 'package:flutter/material.dart';
class aboutUsScreen extends StatefulWidget {
  @override
  _aboutUsScreenState createState() => _aboutUsScreenState();
}

class _aboutUsScreenState extends State<aboutUsScreen> with SingleTickerProviderStateMixin {
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
    return Container(
      child: Text('aboutUsScreen',textScaleFactor: 2.0),
    );
  }
}
