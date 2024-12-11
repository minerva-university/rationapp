import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/data/nutrition_tables.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Generate mocks specifically for this test file
@GenerateMocks([SharedPrefsService, NutritionTables])
import 'feed_state_test.mocks.dart';

void main() {
  late FeedState feedState;
  late MockSharedPrefsService mockSharedPrefsService;
  late MockNutritionTables mockNutritionTables;
  late List<FeedIngredient> mockFodderItems;
  late List<FeedIngredient> mockConcentrateItems;

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    mockNutritionTables = MockNutritionTables();
    feedState = FeedState();

    // Setup mock data
    mockFodderItems = [
      FeedIngredient(
        id: 'fodder1',
        name: 'Test Fodder 1',
        weight: 1.0,
        dmIntake: 1.0,
        meIntake: 1.0,
        cpIntake: 1.0,
        ndfIntake: 1.0,
        caIntake: 1.0,
        pIntake: 1.0,
        cost: 10,
        isAvailable: true,
        isFodder: true,
      ),
      FeedIngredient(
        id: 'fodder2',
        name: 'Test Fodder 2',
        weight: 1.0,
        dmIntake: 1.0,
        meIntake: 1.0,
        cpIntake: 1.0,
        ndfIntake: 1.0,
        caIntake: 1.0,
        pIntake: 1.0,
        cost: 15,
        isAvailable: false,
        isFodder: true,
      ),
    ];

    mockConcentrateItems = [
      FeedIngredient(
        id: 'concentrate1',
        name: 'Test Concentrate 1',
        weight: 1.0,
        dmIntake: 1.0,
        meIntake: 1.0,
        cpIntake: 1.0,
        ndfIntake: 1.0,
        caIntake: 1.0,
        pIntake: 1.0,
        cost: 20,
        isAvailable: true,
        isFodder: false,
      ),
      FeedIngredient(
        id: 'concentrate2',
        name: 'Test Concentrate 2',
        weight: 1.0,
        dmIntake: 1.0,
        meIntake: 1.0,
        cpIntake: 1.0,
        ndfIntake: 1.0,
        caIntake: 1.0,
        pIntake: 1.0,
        cost: 25,
        isAvailable: false,
        isFodder: false,
      ),
    ];

    // Setup default mock behavior
    when(mockSharedPrefsService.getFeedPricesAndAvailability())
        .thenReturn([...mockFodderItems, ...mockConcentrateItems]);
    when(mockNutritionTables.fodderItems).thenReturn(mockFodderItems);
    when(mockNutritionTables.concentrateItems).thenReturn(mockConcentrateItems);
    when(mockSharedPrefsService.setFeedPricesAndAvailability(any))
        .thenAnswer((_) => Future.value(true));
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
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
      home: MultiProvider(
        providers: [
          Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
          Provider<NutritionTables>.value(value: mockNutritionTables),
        ],
        child: child,
      ),
    );
  }

  Future<void> initializeFeedState(WidgetTester tester) async {
    await tester.pumpWidget(
      createTestWidget(
        Builder(
          builder: (context) {
            feedState.initializeWithContext(context);
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('FeedState Initialization Tests', () {
    test('initial state is empty', () {
      expect(feedState.fodderItems, isEmpty);
      expect(feedState.concentrateItems, isEmpty);
      expect(feedState.availableFodderItems, isEmpty);
      expect(feedState.availableConcentrateItems, isEmpty);
    });

    testWidgets('loads saved prices on initialization', (tester) async {
      when(mockSharedPrefsService.getFeedPricesAndAvailability())
          .thenReturn([...mockFodderItems, ...mockConcentrateItems]);

      await tester.pumpWidget(
        createTestWidget(
          Builder(
            builder: (context) {
              feedState.initializeWithContext(context);
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(feedState.fodderItems.length, equals(mockFodderItems.length));
      expect(feedState.concentrateItems.length,
          equals(mockConcentrateItems.length));
      verify(mockSharedPrefsService.getFeedPricesAndAvailability()).called(1);
    });

    testWidgets('loads default values when no saved prices exist',
        (tester) async {
      when(mockSharedPrefsService.getFeedPricesAndAvailability())
          .thenReturn(null);

      await tester.pumpWidget(
        createTestWidget(
          Builder(
            builder: (context) {
              feedState.initializeWithContext(context);
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(feedState.fodderItems, isNotEmpty);
      expect(feedState.concentrateItems, isNotEmpty);
      verify(mockSharedPrefsService.getFeedPricesAndAvailability()).called(1);
    });
  });

  group('FeedState Update Tests', () {
    setUp(() async {
      feedState.fodderItems = List.from(mockFodderItems);
      feedState.concentrateItems = List.from(mockConcentrateItems);
    });

    testWidgets('updateIngredient updates fodder item correctly',
        (tester) async {
      await initializeFeedState(tester);

      final updatedFodder = mockFodderItems[0].copyWith(cost: 15.0);
      feedState.updateIngredient(updatedFodder);
      await tester.pumpAndSettle();

      expect(feedState.fodderItems[0].cost, equals(15.0));
      verify(mockSharedPrefsService.setFeedPricesAndAvailability(any))
          .called(1);
    });

    testWidgets('updateIngredient updates concentrate item correctly',
        (tester) async {
      await initializeFeedState(tester);

      final updatedConcentrate = mockConcentrateItems[0].copyWith(cost: 25.0);
      feedState.updateIngredient(updatedConcentrate);
      await tester.pumpAndSettle();

      expect(feedState.concentrateItems[0].cost, equals(25.0));
      verify(mockSharedPrefsService.setFeedPricesAndAvailability(any))
          .called(1);
    });

    testWidgets('updateIngredient does nothing for non-existent item',
        (tester) async {
      await initializeFeedState(tester);

      final nonExistentItem = FeedIngredient(
        id: 'non-existent',
        name: 'Non-existent Item',
        weight: 1.0,
        dmIntake: 1.0,
        meIntake: 1.0,
        cpIntake: 1.0,
        ndfIntake: 1.0,
        caIntake: 1.0,
        pIntake: 1.0,
        cost: 10,
        isAvailable: true,
        isFodder: true,
      );

      feedState.updateIngredient(nonExistentItem);

      expect(feedState.fodderItems, equals(mockFodderItems));
      expect(feedState.concentrateItems, equals(mockConcentrateItems));
    });

    testWidgets('updateIngredient triggers notification', (tester) async {
      await initializeFeedState(tester);

      int notificationCount = 0;
      feedState.addListener(() => notificationCount++);

      final updatedFodder = mockFodderItems[0].copyWith(cost: 15.0);
      feedState.updateIngredient(updatedFodder);

      expect(notificationCount, equals(1));
    });
  });

  group('FeedState Getter Tests', () {
    setUp(() {
      feedState.fodderItems = List.from(mockFodderItems);
      feedState.concentrateItems = List.from(mockConcentrateItems);
    });

    test('availableFodderItems returns only available fodder items', () {
      final availableFodder = feedState.availableFodderItems;

      expect(availableFodder.length, equals(1));
      expect(availableFodder.every((item) => item.isAvailable), isTrue);
      expect(availableFodder.every((item) => item.isFodder), isTrue);
    });

    test('availableConcentrateItems returns only available concentrate items',
        () {
      final availableConcentrates = feedState.availableConcentrateItems;

      expect(availableConcentrates.length, equals(1));
      expect(availableConcentrates.every((item) => item.isAvailable), isTrue);
      expect(availableConcentrates.every((item) => !item.isFodder), isTrue);
    });
  });
}
