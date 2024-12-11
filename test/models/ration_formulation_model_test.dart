import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/models/ration_formulation_model.dart';

void main() {
  group('RationFormulation', () {
    const testIngredient = 'Corn Silage';
    const testFreshFeedIntake = 25.5; // kg/day of fresh feed
    const testDmIntake = 8.925; // kg/day of dry matter (35% of fresh feed)

    test('should create a RationFormulation object with all properties', () {
      final ration = RationFormulation(
        ingredient: testIngredient,
        freshFeedIntake: testFreshFeedIntake,
        dmIntake: testDmIntake,
      );

      // We verify each property individually for clarity in case of failures
      expect(ration.ingredient, equals(testIngredient),
          reason: 'Ingredient name should be stored exactly as provided');
      expect(ration.freshFeedIntake, equals(testFreshFeedIntake),
          reason: 'Fresh feed intake should be stored exactly as provided');
      expect(ration.dmIntake, equals(testDmIntake),
          reason: 'Dry matter intake should be stored exactly as provided');
    });

    group('JSON Serialization', () {
      test('should correctly convert RationFormulation to JSON', () {
        // First, we create a complete ration formulation object
        final ration = RationFormulation(
          ingredient: testIngredient,
          freshFeedIntake: testFreshFeedIntake,
          dmIntake: testDmIntake,
        );

        // Then we convert it to JSON and verify the structure
        final json = ration.toJson();

        // We verify each field is correctly serialized
        expect(json['ingredient'], equals(testIngredient),
            reason: 'Ingredient should be correctly serialized to JSON');
        expect(json['freshFeedIntake'], equals(testFreshFeedIntake),
            reason: 'Fresh feed intake should be correctly serialized to JSON');
        expect(json['dmIntake'], equals(testDmIntake),
            reason: 'Dry matter intake should be correctly serialized to JSON');
      });

      test('should correctly create RationFormulation from JSON', () {
        // We start with a JSON representation of a ration formulation
        final json = {
          'ingredient': testIngredient,
          'freshFeedIntake': testFreshFeedIntake,
          'dmIntake': testDmIntake,
        };

        // We create a RationFormulation object from this JSON
        final ration = RationFormulation.fromJson(json);

        // Then verify all properties were correctly deserialized
        expect(ration.ingredient, equals(testIngredient),
            reason: 'Ingredient should be correctly deserialized from JSON');
        expect(ration.freshFeedIntake, equals(testFreshFeedIntake),
            reason:
                'Fresh feed intake should be correctly deserialized from JSON');
        expect(ration.dmIntake, equals(testDmIntake),
            reason:
                'Dry matter intake should be correctly deserialized from JSON');
      });

      test('should handle different numeric precisions in JSON', () {
        // Test with values having different decimal places
        final jsonWithPrecision = {
          'ingredient': 'Alfalfa Hay',
          'freshFeedIntake': 15.333333, // More decimal places
          'dmIntake': 13.1, // Fewer decimal places
        };

        final ration = RationFormulation.fromJson(jsonWithPrecision);

        // Verify that numeric precision is maintained
        expect(ration.freshFeedIntake, equals(15.333333),
            reason: 'Should preserve original precision for fresh feed intake');
        expect(ration.dmIntake, equals(13.1),
            reason: 'Should preserve original precision for dry matter intake');
      });

      test('should handle missing or null values in JSON appropriately', () {
        // We create a JSON object with missing values
        final incompleteJson = {'ingredient': testIngredient};

        // The fromJson constructor should throw when required fields are missing
        expect(() => RationFormulation.fromJson(incompleteJson),
            throwsA(isA<TypeError>()),
            reason: 'Should throw when required numeric fields are missing');
      });
    });

    group('Value Validation', () {
      test('should handle zero values for numeric fields', () {
        // Create a ration with zero intake values
        final zeroRation = RationFormulation(
          ingredient: testIngredient,
          freshFeedIntake: 0,
          dmIntake: 0,
        );

        // Verify that zero values are stored correctly
        expect(zeroRation.freshFeedIntake, equals(0),
            reason: 'Should accept zero for fresh feed intake');
        expect(zeroRation.dmIntake, equals(0),
            reason: 'Should accept zero for dry matter intake');
      });

      test('should handle large numeric values', () {
        // Create a ration with large intake values
        final largeRation = RationFormulation(
          ingredient: testIngredient,
          freshFeedIntake: 1000.0,
          dmIntake: 500.0,
        );

        // Verify that large values are stored correctly
        expect(largeRation.freshFeedIntake, equals(1000.0),
            reason: 'Should handle large fresh feed intake values');
        expect(largeRation.dmIntake, equals(500.0),
            reason: 'Should handle large dry matter intake values');
      });

      test('should handle empty string for ingredient', () {
        // Create a ration with an empty ingredient name
        final emptyIngredientRation = RationFormulation(
          ingredient: '',
          freshFeedIntake: testFreshFeedIntake,
          dmIntake: testDmIntake,
        );

        // Verify that empty string is stored correctly
        expect(emptyIngredientRation.ingredient, equals(''),
            reason: 'Should accept empty string for ingredient');
      });
    });
  });
}
