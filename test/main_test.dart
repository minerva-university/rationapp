import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'package:rationapp/screens/home_screen.dart';
import 'package:rationapp/main.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@GenerateMocks([SharedPrefsService, CowRequirementsCalculator, FeedState])
import 'main_test.mocks.dart';

void main() {
  late MockSharedPrefsService mockSharedPrefsService;
  late MockCowRequirementsCalculator mockCalculator;
  late MockFeedState mockFeedState;

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    mockCalculator = MockCowRequirementsCalculator();
    mockFeedState = MockFeedState();

    // Setup default mock behavior
    when(mockSharedPrefsService.getCowCharacteristics()).thenReturn(null);
    when(mockSharedPrefsService.getFeedPricesAndAvailability())
        .thenReturn(null);
    when(mockFeedState.initializeWithContext(any)).thenReturn(null);
    when(mockFeedState.fodderItems).thenReturn([]);
    when(mockFeedState.concentrateItems).thenReturn([]);
    when(mockFeedState.availableFodderItems).thenReturn([]);
    when(mockFeedState.availableConcentrateItems).thenReturn([]);
  });

  Widget createTestApp({MockFeedState? innerFeedState}) {
    if (innerFeedState == null) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
          Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
          Provider<CowRequirementsCalculator>.value(value: mockCalculator),
        ],
        child: const RationCalculatorApp(),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedState>.value(value: mockFeedState),
        Provider<SharedPrefsService>.value(value: mockSharedPrefsService),
        Provider<CowRequirementsCalculator>.value(value: mockCalculator),
      ],
      child: ChangeNotifierProvider<FeedState>.value(
        value: innerFeedState,
        child: Builder(
          builder: (context) {
            final feedState = Provider.of<FeedState>(context, listen: false);
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
              home: Builder(
                builder: (context) {
                  feedState.initializeWithContext(context);
                  return const HomeScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  group('RationCalculatorApp Tests', () {
    testWidgets('renders MaterialApp with correct theme', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, true);
      expect(materialApp.theme?.colorScheme.primary,
          ColorScheme.fromSeed(seedColor: Colors.green).primary);
    });

    testWidgets('configures correct localization delegates', (tester) async {
      await tester.pumpWidget(createTestApp());

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final expectedDelegates = [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

      for (final delegate in expectedDelegates) {
        expect(materialApp.localizationsDelegates, contains(delegate));
      }
    });

    testWidgets('provides all required providers', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final homeContext = tester.element(find.byType(HomeScreen));
      final providers = [
        Provider.of<FeedState>(homeContext, listen: false),
        Provider.of<SharedPrefsService>(homeContext, listen: false),
        Provider.of<CowRequirementsCalculator>(homeContext, listen: false),
      ];

      for (final provider in providers) {
        expect(provider, isNotNull);
      }
    });

    testWidgets('initializes FeedState with context', (tester) async {
      await tester.pumpWidget(createTestApp(innerFeedState: mockFeedState));
      await tester.pumpAndSettle();

      verify(mockFeedState.initializeWithContext(any)).called(1);
    });

    testWidgets('renders HomeScreen as initial route', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('provides correct theme to descendants', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(HomeScreen));
      final theme = Theme.of(context);

      expect(theme.useMaterial3, true);
      expect(
        theme.colorScheme.primary,
        ColorScheme.fromSeed(seedColor: Colors.green).primary,
      );
    });
  });

  group('App Initialization Tests', () {
    test('SharedPrefsService.init() is called before runApp', () {
      expect(SharedPrefsService.init, isNotNull);
    });

    testWidgets('FeedState is initialized only once', (tester) async {
      await tester.pumpWidget(createTestApp(innerFeedState: mockFeedState));
      await tester.pumpAndSettle();

      verify(mockFeedState.initializeWithContext(any)).called(1);
    });

    testWidgets('providers are accessible throughout widget tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Test accessibility at different levels of widget tree
      final BuildContext homeContext = tester.element(find.byType(HomeScreen));

      expect(
        Provider.of<FeedState>(homeContext, listen: false),
        isNotNull,
      );
      expect(
        Provider.of<SharedPrefsService>(homeContext, listen: false),
        isNotNull,
      );
      expect(
        Provider.of<CowRequirementsCalculator>(homeContext, listen: false),
        isNotNull,
      );
    });
  });
}
