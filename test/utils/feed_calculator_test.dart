import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/utils/feed_calculator.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@GenerateMocks([FeedState])
import 'feed_calculator_test.mocks.dart';

void main() {
  late MockFeedState mockFeedState;
  late FeedCalculator feedCalculator;
  late BuildContext testContext;

  // Sample feed ingredients for testing
  final sampleFodder = FeedIngredient(
    id: 'napier',
    name: 'Napier Grass',
    weight: 100,
    dmIntake: 30,
    meIntake: 2.5,
    cpIntake: 15,
    ndfIntake: 45,
    caIntake: 0.8,
    pIntake: 0.4,
    cost: 10,
    isFodder: true,
    isAvailable: true,
  );

  final sampleConcentrate = FeedIngredient(
    id: 'maize_bran',
    name: 'Maize Bran',
    weight: 100,
    dmIntake: 90,
    meIntake: 3.2,
    cpIntake: 20,
    ndfIntake: 25,
    caIntake: 1.0,
    pIntake: 0.6,
    cost: 20,
    isFodder: false,
    isAvailable: true,
  );

  setUp(() {
    mockFeedState = MockFeedState();
    feedCalculator = FeedCalculator();

    // Mock the basic FeedState methods
    when(mockFeedState.fodderItems).thenReturn([sampleFodder]);
    when(mockFeedState.concentrateItems).thenReturn([sampleConcentrate]);
    when(mockFeedState.availableFodderItems).thenReturn([sampleFodder]);
    when(mockFeedState.availableConcentrateItems)
        .thenReturn([sampleConcentrate]);
  });

  Widget createTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
          builder: (BuildContext context) {
            testContext = context;
            return Scaffold(body: child);
          },
        ),
      ),
    );
  }

  group('FeedCalculator Tests', () {
    testWidgets('calculateIngredientValues correctly calculates fodder values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Test fodder calculations with 50kg weight
      final result = feedCalculator.calculateIngredientValues(
        'napier',
        50.0,
        true,
        testContext,
      );

      // Verify calculations
      expect(result.weight, equals(50.0));
      expect(result.dmIntake, equals(15.0)); // 30% * 50kg
      expect(result.meIntake, equals(37.5)); // 2.5 * 15kg DM
      expect(result.cpIntake, equals(2.25)); // 15% * 15kg DM
      expect(result.ndfIntake, equals(6.75)); // 45% * 15kg DM
      expect(result.caIntake, equals(0.12)); // 0.8% * 15kg DM
      expect(result.pIntake, equals(0.06)); // 0.4% * 15kg DM
      expect(result.cost, equals(500.0)); // 10 * 50kg

      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });

    testWidgets(
        'calculateIngredientValues correctly calculates concentrate values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Test concentrate calculations with 30kg weight
      final result = feedCalculator.calculateIngredientValues(
        'maize_bran',
        30.0,
        false,
        testContext,
      );

      // Verify calculations
      expect(result.weight, equals(30.0));
      expect(result.dmIntake, equals(27.0)); // 90% * 30kg
      expect(result.meIntake, equals(86.4)); // 3.2 * 27kg DM
      expect(result.cpIntake, equals(5.4)); // 20% * 27kg DM
      expect(result.ndfIntake, equals(6.75)); // 25% * 27kg DM
      expect(result.caIntake, equals(0.27)); // 1.0% * 27kg DM
      expect(result.pIntake, equals(0.162)); // 0.6% * 27kg DM
      expect(result.cost, equals(600.0)); // 20 * 30kg

      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });

    testWidgets('calculateIngredientValues handles zero weight input',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Test with zero weight
      final result = feedCalculator.calculateIngredientValues(
        'napier',
        0.0,
        true,
        testContext,
      );

      // Verify all calculated values are zero
      expect(result.weight, equals(0.0));
      expect(result.dmIntake, equals(0.0));
      expect(result.meIntake, equals(0.0));
      expect(result.cpIntake, equals(0.0));
      expect(result.ndfIntake, equals(0.0));
      expect(result.caIntake, equals(0.0));
      expect(result.pIntake, equals(0.0));
      expect(result.cost, equals(0.0));

      // Verify mocks were still called properly
      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });

    testWidgets('calculateIngredientValues maintains ingredient properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Test property preservation
      final result = feedCalculator.calculateIngredientValues(
        'napier',
        50.0,
        true,
        testContext,
      );

      // Verify original properties are maintained
      expect(result.id, equals('napier'));
      expect(result.name, equals('Napier Grass'));
      expect(result.isFodder, isTrue);
      expect(result.isAvailable, isTrue);

      // Verify mocks were called correctly
      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });
    testWidgets('calculateIngredientValues handles negative weight input',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Test with negative weight
      final result = feedCalculator.calculateIngredientValues(
        'napier',
        -50.0,
        true,
        testContext,
      );

      // Verify all calculated values handle negative input appropriately
      expect(result.weight, equals(-50.0));
      expect(result.dmIntake, equals(-15.0)); // 30% * -50kg
      expect(result.meIntake, equals(-37.5)); // 2.5 * -15kg DM
      expect(result.cpIntake, equals(-2.25)); // 15% * -15kg DM
      expect(result.ndfIntake, equals(-6.75)); // 45% * -15kg DM
      expect(result.caIntake, equals(-0.12)); // 0.8% * -15kg DM
      expect(result.pIntake, equals(-0.06)); // 0.4% * -15kg DM
      expect(result.cost, equals(-500.0)); // 10 * -50kg

      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });
    testWidgets('handles ingredient not found gracefully',
        (WidgetTester tester) async {
      // Setup mock to return empty lists
      when(mockFeedState.availableFodderItems).thenReturn([]);
      when(mockFeedState.availableConcentrateItems).thenReturn([]);

      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      expect(
        () => feedCalculator.calculateIngredientValues(
          'non_existent',
          50.0,
          true,
          testContext,
        ),
        throwsStateError,
      );

      // Verify mocks were called
      verify(mockFeedState.availableFodderItems).called(1);
      verify(mockFeedState.availableConcentrateItems).called(1);
    });
  });
}
