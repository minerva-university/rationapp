import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/widgets/custom_dropdown_field.dart';

Widget createTestableDropdown({
  required List<String> options,
  required ValueChanged<String?> onChanged,
  required String value,
  String? labelText,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Material(
        child: CustomDropdownField(
          options: options,
          onChanged: onChanged,
          value: value,
          labelText: labelText,
        ),
      ),
    ),
  );
}

void main() {
  // Sample test data
  final List<String> sampleOptions = ['Option 1', 'Option 2', 'Option 3'];

  group('CustomDropdownField Widget Tests', () {
    testWidgets('Renders correctly with all properties',
        (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (value) => selectedValue = value,
        value: sampleOptions[0],
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // Verify the basic structure
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
      expect(selectedValue, isNull);
    });

    testWidgets('Applies correct styling and decoration',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (_) {},
        value: sampleOptions[0],
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // Find the DropdownButtonFormField
      final dropdownFormField = tester.widget<DropdownButtonFormField<String>>(
        find.byType(DropdownButtonFormField<String>),
      );

      // Verify the decoration properties
      final InputDecoration decoration = dropdownFormField.decoration;
      expect(decoration.labelText, equals('Test Label'));
      expect(decoration.filled, isTrue);
      expect(decoration.fillColor, equals(Colors.white));

      // Verify border radius
      final borderRadius =
          (decoration.border as OutlineInputBorder).borderRadius;
      expect(borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets('Handles empty/null value correctly',
        (WidgetTester tester) async {
      // Create a dropdown with an empty value
      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (_) {},
        value: '',
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // First, verify the initial state
      // The dropdown should show the label text
      expect(find.text('Test Label'), findsOneWidget);

      // Open the dropdown to verify the options
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Verify all options are available in the dropdown menu
      for (final option in sampleOptions) {
        expect(find.text(option), findsWidgets);
      }

      // Verify that selecting an option works
      await tester.tap(find.text('Option 1').last);
      await tester.pumpAndSettle();

      // After selection, the dropdown should show the selected value
      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('Shows all options when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (_) {},
        value: sampleOptions[0],
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // Before opening, verify initial state
      expect(find.text(sampleOptions[0]),
          findsOneWidget); // Only the selected value is shown
      expect(find.text(sampleOptions[1]),
          findsNothing); // Other options are not visible yet
      expect(find.text(sampleOptions[2]), findsNothing);

      // Tap the dropdown to open it
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // After opening, each option appears twice:
      // Once in the button (if selected) and once in the dropdown menu
      for (final option in sampleOptions) {
        // If it's the selected option, it appears twice (button and menu)
        if (option == sampleOptions[0]) {
          expect(find.text(option), findsNWidgets(2));
        } else {
          // Non-selected options appear once (only in menu)
          expect(find.text(option), findsOneWidget);
        }
      }
    });

    testWidgets('Calls onChanged when selection changes',
        (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (value) => selectedValue = value,
        value: sampleOptions[0],
        labelText: 'Test Label',
      ));

      // Open the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select a different option
      await tester.tap(find.text('Option 2').last);
      await tester.pumpAndSettle();

      // Verify the selection changed
      expect(selectedValue, equals('Option 2'));
    });

    testWidgets('Handles padding correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (_) {},
        value: sampleOptions[0],
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // Find the CustomDropdownField's padding by looking for the outermost Padding widget
      // that contains a DropdownButtonFormField
      final paddingFinder = find
          .ancestor(
            of: find.byType(DropdownButtonFormField<String>),
            matching: find.byType(Padding),
          )
          .first;

      final padding = tester.widget<Padding>(paddingFinder);

      // Verify the padding matches our widget's specification
      expect(padding.padding, equals(const EdgeInsets.symmetric(vertical: 8.0)),
          reason: 'CustomDropdownField should have vertical padding of 8.0');

      // Get the RenderBox for the padding widget and dropdown
      final RenderBox paddingBox =
          tester.renderObject<RenderBox>(paddingFinder);
      final RenderBox dropdownBox = tester.renderObject<RenderBox>(
          find.byType(DropdownButtonFormField<String>));

      // Verify that the padding increases the widget's height
      expect(paddingBox.size.height, greaterThan(dropdownBox.size.height),
          reason: 'Padding should increase the overall height of the widget');
    });

    testWidgets('Updates when external value changes',
        (WidgetTester tester) async {
      // Start with first option
      final widget = MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: CustomDropdownField(
                options: sampleOptions,
                onChanged: (_) {},
                value: sampleOptions[0],
                labelText: 'Test Label',
              ),
            );
          },
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Option 1'), findsOneWidget);

      // Rebuild with different value
      await tester.pumpWidget(createTestableDropdown(
        options: sampleOptions,
        onChanged: (_) {},
        value: sampleOptions[1],
        labelText: 'Test Label',
      ));
      await tester.pumpAndSettle();

      // Verify the value updated
      expect(find.text('Option 2'), findsOneWidget);
    });
  });
}
