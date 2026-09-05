import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Rect> {
  final double width;

  MyCustomClipper({required this.width});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      0,
      0,
      width,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant MyCustomClipper oldClipper) {
    return oldClipper.width != width;
  }
}