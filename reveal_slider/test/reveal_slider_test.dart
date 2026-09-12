import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reveal_slider/reveal_slider.dart';

void main() {
  testWidgets('RevealSlider renders provided layers',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RevealSlider(
            layers: const [
              Text('Layer 1'),
              Text('Layer 2'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Layer 1'), findsOneWidget);
    expect(find.text('Layer 2'), findsOneWidget);
  });
}


