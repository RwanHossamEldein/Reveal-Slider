import 'package:animated_scanner/my_custom_clipper.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  double position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (details) {
          setState(() {
            position = details.localPosition.dx;
          });
        },
        child: Stack(
          children: [
            Image.asset('assets/images/batman.jpg'),
            ClipRect(
              clipper: MyCustomClipper(width: position),
              child: Image.asset('assets/images/spiderman.jpg'),
            ),
            Positioned(
              left: position,
              top: 300,
              child: Container(
                width: 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
