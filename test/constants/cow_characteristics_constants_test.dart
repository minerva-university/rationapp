import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rationapp/generated/l10n.dart';
import 'package:rationapp/constants/cow_characteristics_constants.dart';

// Generate mocks
@GenerateMocks([BuildContext])
class MockS extends Mock implements S {
  @override
  String get lactationStageDry => 'Dry';

  @override
  String get lactationStageEarlyLactation => 'Early Lactation';

  @override
  String get lactationStageMidLactation => 'Mid Lactation';

  @override
  String get lactationStageLateLactation => 'Late Lactation';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Static Options Lists', () {
    test(
        'liveWeightOptions should have correct values and be in ascending order',
        () {
      expect(CowCharacteristicsConstants.liveWeightOptions.length, 21);
      expect(CowCharacteristicsConstants.liveWeightOptions.first, '100');
      expect(CowCharacteristicsConstants.liveWeightOptions.last, '600');

      // Test if list is in ascending order
      List<int> weights = CowCharacteristicsConstants.liveWeightOptions
          .map((s) => int.parse(s))
          .toList();
      for (int i = 0; i < weights.length - 1; i++) {
        expect(weights[i] < weights[i + 1], true);
      }
    });

    test('pregnancyOptions should have correct values and range', () {
      expect(CowCharacteristicsConstants.pregnancyOptions.length, 10);
      expect(CowCharacteristicsConstants.pregnancyOptions.first, '0');
      expect(CowCharacteristicsConstants.pregnancyOptions.last, '9');

      // Test if list is sequential
      for (int i = 0;
          i < CowCharacteristicsConstants.pregnancyOptions.length;
          i++) {
        expect(CowCharacteristicsConstants.pregnancyOptions[i], i.toString());
      }
    });

    test('milkFatOptions should have correct values and be in ascending order',
        () {
      expect(CowCharacteristicsConstants.milkFatOptions.length, 23);
      expect(CowCharacteristicsConstants.milkFatOptions.first, '3.0');
      expect(CowCharacteristicsConstants.milkFatOptions.last, '5.2');

      // Test if list is in ascending order
      List<double> fatValues = CowCharacteristicsConstants.milkFatOptions
          .map((s) => double.parse(s))
          .toList();
      for (int i = 0; i < fatValues.length - 1; i++) {
        expect(fatValues[i] < fatValues[i + 1], true);
      }
    });

    test(
        'milkProteinOptions should have correct values and be in ascending order',
        () {
      expect(CowCharacteristicsConstants.milkProteinOptions.length, 11);
      expect(CowCharacteristicsConstants.milkProteinOptions.first, '2.6');
      expect(CowCharacteristicsConstants.milkProteinOptions.last, '3.6');

      // Test if list is in ascending order
      List<double> proteinValues = CowCharacteristicsConstants
          .milkProteinOptions
          .map((s) => double.parse(s))
          .toList();
      for (int i = 0; i < proteinValues.length - 1; i++) {
        expect(proteinValues[i] < proteinValues[i + 1], true);
      }
    });
  });

  group('Lactation Stage Handling', () {
    testWidgets('should handle lactation stages correctly',
        (WidgetTester tester) async {
      final mockS = MockS();
      late CowCharacteristicsConstants constants;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: [
            _MockLocalizationsDelegate(mockS),
          ],
          home: Builder(
            builder: (BuildContext context) {
              constants = CowCharacteristicsConstants(context);
              return Container();
            },
          ),
        ),
      );

      // Wait for widget to be fully rendered
      await tester.pumpAndSettle();

      // Test lactationStageOptions
      final options = constants.lactationStageOptions;
      expect(options.length, 4);
      expect(options.contains(mockS.lactationStageDry), true);
      expect(options.contains(mockS.lactationStageEarlyLactation), true);
      expect(options.contains(mockS.lactationStageMidLactation), true);
      expect(options.contains(mockS.lactationStageLateLactation), true);

      // Test getLactationStageKey
      expect(constants.getLactationStageKey(mockS.lactationStageDry), 'dry');
      expect(constants.getLactationStageKey(mockS.lactationStageEarlyLactation),
          'early');
      expect(constants.getLactationStageKey(mockS.lactationStageMidLactation),
          'mid');
      expect(constants.getLactationStageKey(mockS.lactationStageLateLactation),
          'late');
      expect(constants.getLactationStageKey('invalid'), '');

      // Test getLactationStageLabel
      expect(constants.getLactationStageLabel('dry'), mockS.lactationStageDry);
      expect(constants.getLactationStageLabel('early'),
          mockS.lactationStageEarlyLactation);
      expect(constants.getLactationStageLabel('mid'),
          mockS.lactationStageMidLactation);
      expect(constants.getLactationStageLabel('late'),
          mockS.lactationStageLateLactation);
      expect(constants.getLactationStageLabel('invalid'), '');
    });
  });
}

// Mock Localizations Delegate
class _MockLocalizationsDelegate extends LocalizationsDelegate<S> {
  final S mockS;

  const _MockLocalizationsDelegate(this.mockS);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<S> load(Locale locale) async => mockS;

  @override
  bool shouldReload(_MockLocalizationsDelegate old) => false;
}
