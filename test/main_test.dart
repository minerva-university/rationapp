import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/main.dart'; // Replace with your actual import

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RationCalculatorApp());

    expect(find.text('Ration Calculator'), findsOneWidget);
    expect(find.text('Ration Formulation'), findsOneWidget);
    expect(find.text('Budget Tool'), findsOneWidget);
    expect(find.text('Feeding Guidelines'), findsOneWidget);
    expect(find.text('Cow Requirements'), findsOneWidget);
  });
}
