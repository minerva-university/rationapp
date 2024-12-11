import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/models/cow_requirements_model.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/widgets/totals_table.dart';
import 'package:rationapp/generated/l10n.dart';

// Helper function to create a test widget with proper setup
Widget createTestWidget({
  required List<FeedIngredient> fodderItems,
  required List<FeedIngredient> concentrateItems,
  required CowRequirements cowRequirements,
  required CowCharacteristics cowCharacteristics,
}) {
  return MaterialApp(
    // Localization setup for internationalized strings
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    locale: const Locale('en'), // Ensure consistent locale
    home: Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          // Builder provides the correct context for the TotalsTable
          child: Builder(
            builder: (BuildContext context) => SizedBox(
              // Container with fixed height ensures proper layout constraints
              height: 400,
              width: 800,
              child: TotalsTable(
                context: context,
                fodderItems: fodderItems,
                concentrateItems: concentrateItems,
                cowRequirements: cowRequirements,
                cowCharacteristics: cowCharacteristics,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CowCharacteristics testCowCharacteristics;
  late CowRequirements testCowRequirements;
  late List<FeedIngredient> testFodderItems;
  late List<FeedIngredient> testConcentrateItems;

  setUp(() {
    // Test data initialization
    testCowCharacteristics = CowCharacteristics(
      liveWeight: 500,
      pregnancyMonths: 0,
      milkVolume: 20,
      milkFat: 3.5,
      milkProtein: 3.2,
      lactationStage: 'early',
    );

    testCowRequirements = CowRequirements(
      dmIntake: 16.5,
      meIntake: 180.0,
      cpIntake: 0.16,
      ndfIntake: 40.0,
      caIntake: 0.8,
      pIntake: 0.4,
      concentrateIntake: 60.0,
    );

    testFodderItems = [
      FeedIngredient(
        id: 'fodder1',
        name: 'Test Fodder',
        weight: 10.0,
        dmIntake: 8.0,
        meIntake: 90.0,
        cpIntake: 1.2,
        ndfIntake: 20.0,
        caIntake: 0.4,
        pIntake: 0.2,
        cost: 100.0,
        isFodder: true,
      ),
    ];

    testConcentrateItems = [
      FeedIngredient(
        id: 'concentrate1',
        name: 'Test Concentrate',
        weight: 5.0,
        dmIntake: 4.0,
        meIntake: 45.0,
        cpIntake: 0.8,
        ndfIntake: 10.0,
        caIntake: 0.2,
        pIntake: 0.1,
        cost: 200.0,
        isFodder: false,
      ),
    ];
  });

  group('TotalsTable Widget Tests', () {
    testWidgets('renders with basic data and shows correct totals',
        (WidgetTester tester) async {
      // Build and trigger initial frame
      await tester.pumpWidget(createTestWidget(
        fodderItems: testFodderItems,
        concentrateItems: testConcentrateItems,
        cowRequirements: testCowRequirements,
        cowCharacteristics: testCowCharacteristics,
      ));

      // Allow widget to complete initialization
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify table structure
      expect(find.byType(DataTable), findsOneWidget);

      // Verify the presence of calculated totals
      // Note: Using textContaining because the values might be part of larger strings
      final dmTotal = find.textContaining('12.00'); // 8.0 + 4.0
      final meTotal = find.textContaining('135.00'); // 90.0 + 45.0

      expect(dmTotal, findsWidgets,
          reason: 'Should find DM intake total of 12.00');
      expect(meTotal, findsWidgets,
          reason: 'Should find ME intake total of 135.00');
    });

    testWidgets('handles empty feed lists correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        fodderItems: [],
        concentrateItems: [],
        cowRequirements: testCowRequirements,
        cowCharacteristics: testCowCharacteristics,
      ));

      await tester.pumpAndSettle();

      // Verify table still renders with empty data
      expect(find.byType(DataTable), findsOneWidget);

      // Should find multiple zeros for empty totals
      final zeroValues = find.textContaining('0.00');
      expect(zeroValues, findsWidgets,
          reason: 'Should display 0.00 for empty totals');
    });

    testWidgets('calculates concentrate percentage correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(
        fodderItems: testFodderItems,
        concentrateItems: testConcentrateItems,
        cowRequirements: testCowRequirements,
        cowCharacteristics: testCowCharacteristics,
      ));

      await tester.pumpAndSettle();

      // Verify concentrate percentage calculation
      // (4.0 / 12.0) * 100 = 33.33%
      final percentageValue = find.textContaining('33.33');
      expect(percentageValue, findsWidgets,
          reason: 'Should show correct concentrate percentage of 33.33%');
    });
  });
}
