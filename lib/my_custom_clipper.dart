import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Rect> {
  final double position;
  final Axis direction;

  const MyCustomClipper({
    required this.position,
    this.direction = Axis.horizontal,
  });

  @override
  Rect getClip(Size size) {
    if (direction == Axis.horizontal) {
      return Rect.fromLTWH(0, 0, position, size.height);
    } else {
      return Rect.fromLTWH(0, 0, size.width, position);
    }
  }

  @override
  bool shouldReclip(covariant MyCustomClipper oldClipper) {
    return oldClipper.position != position || oldClipper.direction != direction;
  }
}
