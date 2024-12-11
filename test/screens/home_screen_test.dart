import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/screens/home_screen.dart';
import 'package:rationapp/screens/cow_requirements_view.dart';
import 'package:rationapp/screens/feeding_guidelines_page.dart';
import 'package:rationapp/screens/price_page.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@GenerateMocks([SharedPrefsService, CowRequirementsCalculator, FeedState])
import 'home_screen_test.mocks.dart';

void main() {
  late MockSharedPrefsService mockSharedPrefsService;
  late MockCowRequirementsCalculator mockCalculator;
  late MockFeedState mockFeedState;

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    mockCalculator = MockCowRequirementsCalculator();
    mockFeedState = MockFeedState();
    late List<FeedIngredient> testFodderItems;
    late List<FeedIngredient> testConcentrateItems;

    final savedCharacteristics = CowCharacteristics(
      liveWeight: 500,
      pregnancyMonths: 5,
      milkVolume: 25.0,
      milkFat: 3.5,
      milkProtein: 3.2,
      lactationStage: 'Dry',
    );

    // Set up test data
    testFodderItems = [
      FeedIngredient(
        id: 'grass_fresh',
        name: 'Fresh Grass',
        weight: 30.0,
        dmIntake: 6.0,
        meIntake: 65.0,
        cpIntake: 0.18,
        ndfIntake: 45.0,
        caIntake: 0.5,
        pIntake: 0.3,
        cost: 2.0,
        isFodder: true,
      ),
    ];

    testConcentrateItems = [
      FeedIngredient(
        id: 'corn',
        name: 'Corn',
        weight: 5.0,
        dmIntake: 4.5,
        meIntake: 55.0,
        cpIntake: 0.09,
        ndfIntake: 15.0,
        caIntake: 0.03,
        pIntake: 0.25,
        cost: 8.0,
        isFodder: false,
      ),
    ];

    // Set up mock behavior
    when(mockFeedState.fodderItems).thenReturn(testFodderItems);
    when(mockFeedState.concentrateItems).thenReturn(testConcentrateItems);
    when(mockSharedPrefsService.getCowCharacteristics())
        .thenReturn(savedCharacteristics);
  });

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
        Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
        Provider<CowRequirementsCalculator>.value(value: mockCalculator),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('renders with initial cow requirements view',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify initial state shows cow requirements view
      expect(find.byType(CowRequirementsView), findsOneWidget);
      expect(find.byType(PricesPage), findsNothing);
      expect(find.byType(FeedingGuidelinesPage), findsNothing);
    });

    testWidgets('bottom navigation bar shows all three destinations',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify all navigation items are present
      final navigationBar = find.byType(NavigationBar);
      expect(navigationBar, findsOneWidget);

      // Check for navigation destinations
      expect(find.byIcon(Icons.calculate), findsOneWidget); // Cow Requirements
      expect(find.byIcon(Icons.attach_money), findsOneWidget); // Prices
      expect(
          find.byIcon(Icons.menu_book), findsOneWidget); // Feeding Guidelines
    });

    testWidgets('navigates to prices page when selecting second tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the prices tab
      final pricesTab = find.byIcon(Icons.attach_money);
      await tester.tap(pricesTab);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.byType(PricesPage), findsOneWidget);
      expect(find.byType(CowRequirementsView), findsNothing);
      expect(find.byType(FeedingGuidelinesPage), findsNothing);
    });

    testWidgets('navigates to feeding guidelines when selecting third tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the feeding guidelines tab
      final guidelinesTab = find.byIcon(Icons.menu_book);
      await tester.tap(guidelinesTab);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.byType(FeedingGuidelinesPage), findsOneWidget);
      expect(find.byType(CowRequirementsView), findsNothing);
      expect(find.byType(PricesPage), findsNothing);
    });

    testWidgets('maintains separate navigation stacks for each tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Navigate to prices tab
      await tester.tap(find.byIcon(Icons.attach_money));
      await tester.pumpAndSettle();

      // Navigate to feeding guidelines tab
      await tester.tap(find.byIcon(Icons.menu_book));
      await tester.pumpAndSettle();

      // Navigate back to first tab
      await tester.tap(find.byIcon(Icons.calculate));
      await tester.pumpAndSettle();

      // Verify we're back at cow requirements view
      expect(find.byType(CowRequirementsView), findsOneWidget);
    });

    testWidgets('handles system back button press correctly',
        (WidgetTester tester) async {
      // Keep track if pop was handled
      bool? popHandled;

      // Create widget with existing helper but wrap HomeScreen with PopScope
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
          Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
          Provider<CowRequirementsCalculator>.value(value: mockCalculator),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              popHandled = didPop;
            },
            child: const HomeScreen(),
          ),
        ),
      ));
      await tester.pumpAndSettle();

      // Navigate to different tabs
      await tester.tap(find.byIcon(Icons.attach_money));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu_book));
      await tester.pumpAndSettle();

      // Simulate system back button
      final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
      await widgetsAppState.didPopRoute();
      await tester.pumpAndSettle();

      // Verify pop was handled and not allowed to close the app
      expect(popHandled, false);

      // Should return to first tab
      await tester.tap(find.byIcon(Icons.calculate));
      await tester.pumpAndSettle();
      expect(find.byType(CowRequirementsView), findsOneWidget);
    });
  });
}
