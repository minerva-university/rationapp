import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/utils/nutrition_calculator.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  late NutritionCalculator calculator;

  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(
        builder: (BuildContext context) {
          calculator = NutritionCalculator(context);
          return child;
        },
      ),
    );
  }

  group('DM Requirement Calculations', () {
    testWidgets('calculateDMRequirement returns correct value for valid weight',
        (WidgetTester tester) async {
      // Build our widget tree and wait for it to settle
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating DM requirement
      final result = calculator.calculateDMRequirement(400);

      // Then the result should match expected value
      expect(result, equals(12));
    });

    testWidgets('calculateDMRequirement returns 0 for invalid weight',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating DM requirement with invalid weight
      final result = calculator.calculateDMRequirement(-100);

      // Then the result should be 0
      expect(result, equals(0.0));
    });
  });

  group('ME Intake Calculations', () {
    testWidgets('calculateMEIntake returns correct value for valid inputs',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating ME intake with valid inputs
      final result = calculator.calculateMEIntake(
        400, // weight
        5, // pregnancy months
        20.0, // milk volume
        3.5, // milk fat
        3.2, // milk protein
      );

      // Then verify the result is calculated
      expect(result, isNotNull);
    });

    testWidgets('calculateMEIntake handles missing milk fat data',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating ME intake with invalid fat percentage
      final result = calculator.calculateMEIntake(
        400,
        5,
        20.0,
        -1.0, // invalid fat percentage
        3.2,
      );

      // Then verify the result handles invalid input
      expect(result, isNotNull);
      expect(result, equals(45.0));
    });
  });

  group('CP Intake Calculations', () {
    testWidgets('calculateCPIntake returns correct value for early lactation',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating CP intake
      final result = calculator.calculateCPIntake("early");

      // Then verify the result is calculated
      expect(result, isNotNull);
      expect(result, equals(0.16));
    });

    testWidgets('calculateCPIntake returns 0 for empty lactation stage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating CP intake with empty stage
      final result = calculator.calculateCPIntake("");

      // Then the result should be 0
      expect(result, equals(0.0));
    });
  });

  group('Mineral Intake Calculations', () {
    testWidgets('calculateCaIntake returns correct value for lactation stage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating Ca intake
      final result = calculator.calculateCaIntake("mid");

      // Then verify the result is calculated
      expect(result, isNotNull);
      expect(result, equals(0.7));
    });

    testWidgets('calculatePIntake returns correct value for lactation stage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating P intake
      final result = calculator.calculatePIntake("early");

      // Then verify the result is calculated
      expect(result, isNotNull);
      expect(result, equals(0.4));
    });

    testWidgets('mineral calculations return 0 for empty lactation stage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating mineral intakes with empty stage
      final caResult = calculator.calculateCaIntake("");
      final pResult = calculator.calculatePIntake("");

      // Then both results should be 0
      expect(caResult, equals(0.0));
      expect(pResult, equals(0.0));
    });
  });

  group('Edge Cases and Error Handling', () {
    testWidgets('handles missing lactation stage data',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget(Container()));
      await tester.pumpAndSettle();

      // When calculating requirements for non-existent stage
      final cpResult = calculator.calculateCPIntake("non_existent_stage");
      final caResult = calculator.calculateCaIntake("non_existent_stage");
      final pResult = calculator.calculatePIntake("non_existent_stage");

      // Then all results should be 0
      expect(cpResult, equals(0.0));
      expect(caResult, equals(0.0));
      expect(pResult, equals(0.0));
    });
  });
}
