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
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
