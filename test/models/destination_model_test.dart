import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/models/destination_model.dart';

void main() {
  group('Destination Model', () {
    // Test data that we'll use across multiple tests
    const testLabel = 'Test Destination';
    const testIcon = Icons.home;
    final testWidget = Container(key: Key('test_widget'));

    Widget testBuilder(BuildContext context) => testWidget;

    test('should create a Destination object with all properties', () {
      // Arrange & Act
      final destination = Destination(
        label: testLabel,
        icon: testIcon,
        builder: testBuilder,
      );

      // Assert
      expect(destination.label, equals(testLabel));
      expect(destination.icon, equals(testIcon));
      expect(destination.builder, equals(testBuilder));
    });

    testWidgets('builder should create correct widget',
        (WidgetTester tester) async {
      // Arrange
      final destination = Destination(
        label: testLabel,
        icon: testIcon,
        builder: testBuilder,
      );

      // Act - Create a minimal widget tree to test the builder
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => destination.builder(context),
          ),
        ),
      );

      // Assert - Verify that the builder created the expected widget
      expect(find.byKey(Key('test_widget')), findsOneWidget);
    });

    testWidgets('builder should work with different widget types',
        (WidgetTester tester) async {
      // Test with Text widget
      final textDestination = Destination(
        label: 'Text Test',
        icon: Icons.text_fields,
        builder: (context) => Text('Test Text', key: Key('text_widget')),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => textDestination.builder(context),
          ),
        ),
      );

      expect(find.byKey(Key('text_widget')), findsOneWidget);
      expect(find.text('Test Text'), findsOneWidget);

      // Test with Column widget containing multiple children
      final columnDestination = Destination(
        label: 'Column Test',
        icon: Icons.view_column,
        builder: (context) => Column(
          key: Key('column_widget'),
          children: [
            Text('Child 1'),
            Text('Child 2'),
          ],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => columnDestination.builder(context),
          ),
        ),
      );

      expect(find.byKey(Key('column_widget')), findsOneWidget);
      expect(find.text('Child 1'), findsOneWidget);
      expect(find.text('Child 2'), findsOneWidget);
    });

    testWidgets('builder should handle context-dependent widgets',
        (WidgetTester tester) async {
      // Test with a widget that uses Theme data from context
      final themeDestination = Destination(
        label: 'Theme Test',
        icon: Icons.palette,
        builder: (context) => Text(
          'Themed Text',
          key: Key('theme_text'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 20.0),
            ),
          ),
          home: Builder(
            builder: (context) => themeDestination.builder(context),
          ),
        ),
      );

      expect(find.byKey(Key('theme_text')), findsOneWidget);

      // Verify that the theme was correctly applied
      final Text textWidget = tester.widget(find.byKey(Key('theme_text')));
      expect(textWidget.style?.fontSize, equals(20.0));
    });

    test('should work with various icon types', () {
      // Test with different Material icons
      final iconTypes = [
        Icons.home,
        Icons.settings,
        Icons.person,
        Icons.favorite,
      ];

      for (final icon in iconTypes) {
        final destination = Destination(
          label: testLabel,
          icon: icon,
          builder: testBuilder,
        );

        expect(destination.icon, equals(icon));
      }
    });
  });
}
