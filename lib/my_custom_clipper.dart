import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Rect> {
  final double position;
  final Axis direction;
  final bool revealFromStart; // هل الكشف يبدأ من البداية أم من النهاية

  const MyCustomClipper({
    required this.position,
    this.direction = Axis.horizontal,
    this.revealFromStart = true,
  });

  @override
  Rect getClip(Size size) {
    if (direction == Axis.horizontal) {
      return revealFromStart
          ? Rect.fromLTWH(0, 0, position, size.height)
          : Rect.fromLTWH(position, 0, size.width - position, size.height);
    } else {
      return revealFromStart
          ? Rect.fromLTWH(0, 0, size.width, position)
          : Rect.fromLTWH(0, position, size.width, size.height - position);
    }
  }

  @override
  bool shouldReclip(covariant MyCustomClipper oldClipper) {
    return oldClipper.position != position ||
        oldClipper.revealFromStart != revealFromStart;
  }
}
