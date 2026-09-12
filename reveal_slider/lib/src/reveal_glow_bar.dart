import 'package:flutter/material.dart';

class RevealGlowBar extends StatelessWidget {
  const RevealGlowBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 15,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.7),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
