import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  fontFamily: 'OpenSans',

);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
final SmallButton =Container(
  height: 25.0,
  width: 60.0,
  decoration: BoxDecoration(
      border: Border.all(
        color: Colors.blue,
      ),
      borderRadius: BorderRadius.circular(20.0)),
  child: Center(
    child: Text(
      "تعديل",
      style: TextStyle(color: Colors.blue, fontSize: 16.0),
    ),
  ),
);