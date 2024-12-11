import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rationapp/services/persistence_manager.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import 'package:rationapp/models/feed_formula_model.dart';

@GenerateMocks([SharedPreferences])
import 'persistence_manager_test.mocks.dart';

void main() {
  late SharedPrefsService sharedPrefsService;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    SharedPrefsService.prefs = mockSharedPreferences;
    sharedPrefsService = SharedPrefsService();
  });

  group('SharedPrefsService - Cow Characteristics Tests', () {
    test('setCowCharacteristics saves data correctly', () async {
      // Arrange
      final cowCharacteristics = CowCharacteristics(
        liveWeight: 500,
        pregnancyMonths: 5,
        milkVolume: 25.0,
        milkFat: 3.5,
        milkProtein: 3.2,
        lactationStage: 'early',
      );

      const expectedJson =
          '{"liveWeight":500,"pregnancyMonths":5,"milkVolume":25.0,"milkFat":3.5,"milkProtein":3.2,"lactationStage":"early"}';

      when(mockSharedPreferences.setString(
        'cow_characteristics',
        expectedJson,
      )).thenAnswer((_) => Future.value(true));

      // Act
      final result =
          await sharedPrefsService.setCowCharacteristics(cowCharacteristics);

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.setString(
              'cow_characteristics', expectedJson))
          .called(1);
    });

    test('getCowCharacteristics returns null when no data exists', () {
      // Arrange
      const String key = 'cow_characteristics';
      when(mockSharedPreferences.getString(key)).thenReturn(null);

      // Act
      final result = sharedPrefsService.getCowCharacteristics();

      // Assert
      expect(result, isNull);
      verify(mockSharedPreferences.getString(key)).called(1);
      verifyNever(mockSharedPreferences.getString(any));
    });

    test('getCowCharacteristics returns correct data when exists', () {
      when(mockSharedPreferences.getString('cow_characteristics')).thenReturn(
          '{"liveWeight":500,"pregnancyMonths":5,"milkVolume":25.0,"milkFat":3.5,"milkProtein":3.2,"lactationStage":"early"}');

      // Act
      final result = sharedPrefsService.getCowCharacteristics();

      // Assert
      expect(result?.liveWeight, 500);
      expect(result?.pregnancyMonths, 5);
      expect(result?.milkVolume, 25.0);
      expect(result?.milkFat, 3.5);
      expect(result?.milkProtein, 3.2);
      expect(result?.lactationStage, 'early');
    });
  });

  group('SharedPrefsService - Feed Formula Tests', () {
    test('setFeedFormula saves data correctly', () async {
      // Arrange
      final fodder = [
        FeedIngredient(
          id: 'fodder1',
          name: 'Fodder 1',
          weight: 10.0,
          dmIntake: 8.5,
          meIntake: 12.3,
          cpIntake: 0.15,
          ndfIntake: 0.45,
          caIntake: 0.008,
          pIntake: 0.004,
          cost: 5.0,
          isFodder: true,
        )
      ];

      final concentrate = [
        FeedIngredient(
          id: 'conc1',
          name: 'Concentrate 1',
          weight: 5.0,
          dmIntake: 4.2,
          meIntake: 8.1,
          cpIntake: 0.22,
          ndfIntake: 0.28,
          caIntake: 0.006,
          pIntake: 0.003,
          cost: 8.0,
          isFodder: false,
        )
      ];

      final feedFormula = FeedFormula(
        fodder: fodder,
        concentrate: concentrate,
      );

      const String key = 'feed_formula';
      const expectedJson =
          '{"fodder":[{"id":"fodder1","name":"Fodder 1","weight":10.0,"dmIntake":8.5,"meIntake":12.3,"cpIntake":0.15,"ndfIntake":0.45,"caIntake":0.008,"pIntake":0.004,"cost":5.0,"isAvailable":true,"isFodder":true}],"concentrate":[{"id":"conc1","name":"Concentrate 1","weight":5.0,"dmIntake":4.2,"meIntake":8.1,"cpIntake":0.22,"ndfIntake":0.28,"caIntake":0.006,"pIntake":0.003,"cost":8.0,"isAvailable":true,"isFodder":false}]}';

      when(mockSharedPreferences.setString(key, expectedJson))
          .thenAnswer((_) => Future.value(true));

      // Act
      final result = await sharedPrefsService.setFeedFormula(feedFormula);

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.setString(key, expectedJson)).called(1);
      verifyNever(
          mockSharedPreferences.setString(argThat(isNot(equals(key))), any));
    });

    test('getFeedFormula returns null when no data exists', () {
      // Arrange
      const String key = 'feed_formula';
      when(mockSharedPreferences.getString(key)).thenReturn(null);

      // Act
      final result = sharedPrefsService.getFeedFormula();

      // Assert
      expect(result, null);
      verify(mockSharedPreferences.getString(key)).called(1);
    });

    test('getFeedFormula returns correct data when exists', () {
      // Arrange
      const String key = 'feed_formula';
      const jsonString = '''
      {
        "fodder": [{
          "id": "fodder1",
          "name": "Fodder 1",
          "weight": 10.0,
          "dmIntake": 8.5,
          "meIntake": 12.3,
          "cpIntake": 0.15,
          "ndfIntake": 0.45,
          "caIntake": 0.008,
          "pIntake": 0.004,
          "cost": 5.0,
          "isAvailable": true,
          "isFodder": true
        }],
        "concentrate": [{
          "id": "conc1",
          "name": "Concentrate 1",
          "weight": 5.0,
          "dmIntake": 4.2,
          "meIntake": 8.1,
          "cpIntake": 0.22,
          "ndfIntake": 0.28,
          "caIntake": 0.006,
          "pIntake": 0.003,
          "cost": 8.0,
          "isAvailable": true,
          "isFodder": false
        }]
      }
      ''';

      when(mockSharedPreferences.getString(key)).thenReturn(jsonString);

      // Act
      final result = sharedPrefsService.getFeedFormula();

      // Assert
      expect(result?.fodder.length, 1);
      expect(result?.concentrate.length, 1);
      expect(result?.fodder.first.name, 'Fodder 1');
      expect(result?.concentrate.first.name, 'Concentrate 1');
    });
  });

  group('SharedPrefsService - Clear Data Tests', () {
    test('clearCowCharacteristics clears cow data', () async {
      // Arrange
      const String key = 'cow_characteristics';
      when(mockSharedPreferences.remove(key))
          .thenAnswer((_) => Future.value(true));

      // Act
      final result = await SharedPrefsService.clearCowCharacteristics();

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('clearFeedFormula clears formula data', () async {
      // Arrange
      const String key = 'feed_formula';
      when(mockSharedPreferences.remove(key))
          .thenAnswer((_) => Future.value(true));

      // Act
      final result = await SharedPrefsService.clearFeedFormula();

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('clearFeedPrices clears prices data', () async {
      // Arrange
      const String key = 'feed_prices';
      when(mockSharedPreferences.remove(key))
          .thenAnswer((_) => Future.value(true));

      // Act
      final result = await SharedPrefsService.clearFeedPrices();

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.remove(key)).called(1);
    });

    test('clearAll clears all data', () async {
      // Arrange
      when(mockSharedPreferences.clear()).thenAnswer((_) => Future.value(true));

      // Act
      final result = await SharedPrefsService.clearAll();

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.clear()).called(1);
    });
  });

  group('SharedPrefsService - Feed Prices and Availability Tests', () {
    test('setFeedPricesAndAvailability saves data correctly', () async {
      const String key = 'feed_prices';
      // Arrange
      final feedIngredients = [
        FeedIngredient(
          id: 'fodder1',
          name: 'Fodder 1',
          weight: 10.0,
          dmIntake: 8.5,
          meIntake: 12.3,
          cpIntake: 0.15,
          ndfIntake: 0.45,
          caIntake: 0.008,
          pIntake: 0.004,
          cost: 5.0,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'conc1',
          name: 'Concentrate 1',
          weight: 5.0,
          dmIntake: 4.2,
          meIntake: 8.1,
          cpIntake: 0.22,
          ndfIntake: 0.28,
          caIntake: 0.006,
          pIntake: 0.003,
          cost: 8.0,
          isFodder: false,
        )
      ];

      when(mockSharedPreferences.setString(
        key,
        any,
      )).thenAnswer((_) => Future.value(true));

      // Act
      final result = await sharedPrefsService
          .setFeedPricesAndAvailability(feedIngredients);

      // Assert
      expect(result, true);
      verify(mockSharedPreferences.setString(key, any)).called(1);
    });

    test('getFeedPricesAndAvailability returns null when no data exists', () {
      // Arrange
      const String key = 'feed_prices';
      when(mockSharedPreferences.getString(key)).thenReturn(null);

      // Act
      final result = sharedPrefsService.getFeedPricesAndAvailability();

      // Assert
      expect(result, null);
      verify(mockSharedPreferences.getString(key)).called(1);
    });

    test('getFeedPricesAndAvailability returns correct data when exists', () {
      // Arrange
      const String key = 'feed_prices';
      const jsonString = '''
      [{
        "id": "fodder1",
        "name": "Fodder 1",
        "weight": 10.0,
        "dmIntake": 8.5,
        "meIntake": 12.3,
        "cpIntake": 0.15,
        "ndfIntake": 0.45,
        "caIntake": 0.008,
        "pIntake": 0.004,
        "cost": 5.0,
        "isAvailable": true,
        "isFodder": true
      }]
      ''';

      when(mockSharedPreferences.getString(key)).thenReturn(jsonString);

      // Act
      final result = sharedPrefsService.getFeedPricesAndAvailability();

      // Assert
      expect(result?.length, 1);
      expect(result?.first.name, 'Fodder 1');
      expect(result?.first.cost, 5.0);
      expect(result?.first.isAvailable, true);
    });
  });
}
