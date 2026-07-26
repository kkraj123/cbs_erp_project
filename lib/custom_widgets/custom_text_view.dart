import 'package:flutter/material.dart';

class CustomTextView {
  static Widget normalTextView(String txt, Color color, bool isCenter) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontFamily: 'Barlow',
        fontWeight: FontWeight.normal,
      ),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      textScaler: TextScaler.linear(1),
    );
  }

  static Widget mediumTextView(String txt, Color color, bool isCenter) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontFamily: 'Barlow',
        fontWeight: FontWeight.w600,
      ),
      textScaler: TextScaler.linear(1.5),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    );
  }
  static Widget mediumTextWithNormalView(String txt, Color color, bool isCenter) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontFamily: 'Barlow',
        fontWeight: FontWeight.normal,
      ),
      textScaler: TextScaler.linear(1.3),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    );
  }
  static Widget largeTextView(String txt, Color color, bool isCenter) {
    return Text(
      txt,
      style: TextStyle(
        color: color,
        fontFamily: "Barlow",
        fontWeight: FontWeight.w800,
      ),
      textScaler: TextScaler.linear(2),
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
    );
  }
}
