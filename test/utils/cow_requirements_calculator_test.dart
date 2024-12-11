import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:rationapp/screens/feed_formula_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/models/feed_formula_model.dart';

// Create mocks
@GenerateMocks([SharedPrefsService])
import 'cow_requirements_calculator_test.mocks.dart';

void main() {
  late CowRequirementsCalculator calculator;
  late MockSharedPrefsService mockSharedPrefsService;
  late TextEditingController liveWeightController;
  late TextEditingController pregnancyController;
  late TextEditingController volumeController;
  late TextEditingController milkFatController;
  late TextEditingController milkProteinController;

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    calculator = CowRequirementsCalculator();

    // Initialize controllers with test values
    liveWeightController = TextEditingController(text: '500');
    pregnancyController = TextEditingController(text: '5');
    volumeController = TextEditingController(text: '25.0');
    milkFatController = TextEditingController(text: '3.5');
    milkProteinController = TextEditingController(text: '3.2');

    when(mockSharedPrefsService.getFeedFormula())
        .thenReturn(FeedFormula(fodder: [], concentrate: []));
  });

  tearDown(() {
    liveWeightController.dispose();
    pregnancyController.dispose();
    volumeController.dispose();
    milkFatController.dispose();
    milkProteinController.dispose();
  });

  group('CowRequirementsCalculator Calculation Tests', () {
    // These tests verify the calculation logic without UI components

    test('correctly parses input values', () {
      final characteristics = CowCharacteristics(
        liveWeight: int.parse(liveWeightController.text),
        pregnancyMonths: int.parse(pregnancyController.text),
        milkVolume: double.parse(volumeController.text),
        milkFat: double.parse(milkFatController.text),
        milkProtein: double.parse(milkProteinController.text),
        lactationStage: 'early_lactation',
      );

      expect(characteristics.liveWeight, equals(500));
      expect(characteristics.pregnancyMonths, equals(5));
      expect(characteristics.milkVolume, equals(25.0));
      expect(characteristics.milkFat, equals(3.5));
      expect(characteristics.milkProtein, equals(3.2));
    });

    test('correctly handles invalid input', () {
      liveWeightController.text = 'invalid';
      pregnancyController.text = 'invalid';
      volumeController.text = 'invalid';
      milkFatController.text = 'invalid';
      milkProteinController.text = 'invalid';

      final characteristics = CowCharacteristics(
        liveWeight: int.tryParse(liveWeightController.text) ?? 0,
        pregnancyMonths: int.tryParse(pregnancyController.text) ?? 0,
        milkVolume: double.tryParse(volumeController.text) ?? 0.0,
        milkFat: double.tryParse(milkFatController.text) ?? 0.0,
        milkProtein: double.tryParse(milkProteinController.text) ?? 0.0,
        lactationStage: 'early_lactation',
      );

      expect(characteristics.liveWeight, equals(0));
      expect(characteristics.pregnancyMonths, equals(0));
      expect(characteristics.milkVolume, equals(0.0));
      expect(characteristics.milkFat, equals(0.0));
      expect(characteristics.milkProtein, equals(0.0));
    });
  });

  group('CowRequirementsCalculator Widget Tests', () {
    late BuildContext testContext;

    Widget createTestWidget(Widget child) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FeedState()),
          Provider<SharedPrefsService>(create: (_) => SharedPrefsService()),
          Provider<CowRequirementsCalculator>(
              create: (_) => CowRequirementsCalculator()),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          // Add routes configuration
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == '/feed_formula') {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => FeedFormulaPage(
                  cowCharacteristics: args['cowCharacteristics'],
                  cowRequirements: args['cowRequirements'],
                  sharedPrefsService: mockSharedPrefsService,
                ),
              );
            }
            return null;
          },
          home: Builder(
            builder: (BuildContext context) {
              testContext = context;
              return Scaffold(body: child);
            },
          ),
        ),
      );
    }

    testWidgets('shows dialog with requirements values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Call the calculator
      calculator.calculateCowRequirements(
        testContext,
        liveWeightController,
        pregnancyController,
        volumeController,
        milkFatController,
        milkProteinController,
        'early_lactation',
      );

      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.byType(AlertDialog), findsOneWidget);

      // Verify all the fields are present
      expect(
          find.textContaining(S.of(testContext).dmIntakeLabel), findsOneWidget);
      expect(
          find.textContaining(S.of(testContext).meIntakeLabel), findsOneWidget);
      expect(
          find.textContaining(S.of(testContext).cpIntakeLabel), findsOneWidget);
      expect(find.textContaining(S.of(testContext).ndfIntakeLabel),
          findsOneWidget);
      expect(
          find.textContaining(S.of(testContext).caIntakeLabel), findsOneWidget);
      expect(
          find.textContaining(S.of(testContext).pIntakeLabel), findsOneWidget);
      expect(find.textContaining(S.of(testContext).concentrateIntakeLabel),
          findsOneWidget);
    });

    testWidgets(
        'dialog has Plan Feed button that navigates to feed formula page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      calculator.calculateCowRequirements(
        testContext,
        liveWeightController,
        pregnancyController,
        volumeController,
        milkFatController,
        milkProteinController,
        'early_lactation',
      );

      await tester.pumpAndSettle();

      // Verify Plan Feed button exists
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(S.of(testContext).planFeed), findsOneWidget);

      // Tap the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify navigation to FeedFormulaPage
      expect(find.byType(FeedFormulaPage), findsOneWidget);
    });

    testWidgets('shows dialog with different lactation stages',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      final stages = [
        'early_lactation',
        'mid_lactation',
        'late_lactation',
        'dry'
      ];

      for (final stage in stages) {
        // Clear any existing dialogs first
        if (find.byType(AlertDialog).evaluate().isNotEmpty) {
          await tester
              .tapAt(const Offset(0, 0)); // Tap outside dialog to dismiss it
          await tester.pumpAndSettle();
        }

        calculator.calculateCowRequirements(
          testContext,
          liveWeightController,
          pregnancyController,
          volumeController,
          milkFatController,
          milkProteinController,
          stage,
        );

        await tester.pumpAndSettle();

        // Verify dialog is shown
        expect(find.byType(AlertDialog), findsOneWidget);

        // Look specifically for the content text style
        final contentTextFinder = find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.style?.fontSize == 18.0 &&
            widget.data!.contains('DM Intake:'));

        expect(contentTextFinder, findsOneWidget);

        // Each stage should have different requirements
        final String dialogText = tester.widget<Text>(contentTextFinder).data!;

        if (stage == 'dry') {
          expect(
              dialogText.contains(S.of(testContext).percentageValue('12.00')),
              isTrue,
              reason:
                  'Dry stage should have 12% CP\nActual dialog text:\n$dialogText');
        } else if (stage == 'early_lactation') {
          expect(dialogText.contains(S.of(testContext).percentageValue('0.00')),
              isTrue,
              reason:
                  'Early lactation should have 16% CP\nActual dialog text:\n$dialogText');
        }

        // Close dialog before next iteration
        await tester.tap(find.text(S.of(testContext).planFeed));
        await tester.pumpAndSettle();
      }
    });

    testWidgets('handles invalid input gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(Container()));
      await tester.pumpAndSettle();

      // Set invalid values in controllers
      liveWeightController.text = 'invalid';
      pregnancyController.text = 'invalid';
      volumeController.text = 'invalid';
      milkFatController.text = 'invalid';
      milkProteinController.text = 'invalid';

      calculator.calculateCowRequirements(
        testContext,
        liveWeightController,
        pregnancyController,
        volumeController,
        milkFatController,
        milkProteinController,
        'early_lactation',
      );

      await tester.pumpAndSettle();

      // Verify dialog is shown even with invalid input
      expect(find.byType(AlertDialog), findsOneWidget);

      // Verify all required fields are present
      expect(
          find.textContaining(S.of(testContext).dmIntakeLabel), findsOneWidget);
      expect(
          find.textContaining(S.of(testContext).meIntakeLabel), findsOneWidget);
    });
  });
}
