import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/widgets/add_ingredient_dialog.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/widgets/custom_text_field.dart';
import 'package:rationapp/widgets/custom_dropdown_field.dart';

Widget createTestableDialog({
  required bool isFodder,
  required List<FeedIngredient> availableOptions,
  required Function(String, double) onAdd,
  double? initialWeight,
}) {
  return MaterialApp(
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: ScaffoldMessenger(
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            // Add Scaffold for SnackBar display
            body: AddIngredientDialog(
              isFodder: isFodder,
              availableOptions: availableOptions,
              onAdd: onAdd,
              initialWeight: initialWeight,
            ),
          );
        },
      ),
    ),
  );
}

void main() {
  // Sample test data
  final sampleIngredients = [
    FeedIngredient(
      id: 'hay',
      name: 'Hay',
      weight: 10.0,
      dmIntake: 85.0,
      meIntake: 9.5,
      cpIntake: 12.0,
      ndfIntake: 55.0,
      caIntake: 0.45,
      pIntake: 0.25,
      cost: 5.0,
      isFodder: true,
    ),
    FeedIngredient(
      id: 'silage',
      name: 'Silage',
      weight: 15.0,
      dmIntake: 35.0,
      meIntake: 10.2,
      cpIntake: 14.0,
      ndfIntake: 45.0,
      caIntake: 0.35,
      pIntake: 0.30,
      cost: 3.0,
      isFodder: true,
    ),
  ];

  group('AddIngredientDialog Widget Tests', () {
    testWidgets('Dialog renders correctly with fodder options',
        (WidgetTester tester) async {
      bool onAddCalled = false;

      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: sampleIngredients,
        onAdd: (_, __) => onAddCalled = true,
      ));

      await tester.pumpAndSettle();

      // Verify the dialog title is present
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CustomDropdownField), findsOneWidget);
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(onAddCalled, false);
    });

    testWidgets('Dialog initializes with provided weight',
        (WidgetTester tester) async {
      const initialWeight = 25.0;

      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: sampleIngredients,
        onAdd: (_, __) {},
        initialWeight: initialWeight,
      ));

      await tester.pumpAndSettle();

      // Verify the weight field is pre-filled
      expect(find.text(initialWeight.toString()), findsOneWidget);
    });

    testWidgets('Cancel button closes dialog without calling onAdd',
        (WidgetTester tester) async {
      bool onAddCalled = false;

      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: sampleIngredients,
        onAdd: (_, __) => onAddCalled = true,
      ));

      await tester.pumpAndSettle();

      // Tap the cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(onAddCalled, false);
    });

    testWidgets('Add button calls onAdd with correct values when form is valid',
        (WidgetTester tester) async {
      String? addedId;
      double? addedWeight;

      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: [sampleIngredients.first],
        onAdd: (id, weight) {
          addedId = id;
          addedWeight = weight;
        },
        initialWeight: 0.0,
      ));

      await tester.pumpAndSettle();

      // Enter weight
      await tester.enterText(find.byType(TextField), '30.5');
      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(addedId, 'hay');
      expect(addedWeight, 30.5);
    });

    testWidgets(
        'Shows error message when trying to add without selecting ingredient',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: sampleIngredients,
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();

      // Only enter weight without selecting ingredient
      await tester.enterText(find.byType(TextField), '30.5');

      // Tap add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify error snackbar is shown
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
        'Shows error message when trying to add without entering weight',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: [sampleIngredients.first],
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify error snackbar is shown
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Dialog uses correct title based on isFodder value',
        (WidgetTester tester) async {
      // Test fodder dialog
      await tester.pumpWidget(createTestableDialog(
        isFodder: true,
        availableOptions: sampleIngredients,
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();
      expect(find.text('Add Fodder'), findsOneWidget);

      // Test concentrate dialog
      await tester.pumpWidget(createTestableDialog(
        isFodder: false,
        availableOptions: sampleIngredients,
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();
      expect(find.text('Add Concentrate'), findsOneWidget);
    });
  });
}
