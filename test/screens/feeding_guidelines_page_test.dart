import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/screens/feeding_guidelines_page.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // Helper function to create the widget under test with proper localization
  Widget createTestWidget() {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: FeedingGuidelinesPage(),
    );
  }

  group('FeedingGuidelinesPage Widget Tests', () {
    testWidgets('renders AppBar with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify AppBar exists and has correct title
      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);
      expect(find.text('Feeding Guidelines'), findsOneWidget);
    });

    testWidgets('displays all lactation stage expansion tiles',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify all expansion tiles are present
      expect(find.text('Early Lactation Feeding'), findsOneWidget);
      expect(find.text('Mid Lactation Feeding'), findsOneWidget);
      expect(find.text('Late Lactation Feeding'), findsOneWidget);
      expect(find.text('Dry Cow Feeding'), findsOneWidget);
    });

    testWidgets('expands early lactation tile and shows correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the early lactation expansion tile
      final earlyLactationTile = find.text('Early Lactation Feeding');
      await tester.tap(earlyLactationTile);
      await tester.pumpAndSettle();

      // Verify the expected values are displayed
      expect(find.text('16.5 kg'), findsOneWidget);
      expect(find.text('179.96 MJ/day'), findsOneWidget);
      expect(find.text('16%'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('0.80%'), findsOneWidget);
      expect(find.text('0.40%'), findsOneWidget);
    });

    testWidgets('expands mid lactation tile and shows correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the mid lactation expansion tile
      final midLactationTile = find.text('Mid Lactation Feeding');
      await tester.tap(midLactationTile);
      await tester.pumpAndSettle();

      // Verify the expected values are displayed
      expect(find.text('16.5 kg'), findsOneWidget);
      expect(find.text('149.72 MJ/day'), findsOneWidget);
      expect(find.text('14%'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('0.70%'), findsOneWidget);
      expect(find.text('0.35%'), findsOneWidget);
    });

    testWidgets('expands late lactation tile and shows correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the late lactation expansion tile
      final lateLactationTile = find.text('Late Lactation Feeding');
      await tester.tap(lateLactationTile);
      await tester.pumpAndSettle();

      // Verify the expected values are displayed
      expect(find.text('16.5 kg'), findsOneWidget);
      expect(find.text('109.32 MJ/day'), findsOneWidget);
      expect(find.text('12%'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('0.40%'), findsAtLeastNWidgets(1));
      expect(find.text('0.20%'), findsAtLeastNWidgets(1));
    });

    testWidgets('expands dry cow tile and shows correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the dry cow expansion tile
      final dryCowTile = find.text('Dry Cow Feeding');
      await tester.tap(dryCowTile);
      await tester.pumpAndSettle();

      // Verify the expected values are displayed
      expect(find.text('16.5 kg'), findsOneWidget);
      expect(find.text('90 MJ/day'), findsOneWidget);
      expect(find.text('12%'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);
      expect(find.text('0.40%'), findsAtLeastNWidgets(1));
      expect(find.text('0.20%'), findsAtLeastNWidgets(1));
    });

    testWidgets('table headers are correctly displayed for each section',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Open any expansion tile to check the table headers
      await tester.tap(find.text('Early Lactation Feeding'));
      await tester.pumpAndSettle();

      // Verify all standard table headers are present
      expect(find.text('Period'), findsOneWidget);
      expect(find.text('Dry Matter Intake'), findsOneWidget);
      expect(find.text('ME Intake'), findsOneWidget);
      expect(find.text('Crude Protein'), findsOneWidget);
      expect(find.text('NDF'), findsOneWidget);
      expect(find.text('Ca Intake'), findsOneWidget);
      expect(find.text('P Intake'), findsOneWidget);
    });

    testWidgets('verifies table cell styling and borders',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Open an expansion tile
      await tester.tap(find.text('Early Lactation Feeding'));
      await tester.pumpAndSettle();

      // Verify table structure
      final tableFinder = find.byType(Table);
      expect(tableFinder, findsOneWidget);

      // Get the Table widget
      final Table table = tester.widget(tableFinder);

      // Verify table border
      expect(table.border, isA<TableBorder>());
      expect(table.border!.top.color, Colors.black);
      expect(table.border!.bottom.color, Colors.black);
      expect(table.border!.left.color, Colors.black);
      expect(table.border!.right.color, Colors.black);
    });

    testWidgets('multiple expansion tiles can be opened simultaneously',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Open multiple expansion tiles
      await tester.tap(find.text('Early Lactation Feeding'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mid Lactation Feeding'));
      await tester.pumpAndSettle();

      // Verify both sections are expanded by checking for unique values
      expect(find.text('179.96 MJ/day'), findsOneWidget); // Early lactation
      expect(find.text('149.72 MJ/day'), findsOneWidget); // Mid lactation
    });
  });
}
