import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/widgets/custom_text_field.dart';

// Helper function to create a testable TextField widget
Widget createTestableTextField({
  required String labelText,
  required TextEditingController controller,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Material(
        child: CustomTextField(
          labelText: labelText,
          controller: controller,
        ),
      ),
    ),
  );
}

void main() {
  late TextEditingController controller;

  setUp(() {
    // Initialize a fresh controller before each test
    controller = TextEditingController();
  });

  tearDown(() {
    // Clean up the controller after each test
    controller.dispose();
  });

  group('CustomTextField Widget Tests', () {
    testWidgets('Renders correctly with all properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Verify the basic structure
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Test Label'), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('Applies correct styling and decoration',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Find the TextField
      final textField = tester.widget<TextField>(find.byType(TextField));

      // Verify the decoration properties
      final InputDecoration decoration = textField.decoration!;
      expect(decoration.labelText, equals('Test Label'));
      expect(decoration.filled, isTrue);
      expect(decoration.fillColor, equals(Colors.white));

      // Verify border radius
      final borderRadius =
          (decoration.border as OutlineInputBorder).borderRadius;
      expect(borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets('Handles text input correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Simulate typing text
      await tester.enterText(find.byType(TextField), '123.45');
      await tester.pump();

      // Verify the controller has the entered text
      expect(controller.text, equals('123.45'));
    });

    testWidgets('Uses number keyboard type', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      final TextField textField =
          tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, equals(TextInputType.number));
    });

    testWidgets('Handles padding correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Find the outermost Padding widget that contains the TextField
      final paddingFinder = find
          .ancestor(
            of: find.byType(TextField),
            matching: find.byType(Padding),
          )
          .first;

      final padding = tester.widget<Padding>(paddingFinder);

      // Verify the padding matches the widget's specification
      expect(padding.padding, equals(const EdgeInsets.symmetric(vertical: 8.0)),
          reason: 'CustomTextField should have vertical padding of 8.0');

      // Get the RenderBox for both padding and text field
      final RenderBox paddingBox =
          tester.renderObject<RenderBox>(paddingFinder);
      final RenderBox textFieldBox =
          tester.renderObject<RenderBox>(find.byType(TextField));

      // Verify that the padding increases the widget's height
      expect(paddingBox.size.height, greaterThan(textFieldBox.size.height),
          reason: 'Padding should increase the overall height of the widget');
    });

    testWidgets('Updates when controller text changes externally',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Update controller text programmatically
      controller.text = 'New Value';
      await tester.pump();

      // Verify the text field shows the new value
      expect(find.text('New Value'), findsOneWidget);
    });

    testWidgets('Maintains state during rebuild', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));

      // Enter some text
      await tester.enterText(find.byType(TextField), '42.5');
      await tester.pump();

      // Rebuild widget
      await tester.pumpWidget(createTestableTextField(
        labelText: 'Test Label',
        controller: controller,
      ));
      await tester.pump();

      // Verify text is maintained
      expect(find.text('42.5'), findsOneWidget);
    });
  });
}
