import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/screens/feeding_guidelines_page.dart'; // Replace with your actual import

void main() {
  testWidgets('Feeding Guidelines Page displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FeedingGuidelinesPage()));

    expect(find.text('Feeding Guidelines'), findsOneWidget);
    expect(find.text('Early Lactation Feeding'), findsOneWidget);
  });

  testWidgets('Early Lactation Feeding Guidelines dialog appears',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FeedingGuidelinesPage()));

    await tester.tap(find.text('Early Lactation Feeding'));
    await tester.pumpAndSettle();

    expect(find.text('Early Lactation Feeding Guidelines'), findsOneWidget);
    expect(find.text('Dry Matter Intake'), findsOneWidget);
    expect(find.text('16.5 kg'), findsOneWidget);
  });
}
