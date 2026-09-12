import 'package:flutter/material.dart';
import 'package:reveal_slider/reveal_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: RevealSlider(
          direction: Axis.vertical,
          layers: [
            Image.asset('assets/batman.jpg', fit: BoxFit.cover),
            Image.asset('assets/spiderman.jpg', fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

