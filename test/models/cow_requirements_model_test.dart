import 'package:flutter_test/flutter_test.dart';
import 'package:rationapp/models/cow_requirements_model.dart';

void main() {
  const testDmIntake = 16.5;
  const testMeIntake = 179.96;
  const testCpIntake = 0.16;
  const testNdfIntake = 0.40;
  const testCaIntake = 0.008;
  const testPIntake = 0.004;
  const testConcentrateIntake = 0.60;

  group('CowRequirements', () {
    test('should create a CowRequirements object with provided values', () {
      // Arrange & Act
      final cowRequirements = CowRequirements(
        dmIntake: testDmIntake,
        meIntake: testMeIntake,
        cpIntake: testCpIntake,
        ndfIntake: testNdfIntake,
        caIntake: testCaIntake,
        pIntake: testPIntake,
        concentrateIntake: testConcentrateIntake,
      );

      // Assert - verifying that all properties are correctly set
      expect(cowRequirements.dmIntake, equals(testDmIntake));
      expect(cowRequirements.meIntake, equals(testMeIntake));
      expect(cowRequirements.cpIntake, equals(testCpIntake));
      expect(cowRequirements.ndfIntake, equals(testNdfIntake));
      expect(cowRequirements.caIntake, equals(testCaIntake));
      expect(cowRequirements.pIntake, equals(testPIntake));
      expect(cowRequirements.concentrateIntake, equals(testConcentrateIntake));
    });

    group('JSON Serialization', () {
      test('should correctly convert CowRequirements to JSON', () {
        // Arrange
        final cowRequirements = CowRequirements(
          dmIntake: testDmIntake,
          meIntake: testMeIntake,
          cpIntake: testCpIntake,
          ndfIntake: testNdfIntake,
          caIntake: testCaIntake,
          pIntake: testPIntake,
          concentrateIntake: testConcentrateIntake,
        );

        // Act
        final json = cowRequirements.toJson();

        // Assert - verifying that all values are correctly serialized
        expect(json['dmIntake'], equals(testDmIntake));
        expect(json['meIntake'], equals(testMeIntake));
        expect(json['cpIntake'], equals(testCpIntake));
        expect(json['ndfIntake'], equals(testNdfIntake));
        expect(json['caIntake'], equals(testCaIntake));
        expect(json['pIntake'], equals(testPIntake));
        expect(json['concentrateIntake'], equals(testConcentrateIntake));
      });

      test('should correctly create CowRequirements from JSON', () {
        // Arrange
        final json = {
          'dmIntake': testDmIntake,
          'meIntake': testMeIntake,
          'cpIntake': testCpIntake,
          'ndfIntake': testNdfIntake,
          'caIntake': testCaIntake,
          'pIntake': testPIntake,
          'concentrateIntake': testConcentrateIntake,
        };

        // Act
        final cowRequirements = CowRequirements.fromJson(json);

        // Assert - verifying that all values are correctly deserialized
        expect(cowRequirements.dmIntake, equals(testDmIntake));
        expect(cowRequirements.meIntake, equals(testMeIntake));
        expect(cowRequirements.cpIntake, equals(testCpIntake));
        expect(cowRequirements.ndfIntake, equals(testNdfIntake));
        expect(cowRequirements.caIntake, equals(testCaIntake));
        expect(cowRequirements.pIntake, equals(testPIntake));
        expect(
            cowRequirements.concentrateIntake, equals(testConcentrateIntake));
      });

      test('should handle JSON with missing values', () {
        // Arrange
        final incompleteJson = {
          'dmIntake': testDmIntake,
          // meIntake is missing
          'cpIntake': testCpIntake,
          // other fields missing
        };

        // Act & Assert
        expect(
          () => CowRequirements.fromJson(incompleteJson),
          throwsA(isA<TypeError>()),
          reason: 'Should throw when required fields are missing',
        );
      });
    });

    group('Validation Tests', () {
      test('should handle zero values', () {
        // Arrange & Act
        final cowRequirements = CowRequirements(
          dmIntake: 0,
          meIntake: 0,
          cpIntake: 0,
          ndfIntake: 0,
          caIntake: 0,
          pIntake: 0,
          concentrateIntake: 0,
        );

        // Assert
        expect(cowRequirements.dmIntake, equals(0));
        expect(cowRequirements.meIntake, equals(0));
        expect(cowRequirements.cpIntake, equals(0));
        expect(cowRequirements.ndfIntake, equals(0));
        expect(cowRequirements.caIntake, equals(0));
        expect(cowRequirements.pIntake, equals(0));
        expect(cowRequirements.concentrateIntake, equals(0));
      });

      test('should handle large values', () {
        // Arrange
        final largeValues = CowRequirements(
          dmIntake: 1000.0,
          meIntake: 1000.0,
          cpIntake: 1.0,
          ndfIntake: 1.0,
          caIntake: 1.0,
          pIntake: 1.0,
          concentrateIntake: 1.0,
        );

        // Assert
        expect(largeValues.dmIntake, equals(1000.0));
        expect(largeValues.meIntake, equals(1000.0));
        expect(largeValues.cpIntake, equals(1.0));
        expect(largeValues.ndfIntake, equals(1.0));
        expect(largeValues.caIntake, equals(1.0));
        expect(largeValues.pIntake, equals(1.0));
        expect(largeValues.concentrateIntake, equals(1.0));
      });

      test('should handle decimal precision', () {
        // Arrange
        final preciseValues = CowRequirements(
          dmIntake: 16.543,
          meIntake: 179.962,
          cpIntake: 0.1634,
          ndfIntake: 0.4021,
          caIntake: 0.0082,
          pIntake: 0.0041,
          concentrateIntake: 0.6043,
        );

        // Act
        final json = preciseValues.toJson();
        final reconstructed = CowRequirements.fromJson(json);

        // Assert - verifying that precision is maintained through serialization
        expect(reconstructed.dmIntake, equals(16.543));
        expect(reconstructed.meIntake, equals(179.962));
        expect(reconstructed.cpIntake, equals(0.1634));
        expect(reconstructed.ndfIntake, equals(0.4021));
        expect(reconstructed.caIntake, equals(0.0082));
        expect(reconstructed.pIntake, equals(0.0041));
        expect(reconstructed.concentrateIntake, equals(0.6043));
      });
    });
  });
}
