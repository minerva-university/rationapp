import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/widgets/cow_requirements_table.dart';
import 'package:rationapp/models/cow_requirements_model.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable wrapped widget with MaterialApp and localizations
Widget createTestableTable(CowRequirements requirements) {
  return MaterialApp(
    // Add localization support since the widget uses translated strings
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Scaffold(
      body: SingleChildScrollView(
        // Wrap in SingleChildScrollView to prevent overflow errors
        child: CowRequirementsTable(
          cowRequirements: requirements,
        ),
      ),
    ),
  );
}

void main() {
  // Sample test data representing typical cow requirements
  final sampleRequirements = CowRequirements(
      dmIntake: 16.5, // Dry Matter Intake (kg/day)
      meIntake: 179.96, // Metabolizable Energy (MJ/day)
      cpIntake: 0.16, // Crude Protein (as decimal)
      ndfIntake: 40.0, // Neutral Detergent Fiber (%)
      caIntake: 0.80, // Calcium (%)
      pIntake: 0.40, // Phosphorus (%)
      concentrateIntake: 60.0 // Concentrate (%)
      );

  group('CowRequirementsTable Widget Tests', () {
    testWidgets('Table renders with correct number of columns',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(sampleRequirements));
      await tester.pumpAndSettle();

      // First, verify the DataTable exists
      final dataTable = find.byType(DataTable);
      expect(dataTable, findsOneWidget);

      // Get the DataTable widget
      final DataTable table = tester.widget(dataTable);

      // Verify the number of columns in the table
      expect(table.columns.length, 7);
    });

    testWidgets('Table displays correct values with proper formatting',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(sampleRequirements));
      await tester.pumpAndSettle();

      // Get the DataTable widget
      final DataTable table = tester.widget(find.byType(DataTable));

      // Get the first (and only) row of data
      final DataRow row = table.rows.first;

      // Expected values in order
      final expectedValues = [
        '16.50', // dmIntake
        '179.96', // meIntake
        '16.00', // cpIntake (converted to percentage)
        '40.00', // ndfIntake
        '0.80', // caIntake
        '0.40', // pIntake
        '60.00', // concentrateIntake
      ];

      // Verify each cell contains the correct formatted value
      for (var i = 0; i < row.cells.length; i++) {
        final cell = row.cells[i];
        final cellText = (cell.child as Text).data;
        expect(cellText, expectedValues[i],
            reason: 'Cell $i should contain ${expectedValues[i]}');
      }
    });

    testWidgets('Table handles zero values correctly',
        (WidgetTester tester) async {
      final zeroRequirements = CowRequirements(
          dmIntake: 0.0,
          meIntake: 0.0,
          cpIntake: 0.0,
          ndfIntake: 0.0,
          caIntake: 0.0,
          pIntake: 0.0,
          concentrateIntake: 0.0);

      await tester.pumpWidget(createTestableTable(zeroRequirements));
      await tester.pumpAndSettle();

      // Verify zero values are formatted correctly with two decimal places
      expect(find.text('0.00'), findsNWidgets(7));
    });

    testWidgets('Table displays correct column headers with translations',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(sampleRequirements));
      await tester.pumpAndSettle();

      // Get the DataTable and verify its structure
      final dataTable = find.byType(DataTable);
      expect(dataTable, findsOneWidget);

      final DataTable table = tester.widget(dataTable);
      expect(table.columns.length, 7);

      // Verify each column has a Text widget for its label
      for (var column in table.columns) {
        expect(column.label, isA<Text>());
      }
    });

    testWidgets('Table handles extra large values appropriately',
        (WidgetTester tester) async {
      final largeRequirements = CowRequirements(
          dmIntake: 999999.99,
          meIntake: 999999.99,
          cpIntake: 0.99,
          ndfIntake: 999999.99,
          caIntake: 999999.99,
          pIntake: 999999.99,
          concentrateIntake: 999999.99);

      await tester.pumpWidget(createTestableTable(largeRequirements));
      await tester.pumpAndSettle();

      // Verify large values are displayed without scientific notation
      expect(find.text('999999.99'), findsNWidgets(6));
      expect(find.text('99.00'),
          findsOneWidget); // cpIntake converted to percentage
    });
  });
}
