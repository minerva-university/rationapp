import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';

void main() {
  // Test values that we'll use across multiple tests
  const testLiveWeight = 500;
  const testPregnancyMonths = 7;
  const testMilkVolume = 25.5;
  const testMilkFat = 3.8;
  const testMilkProtein = 3.2;
  const testLactationStage = 'early_lactation';

  group('CowCharacteristics', () {
    test('should create a CowCharacteristics object with provided values', () {
      // Arrange & Act
      final cowCharacteristics = CowCharacteristics(
        liveWeight: testLiveWeight,
        pregnancyMonths: testPregnancyMonths,
        milkVolume: testMilkVolume,
        milkFat: testMilkFat,
        milkProtein: testMilkProtein,
        lactationStage: testLactationStage,
      );

      // Assert
      expect(cowCharacteristics.liveWeight, equals(testLiveWeight));
      expect(cowCharacteristics.pregnancyMonths, equals(testPregnancyMonths));
      expect(cowCharacteristics.milkVolume, equals(testMilkVolume));
      expect(cowCharacteristics.milkFat, equals(testMilkFat));
      expect(cowCharacteristics.milkProtein, equals(testMilkProtein));
      expect(cowCharacteristics.lactationStage, equals(testLactationStage));
    });

    group('JSON Serialization', () {
      test('should correctly convert CowCharacteristics to JSON', () {
        // Arrange
        final cowCharacteristics = CowCharacteristics(
          liveWeight: testLiveWeight,
          pregnancyMonths: testPregnancyMonths,
          milkVolume: testMilkVolume,
          milkFat: testMilkFat,
          milkProtein: testMilkProtein,
          lactationStage: testLactationStage,
        );

        // Act
        final json = cowCharacteristics.toJson();

        // Assert
        expect(json, {
          'liveWeight': testLiveWeight,
          'pregnancyMonths': testPregnancyMonths,
          'milkVolume': testMilkVolume,
          'milkFat': testMilkFat,
          'milkProtein': testMilkProtein,
          'lactationStage': testLactationStage,
        });
      });

      test('should correctly create CowCharacteristics from JSON', () {
        // Arrange
        final json = {
          'liveWeight': testLiveWeight,
          'pregnancyMonths': testPregnancyMonths,
          'milkVolume': testMilkVolume,
          'milkFat': testMilkFat,
          'milkProtein': testMilkProtein,
          'lactationStage': testLactationStage,
        };

        // Act
        final cowCharacteristics = CowCharacteristics.fromJson(json);

        // Assert
        expect(cowCharacteristics.liveWeight, equals(testLiveWeight));
        expect(cowCharacteristics.pregnancyMonths, equals(testPregnancyMonths));
        expect(cowCharacteristics.milkVolume, equals(testMilkVolume));
        expect(cowCharacteristics.milkFat, equals(testMilkFat));
        expect(cowCharacteristics.milkProtein, equals(testMilkProtein));
        expect(cowCharacteristics.lactationStage, equals(testLactationStage));
      });

      test('should handle JSON with null values', () {
        // Arrange
        final json = {
          'liveWeight': null,
          'pregnancyMonths': null,
          'milkVolume': null,
          'milkFat': null,
          'milkProtein': null,
          'lactationStage': null,
        };

        // Act & Assert
        expect(
          () => CowCharacteristics.fromJson(json),
          throwsA(isA<TypeError>()), // or another appropriate error type
          reason: 'Should throw an error when required fields are null',
        );
      });
    });

    test('should correctly implement toString method', () {
      // Arrange
      final cowCharacteristics = CowCharacteristics(
        liveWeight: testLiveWeight,
        pregnancyMonths: testPregnancyMonths,
        milkVolume: testMilkVolume,
        milkFat: testMilkFat,
        milkProtein: testMilkProtein,
        lactationStage: testLactationStage,
      );

      // Act
      final string = cowCharacteristics.toString();

      // Assert
      expect(
        string,
        'liveWeight: $testLiveWeight, '
        'pregnancyMonths: $testPregnancyMonths, '
        'milkVolume: $testMilkVolume, '
        'milkFat: $testMilkFat, '
        'milkProtein: $testMilkProtein, '
        'lactationStage: $testLactationStage',
      );
    });

    test('should handle extreme values within reasonable bounds', () {
      // Arrange & Act & Assert
      expect(
        () => CowCharacteristics(
          liveWeight: 100000, // Unreasonably high weight
          pregnancyMonths: testPregnancyMonths,
          milkVolume: testMilkVolume,
          milkFat: testMilkFat,
          milkProtein: testMilkProtein,
          lactationStage: testLactationStage,
        ),
        returnsNormally,
        reason: 'Should accept any numeric value for liveWeight',
      );

      expect(
        () => CowCharacteristics(
          liveWeight: testLiveWeight,
          pregnancyMonths: 15, // Invalid pregnancy months
          milkVolume: testMilkVolume,
          milkFat: testMilkFat,
          milkProtein: testMilkProtein,
          lactationStage: testLactationStage,
        ),
        returnsNormally,
        reason: 'Should accept any numeric value for pregnancyMonths',
      );
    });
  });
}
