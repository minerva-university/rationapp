import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/screens/cow_requirements_view.dart';
import 'package:rationapp/screens/cow_characteristics_page.dart';
import 'package:rationapp/screens/feed_formula_page.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/models/cow_requirements_model.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/feed_state.dart';

@GenerateMocks(
    [SharedPrefsService, CowRequirementsCalculator, FeedState, BuildContext])
import 'cow_requirements_view_test.mocks.dart';

void main() {
  late MockSharedPrefsService mockSharedPrefsService;
  late MockCowRequirementsCalculator mockCalculator;
  late MockFeedState mockFeedState;

  final testCowCharacteristics = CowCharacteristics(
    liveWeight: 500,
    pregnancyMonths: 5,
    milkVolume: 25.0,
    milkFat: 3.5,
    milkProtein: 3.2,
    lactationStage: 'early',
  );

  final testCowRequirements = CowRequirements(
    dmIntake: 1.0,
    meIntake: 1.0,
    cpIntake: 1.0,
    ndfIntake: 1.0,
    caIntake: 1.0,
    pIntake: 1.0,
    concentrateIntake: 10,
  );

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    mockCalculator = MockCowRequirementsCalculator();
    mockFeedState = MockFeedState();

    when(mockSharedPrefsService.getCowCharacteristics()).thenReturn(null);
    when(mockSharedPrefsService.getFeedFormula())
        .thenReturn(FeedFormula(fodder: [], concentrate: []));
  });

  Widget createTestWidget({String? initialRoute, Object? arguments}) {
    return MaterialApp(
      navigatorKey: GlobalKey<NavigatorState>(),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
          Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
          Provider<CowRequirementsCalculator>.value(value: mockCalculator),
        ],
        child: CowRequirementsView(),
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  group('CowRequirementsView Navigation Tests', () {
    testWidgets('renders CowCharacteristicsPage as initial route',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CowCharacteristicsPage), findsOneWidget);
      expect(find.byType(FeedFormulaPage), findsNothing);
    });

    testWidgets('navigates to FeedFormulaPage with correct arguments',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find the Navigator widget within CowRequirementsView
      final NavigatorState navigator =
          tester.state(find.byKey(CowRequirementsView.navigatorKey));

      // Push the route using the nested navigator
      navigator.pushNamed(
        '/feed_formula',
        arguments: {
          'cowCharacteristics': testCowCharacteristics,
          'cowRequirements': testCowRequirements,
        },
      );
      await tester.pumpAndSettle();

      expect(find.byType(FeedFormulaPage), findsOneWidget);
      expect(find.byType(CowCharacteristicsPage), findsNothing);

      // Verify correct props were passed
      final FeedFormulaPage feedFormulaPage =
          tester.widget<FeedFormulaPage>(find.byType(FeedFormulaPage));
      expect(
          feedFormulaPage.cowCharacteristics, equals(testCowCharacteristics));
      expect(feedFormulaPage.cowRequirements, equals(testCowRequirements));
    });

    testWidgets('returns empty container for unknown routes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final NavigatorState navigator =
          tester.state(find.byKey(CowRequirementsView.navigatorKey));
      navigator.pushNamed('/unknown_route');
      await tester.pumpAndSettle();

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(CowCharacteristicsPage), findsNothing);
      expect(find.byType(FeedFormulaPage), findsNothing);
    });

    testWidgets('provides required services to CowCharacteristicsPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final CowCharacteristicsPage cowCharacteristicsPage = tester
          .widget<CowCharacteristicsPage>(find.byType(CowCharacteristicsPage));

      expect(cowCharacteristicsPage.sharedPrefsService,
          equals(mockSharedPrefsService));
      expect(cowCharacteristicsPage.calculator, equals(mockCalculator));
    });

    testWidgets('handles missing arguments for FeedFormulaPage gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
            Provider<CowRequirementsCalculator>.value(value: mockCalculator),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                final navigatorWidget = CowRequirementsView().build(context);
                final navigator = navigatorWidget as Navigator;

                final route = navigator.onGenerateRoute?.call(
                  const RouteSettings(
                    name: '/feed_formula',
                    arguments: <String, dynamic>{
                      'cowCharacteristics': null,
                      'cowRequirements': null,
                    },
                  ),
                ) as MaterialPageRoute;

                expect(route, isA<MaterialPageRoute>());
                expect(
                  () => route.builder(context),
                  throwsA(isA<TypeError>()),
                );

                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });
}
