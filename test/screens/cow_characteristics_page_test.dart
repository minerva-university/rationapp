import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/screens/cow_characteristics_page.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rationapp/widgets/custom_dropdown_field.dart';
import 'package:rationapp/widgets/custom_text_field.dart';

@GenerateMocks([SharedPrefsService, CowRequirementsCalculator])
import 'cow_characteristics_page_test.mocks.dart';

void main() {
  late MockSharedPrefsService mockSharedPrefsService;
  late MockCowRequirementsCalculator mockCalculator;

  const String selectLiveWeight = 'Live weight (kg)';
  const String selectPregnancy = 'Pregnancy (mth)';
  const String inputMilkVolume = "Milk volume per day (kg)";
  const String selectMilkFat = 'Milk fat (%)';
  const String selectMilkProtein = 'Milk protein (%)';
  const String selectLactationStage = 'Lactation stage';

  setUp(() {
    mockSharedPrefsService = MockSharedPrefsService();
    mockCalculator = MockCowRequirementsCalculator();

    when(mockSharedPrefsService.getCowCharacteristics()).thenReturn(null);
    when(mockSharedPrefsService.setCowCharacteristics(any))
        .thenAnswer((_) => Future.value(true));
  });

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
      home: ScaffoldMessenger(
        child: CowCharacteristicsPage(
          sharedPrefsService: mockSharedPrefsService,
          calculator: mockCalculator,
        ),
      ),
    );
  }

  group('CowCharacteristicsPage Widget Tests', () {
    testWidgets('loads saved characteristics on init',
        (WidgetTester tester) async {
      final savedCharacteristics = CowCharacteristics(
        liveWeight: 500,
        pregnancyMonths: 5,
        milkVolume: 25.0,
        milkFat: 3.5,
        milkProtein: 3.2,
        lactationStage: 'Dry',
      );

      when(mockSharedPrefsService.getCowCharacteristics())
          .thenReturn(savedCharacteristics);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify fields are populated with saved values
      expect(find.text('500'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('25.0'), findsOneWidget);
      expect(find.text('3.5'), findsOneWidget);
      expect(find.text('3.2'), findsOneWidget);
    });

    testWidgets('shows empty fields when no saved data exists',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify dropdown fields are empty by checking for hint texts
      expect(find.text(selectLiveWeight), findsOneWidget);
      expect(find.text(selectPregnancy), findsOneWidget);
      expect(find.text(inputMilkVolume), findsOneWidget);
      expect(find.text(selectMilkFat), findsOneWidget);
      expect(find.text(selectMilkProtein), findsOneWidget);
      expect(find.text(selectLactationStage), findsOneWidget);

      // Verify text field is empty
      final textFieldFinder = find.byType(CustomTextField);
      expect(textFieldFinder, findsOneWidget);
      expect(
        (tester.widget(textFieldFinder) as CustomTextField).controller.text,
        isEmpty,
      );
    });

    testWidgets('validates form before submission',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Ensure the button is visible
      final buttonFinder =
          find.byKey(const Key('submit_button'), skipOffstage: false);
      await tester.ensureVisible(buttonFinder);
      expect(buttonFinder, findsOneWidget);

      // Tap the button
      await tester.pumpAndSettle();
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify error snackbar is shown
      expect(find.byType(SnackBar, skipOffstage: false), findsOneWidget);
      expect(
          find.text("Please fill in all fields before viewing requirements."),
          findsOneWidget);
    });

    testWidgets(
        'saves characteristics and calculates requirements on valid submission',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Fill in all required fields
      await tester.tap(find.text(selectLiveWeight));
      final selectedLiveWeight = find.text('100');
      await tester.pumpAndSettle();

      await tester.tap(selectedLiveWeight);
      await tester.pumpAndSettle();

      await tester.tap(find.text(selectPregnancy));
      await tester.pumpAndSettle();
      await tester.tap(find.text('0'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(CustomTextField), '25.0');

      await tester.tap(find.text(selectMilkFat));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3.0'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(selectMilkProtein));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3.2').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text(selectLactationStage));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dry').last);
      await tester.pumpAndSettle();

      // Submit form
      // Ensure the button is visible
      final buttonFinder =
          find.byKey(const Key('submit_button'), skipOffstage: false);
      await tester.ensureVisible(buttonFinder);
      expect(buttonFinder, findsOneWidget);

      // Tap the button
      await tester.pumpAndSettle();
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify save was called
      verify(mockSharedPrefsService.setCowCharacteristics(any)).called(1);

      // Verify calculator was called
      verify(mockCalculator.calculateCowRequirements(
        any,
        any,
        any,
        any,
        any,
        any,
        any,
      )).called(1);
    });

    testWidgets('updates field values when dropdowns are changed',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Test live weight dropdown
      await tester.tap(find.text(selectLiveWeight));
      await tester.pumpAndSettle();
      await tester.tap(find.text('100'));
      await tester.pumpAndSettle();

      expect(find.text('100'), findsOneWidget);

      // Test milk fat dropdown
      await tester.tap(find.text(selectMilkFat));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3.5'));
      await tester.pumpAndSettle();

      expect(find.text('3.5'), findsOneWidget);
    });

    testWidgets('custom text field accepts valid input',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter valid milk volume
      await tester.enterText(find.byType(CustomTextField), '25.5');
      await tester.pumpAndSettle();

      expect(find.text('25.5'), findsOneWidget);
    });

    testWidgets('renders all required form fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify all form fields are present
      expect(find.byType(CustomDropdownField), findsNWidgets(5));
      expect(find.byType(CustomTextField), findsOneWidget);
      expect(find.byType(ElevatedButton, skipOffstage: false), findsOneWidget);
    });

    testWidgets('displays correct labels for all fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text(selectLiveWeight), findsOneWidget);
      expect(find.text(selectPregnancy), findsOneWidget);
      expect(find.text(inputMilkVolume), findsOneWidget);
      expect(find.text(selectMilkFat), findsOneWidget);
      expect(find.text(selectMilkProtein), findsOneWidget);
      expect(find.text(selectLactationStage), findsOneWidget);
    });
  });
}
