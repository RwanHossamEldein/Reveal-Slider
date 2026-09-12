import 'package:animated_scanner/scan_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScanScreen(
        direction: Axis.vertical,
        layers: [
          Image.asset('assets/images/batman.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/spiderman.jpg', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              border: Border.all(),
            ),
          ),
        ],
      ),
    );
  }
}
