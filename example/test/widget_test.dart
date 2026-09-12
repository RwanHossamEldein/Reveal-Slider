import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('RevealSlider example smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RevealSliderExampleApp());
    expect(find.text('Reveal Slider Demo'), findsOneWidget);
  });
}
