import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/generated/l10n.dart';

void main() {
  // We'll start by testing the FeedIngredient class since FeedFormula depends on it
  group('FeedIngredient', () {
    // Test data that represents a typical feed ingredient
    final testIngredient = {
      'id': 'corn_silage',
      'name': 'Corn Silage',
      'weight': 10.5,
      'dmIntake': 35.0,
      'meIntake': 2.5,
      'cpIntake': 8.0,
      'ndfIntake': 45.0,
      'caIntake': 0.3,
      'pIntake': 0.2,
      'cost': 150.0,
      'isAvailable': true,
      'isFodder': true,
    };

    test('should create a FeedIngredient with all properties', () {
      // Arrange & Act
      final ingredient = FeedIngredient(
        id: testIngredient['id'] as String,
        name: testIngredient['name'] as String,
        weight: testIngredient['weight'] as double,
        dmIntake: testIngredient['dmIntake'] as double,
        meIntake: testIngredient['meIntake'] as double,
        cpIntake: testIngredient['cpIntake'] as double,
        ndfIntake: testIngredient['ndfIntake'] as double,
        caIntake: testIngredient['caIntake'] as double,
        pIntake: testIngredient['pIntake'] as double,
        cost: testIngredient['cost'] as double,
        isAvailable: testIngredient['isAvailable'] as bool,
        isFodder: testIngredient['isFodder'] as bool,
      );

      // Assert - verify all properties are set correctly
      expect(ingredient.id, equals(testIngredient['id']));
      expect(ingredient.name, equals(testIngredient['name']));
      expect(ingredient.weight, equals(testIngredient['weight']));
      expect(ingredient.dmIntake, equals(testIngredient['dmIntake']));
      expect(ingredient.meIntake, equals(testIngredient['meIntake']));
      expect(ingredient.cpIntake, equals(testIngredient['cpIntake']));
      expect(ingredient.ndfIntake, equals(testIngredient['ndfIntake']));
      expect(ingredient.caIntake, equals(testIngredient['caIntake']));
      expect(ingredient.pIntake, equals(testIngredient['pIntake']));
      expect(ingredient.cost, equals(testIngredient['cost']));
      expect(ingredient.isAvailable, equals(testIngredient['isAvailable']));
      expect(ingredient.isFodder, equals(testIngredient['isFodder']));
    });

    test('should implement operator [] correctly', () {
      // Arrange
      final ingredient = FeedIngredient.fromJson(testIngredient);

      // Act & Assert - test accessing all properties using operator []
      expect(ingredient['id'], equals(testIngredient['id']));
      expect(ingredient['name'], equals(testIngredient['name']));
      expect(ingredient['weight'], equals(testIngredient['weight']));
      expect(ingredient['dmIntake'], equals(testIngredient['dmIntake']));
      expect(ingredient['meIntake'], equals(testIngredient['meIntake']));
      expect(ingredient['cpIntake'], equals(testIngredient['cpIntake']));
      expect(ingredient['ndfIntake'], equals(testIngredient['ndfIntake']));
      expect(ingredient['caIntake'], equals(testIngredient['caIntake']));
      expect(ingredient['pIntake'], equals(testIngredient['pIntake']));
      expect(ingredient['cost'], equals(testIngredient['cost']));
      expect(ingredient['isAvailable'], equals(testIngredient['isAvailable']));
      expect(ingredient['isFodder'], equals(testIngredient['isFodder']));

      // Test invalid key
      expect(() => ingredient['invalid_key'], throwsArgumentError);
    });

    group('JSON Serialization', () {
      test('should correctly convert FeedIngredient to JSON', () {
        // Arrange
        final ingredient = FeedIngredient.fromJson(testIngredient);

        // Act
        final json = ingredient.toJson();

        // Assert
        expect(json, equals(testIngredient));
      });

      test('should correctly create FeedIngredient from JSON', () {
        // Arrange & Act
        final ingredient = FeedIngredient.fromJson(testIngredient);

        // Assert
        expect(ingredient.id, equals(testIngredient['id']));
        expect(ingredient.name, equals(testIngredient['name']));
        expect(ingredient.weight, equals(testIngredient['weight']));
        expect(ingredient.dmIntake, equals(testIngredient['dmIntake']));
        expect(ingredient.meIntake, equals(testIngredient['meIntake']));
        expect(ingredient.cpIntake, equals(testIngredient['cpIntake']));
        expect(ingredient.ndfIntake, equals(testIngredient['ndfIntake']));
        expect(ingredient.caIntake, equals(testIngredient['caIntake']));
        expect(ingredient.pIntake, equals(testIngredient['pIntake']));
        expect(ingredient.cost, equals(testIngredient['cost']));
        expect(ingredient.isAvailable, equals(testIngredient['isAvailable']));
        expect(ingredient.isFodder, equals(testIngredient['isFodder']));
      });

      test('should handle JSON with default values', () {
        // Arrange
        final minimalJson = {
          'id': 'corn_silage',
          'name': 'Corn Silage',
          'weight': 10.5,
          'dmIntake': 35.0,
          'meIntake': 2.5,
          'cpIntake': 8.0,
          'ndfIntake': 45.0,
          'caIntake': 0.3,
          'pIntake': 0.2,
        };

        // Act
        final ingredient = FeedIngredient.fromJson(minimalJson);

        // Assert - check default values are applied
        expect(ingredient.cost, equals(0.0));
        expect(ingredient.isAvailable, isTrue);
        expect(ingredient.isFodder, isTrue);
      });
    });

    test('copyWith should create a new instance with specified changes', () {
      // Arrange
      final original = FeedIngredient.fromJson(testIngredient);

      // Act - create a copy with modified cost and availability
      final modified = original.copyWith(
        cost: 200.0,
        isAvailable: false,
      );

      // Assert - verify modified properties changed and others remained the same
      expect(modified.cost, equals(200.0));
      expect(modified.isAvailable, isFalse);
      expect(modified.id, equals(original.id));
      expect(modified.name, equals(original.name));
      expect(modified.weight, equals(original.weight));
      expect(modified.dmIntake, equals(original.dmIntake));
      expect(modified.meIntake, equals(original.meIntake));
      expect(modified.cpIntake, equals(original.cpIntake));
      expect(modified.ndfIntake, equals(original.ndfIntake));
      expect(modified.caIntake, equals(original.caIntake));
      expect(modified.pIntake, equals(original.pIntake));
      expect(modified.isFodder, equals(original.isFodder));
    });

    testWidgets('getName should return correct translation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            S.delegate,
          ],
          home: Builder(
            builder: (context) {
              final ingredient = FeedIngredient.fromJson(testIngredient);
              // Verify getName returns the translated name
              expect(ingredient.getName(context), isA<String>());
              return Container(); // Dummy widget
            },
          ),
        ),
      );
    });
  });

  group('FeedFormula', () {
    // Test data representing a complete feed formula
    final testFodder = [
      FeedIngredient(
        id: 'corn_silage',
        name: 'Corn Silage',
        weight: 10.5,
        dmIntake: 35.0,
        meIntake: 2.5,
        cpIntake: 8.0,
        ndfIntake: 45.0,
        caIntake: 0.3,
        pIntake: 0.2,
        cost: 150.0,
        isFodder: true,
      ),
    ];

    final testConcentrate = [
      FeedIngredient(
        id: 'corn_grain',
        name: 'Corn Grain',
        weight: 5.0,
        dmIntake: 88.0,
        meIntake: 3.2,
        cpIntake: 9.0,
        ndfIntake: 12.0,
        caIntake: 0.1,
        pIntake: 0.3,
        cost: 200.0,
        isFodder: false,
      ),
    ];

    test('should create a FeedFormula with fodder and concentrate lists', () {
      // Arrange & Act
      final formula = FeedFormula(
        fodder: testFodder,
        concentrate: testConcentrate,
      );

      // Assert
      expect(formula.fodder, equals(testFodder));
      expect(formula.concentrate, equals(testConcentrate));
    });

    group('JSON Serialization', () {
      test('should correctly convert FeedFormula to JSON', () {
        // Arrange
        final formula = FeedFormula(
          fodder: testFodder,
          concentrate: testConcentrate,
        );

        // Act
        final json = formula.toJson();

        // Assert
        expect(json['fodder'], isA<List>());
        expect(json['concentrate'], isA<List>());
        expect(json['fodder'].length, equals(testFodder.length));
        expect(json['concentrate'].length, equals(testConcentrate.length));
      });

      test('should correctly create FeedFormula from JSON', () {
        // Arrange
        final json = {
          'fodder': testFodder.map((f) => f.toJson()).toList(),
          'concentrate': testConcentrate.map((c) => c.toJson()).toList(),
        };

        // Act
        final formula = FeedFormula.fromJson(json);

        // Assert
        expect(formula.fodder.length, equals(testFodder.length));
        expect(formula.concentrate.length, equals(testConcentrate.length));
        expect(formula.fodder.first.id, equals(testFodder.first.id));
        expect(formula.concentrate.first.id, equals(testConcentrate.first.id));
      });
    });

    test('toString should return a descriptive string', () {
      // Arrange
      final formula = FeedFormula(
        fodder: testFodder,
        concentrate: testConcentrate,
      );

      // Act
      final string = formula.toString();

      // Assert
      expect(string, contains('FeedFormula'));
      expect(string, contains('fodder:'));
      expect(string, contains('concentrate:'));
    });
  });
}
