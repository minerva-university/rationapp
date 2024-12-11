import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/widgets/ingredient_table.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/generated/l10n.dart';

void main() {
  late List<FeedIngredient> testItems;

  setUp(() {
    testItems = [
      FeedIngredient(
        id: 'test1',
        name: 'Test Feed 1',
        weight: 10.0,
        dmIntake: 8.5,
        meIntake: 12.3,
        cpIntake: 0.15,
        ndfIntake: 0.35,
        caIntake: 0.02,
        pIntake: 0.01,
        cost: 25.0,
        isFodder: true,
      ),
      FeedIngredient(
        id: 'test2',
        name: 'Test Feed 2',
        weight: 15.0,
        dmIntake: 12.75,
        meIntake: 18.45,
        cpIntake: 0.225,
        ndfIntake: 0.525,
        caIntake: 0.03,
        pIntake: 0.015,
        cost: 37.5,
        isFodder: true,
      ),
    ];
  });

  Widget createTestWidget({
    required List<FeedIngredient> items,
    required Function(int) onEdit,
    required Function(int) onDelete,
  }) {
    return MaterialApp(
      // Set up localization support
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: IngredientTable(
            context: context,
            items: items,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ),
      ),
    );
  }

  testWidgets('IngredientTable displays data and action buttons',
      (WidgetTester tester) async {
    int editedIndex = -1;
    int deletedIndex = -1;

    await tester.pumpWidget(createTestWidget(
      items: testItems,
      onEdit: (index) => editedIndex = index,
      onDelete: (index) => deletedIndex = index,
    ));

    // Initial pump completes, but we need to wait for localizations to load
    await tester.pumpAndSettle();

    // Check that we have the correct number of edit and delete buttons
    expect(find.byIcon(Icons.edit), findsNWidgets(2));
    expect(find.byIcon(Icons.delete), findsNWidgets(2));

    // Test edit functionality
    await tester.tap(find.byIcon(Icons.edit).first);
    expect(editedIndex, 0);

    await tester.tap(find.byIcon(Icons.edit).last);
    expect(editedIndex, 1);

    // Test delete functionality
    await tester.tap(find.byIcon(Icons.delete).first);
    expect(deletedIndex, 0);

    await tester.tap(find.byIcon(Icons.delete).last);
    expect(deletedIndex, 1);

    // Verify numeric data is displayed with correct formatting
    expect(find.text('10.00'), findsOneWidget); // weight
    expect(find.text('8.50000'), findsOneWidget); // dmIntake
    expect(find.text('25.00'), findsOneWidget); // cost
  });

  testWidgets('IngredientTable handles empty data list',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget(
      items: [],
      onEdit: (_) {},
      onDelete: (_) {},
    ));

    // Wait for localizations to load
    await tester.pumpAndSettle();

    // Verify no action buttons are shown when list is empty
    expect(find.byIcon(Icons.edit), findsNothing);
    expect(find.byIcon(Icons.delete), findsNothing);
  });
}
