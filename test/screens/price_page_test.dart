import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/screens/price_page.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Generate mocks for FeedState
@GenerateMocks([FeedState, BuildContext])
import 'price_page_test.mocks.dart';

// Test implementation of FeedIngredient that overrides getName
class TestFeedIngredient extends FeedIngredient {
  TestFeedIngredient({
    required super.id,
    required super.name,
    required super.weight,
    required super.dmIntake,
    required super.meIntake,
    required super.cpIntake,
    required super.ndfIntake,
    required super.caIntake,
    required super.pIntake,
    required super.cost,
    required super.isAvailable,
    required super.isFodder,
  });

  @override
  String getName(BuildContext context) {
    return name; // Simply return the name without translation
  }
}

void main() {
  late MockFeedState mockFeedState;

  // Sample test data
  final sampleFodderItem = TestFeedIngredient(
    id: 'fodder1',
    name: 'Test Fodder',
    weight: 10.0,
    dmIntake: 5.0,
    meIntake: 2.0,
    cpIntake: 1.0,
    ndfIntake: 0.5,
    caIntake: 0.3,
    pIntake: 0.2,
    cost: 100.0,
    isAvailable: true,
    isFodder: true,
  );

  final sampleConcentrateItem = TestFeedIngredient(
    id: 'concentrate1',
    name: 'Test Concentrate',
    weight: 8.0,
    dmIntake: 4.0,
    meIntake: 1.5,
    cpIntake: 0.8,
    ndfIntake: 0.4,
    caIntake: 0.2,
    pIntake: 0.1,
    cost: 150.0,
    isAvailable: true,
    isFodder: false,
  );

  setUp(() {
    mockFeedState = MockFeedState();

    // Setup default mock behavior
    when(mockFeedState.fodderItems).thenReturn([sampleFodderItem]);
    when(mockFeedState.concentrateItems).thenReturn([sampleConcentrateItem]);
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
      home: ChangeNotifierProvider<FeedState>.value(
        value: mockFeedState,
        child: PricesPage(),
      ),
    );
  }

  group('PricesPage Widget Tests', () {
    testWidgets('renders correctly with initial data',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify sections are present
      expect(find.text('Fodder'), findsOneWidget);
      expect(find.text('Concentrate'), findsOneWidget);

      // Verify feed items are displayed
      expect(find.text('Test Fodder'), findsOneWidget);
      expect(find.text('Test Concentrate'), findsOneWidget);

      // Verify checkboxes are present
      expect(find.byType(Checkbox), findsNWidgets(2));

      // Verify text fields for cost are present
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('updates ingredient availability when checkbox is toggled',
        (WidgetTester tester) async {
      // First, we'll create a variable to capture the updated ingredient
      FeedIngredient? capturedIngredient;

      // Set up the mock to capture the ingredient when updateIngredient is called
      when(mockFeedState.updateIngredient(any)).thenAnswer((invocation) {
        capturedIngredient =
            invocation.positionalArguments[0] as FeedIngredient;
        return;
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap the first checkbox
      final checkbox = find.byType(Checkbox).first;
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      // Verify updateIngredient was called
      verify(mockFeedState.updateIngredient(any)).called(1);

      // Now verify the properties of the captured ingredient
      expect(capturedIngredient, isNotNull);
      expect(capturedIngredient!.isAvailable, false);
      expect(capturedIngredient!.id, equals(sampleFodderItem.id));
    });

    testWidgets('updates ingredient cost when text field changes',
        (WidgetTester tester) async {
      // Create a variable to capture the ingredient when it's updated
      FeedIngredient? capturedIngredient;

      // Set up the mock to capture the ingredient when updateIngredient is called
      when(mockFeedState.updateIngredient(any)).thenAnswer((invocation) {
        capturedIngredient =
            invocation.positionalArguments[0] as FeedIngredient;
        return;
      });

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and enter new value in the first cost text field
      final textField = find.byType(TextFormField).first;
      await tester.enterText(textField, '200.00');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify updateIngredient was called exactly once
      verify(mockFeedState.updateIngredient(any)).called(1);

      // Perform thorough verification of the captured ingredient
      expect(capturedIngredient, isNotNull,
          reason: 'An ingredient should have been captured');
      expect(capturedIngredient!.cost, 200.00,
          reason: 'Cost should be updated to 200.00');
      expect(capturedIngredient!.id, equals(sampleFodderItem.id),
          reason: 'Should be updating the correct ingredient');

      // Verify other properties remained unchanged
      expect(
          capturedIngredient!.isAvailable, equals(sampleFodderItem.isAvailable),
          reason: 'Availability should not change when updating cost');
      expect(capturedIngredient!.weight, equals(sampleFodderItem.weight),
          reason: 'Weight should not change when updating cost');
    });

    testWidgets('handles invalid cost input gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter invalid value
      final textField = find.byType(TextFormField).first;
      await tester.enterText(textField, 'invalid');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      // Verify updateIngredient was not called with invalid input
      verifyNever(mockFeedState.updateIngredient(any));
    });

    testWidgets('displays empty state when no items exist',
        (WidgetTester tester) async {
      // Setup empty lists
      when(mockFeedState.fodderItems).thenReturn([]);
      when(mockFeedState.concentrateItems).thenReturn([]);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify section headers still exist
      expect(find.text('Fodder'), findsOneWidget);
      expect(find.text('Concentrate'), findsOneWidget);

      // Verify no items are displayed
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('correctly formats cost values', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Verify cost text fields show formatted values
      expect(find.text('100.00'), findsOneWidget);
      expect(find.text('150.00'), findsOneWidget);
    });
  });
}
