import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rationapp/feed_state.dart';
import 'package:rationapp/models/feed_formula_model.dart';
import 'package:rationapp/constants/feed_constants.dart';
import 'package:rationapp/generated/l10n.dart';

@GenerateMocks([FeedState])
import 'feed_constants_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FeedConstants feedConstants;
  late MockFeedState mockFeedState;

  setUp(() {
    feedConstants = FeedConstants();
    mockFeedState = MockFeedState();
  });

  group('getFodderOptions', () {
    testWidgets('should return copy of available fodder items',
        (WidgetTester tester) async {
      // Arrange
      final mockFodderItems = [
        FeedIngredient(
          id: 'fodder1',
          name: 'Fodder 1',
          weight: 100,
          dmIntake: 90,
          meIntake: 2.5,
          cpIntake: 14,
          ndfIntake: 55,
          caIntake: 0.5,
          pIntake: 0.3,
          cost: 10,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodder2',
          name: 'Fodder 2',
          weight: 150,
          dmIntake: 85,
          meIntake: 2.3,
          cpIntake: 12,
          ndfIntake: 60,
          caIntake: 0.4,
          pIntake: 0.25,
          cost: 15,
          isFodder: true,
        ),
      ];

      when(mockFeedState.availableFodderItems).thenReturn(mockFodderItems);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Builder(
              builder: (BuildContext context) {
                return InheritedProvider<FeedState>.value(
                  value: mockFeedState,
                  child: Builder(
                    builder: (BuildContext context) {
                      final result = feedConstants.getFodderOptions(context);

                      // Perform assertions inside the builder
                      expect(result.length, mockFodderItems.length);
                      expect(result,
                          isNot(same(mockFodderItems))); // Verify it's a copy

                      // Verify items match
                      for (int i = 0; i < result.length; i++) {
                        expect(result[i].id, mockFodderItems[i].id);
                        expect(result[i].name, mockFodderItems[i].name);
                        expect(result[i].weight, mockFodderItems[i].weight);
                        expect(result[i].isFodder, true);
                      }

                      return Container(); // Return any widget
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
    });

    testWidgets('should return empty list when no fodder items available',
        (WidgetTester tester) async {
      // Arrange
      when(mockFeedState.availableFodderItems).thenReturn([]);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: InheritedProvider<FeedState>.value(
              value: mockFeedState,
              child: Builder(
                builder: (BuildContext context) {
                  final result = feedConstants.getFodderOptions(context);
                  expect(result, isEmpty);
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });
  });

  group('getConcentrateOptions', () {
    testWidgets('should return copy of available concentrate items',
        (WidgetTester tester) async {
      // Arrange
      final mockConcentrateItems = [
        FeedIngredient(
          id: 'concentrate1',
          name: 'Concentrate 1',
          weight: 50,
          dmIntake: 95,
          meIntake: 3.0,
          cpIntake: 18,
          ndfIntake: 25,
          caIntake: 0.8,
          pIntake: 0.5,
          cost: 20,
          isFodder: false,
        ),
      ];

      when(mockFeedState.availableConcentrateItems)
          .thenReturn(mockConcentrateItems);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: InheritedProvider<FeedState>.value(
              value: mockFeedState,
              child: Builder(
                builder: (BuildContext context) {
                  final result = feedConstants.getConcentrateOptions(context);

                  expect(result.length, mockConcentrateItems.length);
                  expect(result,
                      isNot(same(mockConcentrateItems))); // Verify it's a copy

                  // Verify items match
                  for (int i = 0; i < result.length; i++) {
                    expect(result[i].id, mockConcentrateItems[i].id);
                    expect(result[i].name, mockConcentrateItems[i].name);
                    expect(result[i].weight, mockConcentrateItems[i].weight);
                    expect(result[i].isFodder, false);
                  }

                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('should return empty list when no concentrate items available',
        (WidgetTester tester) async {
      when(mockFeedState.availableConcentrateItems).thenReturn([]);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: InheritedProvider<FeedState>.value(
              value: mockFeedState,
              child: Builder(
                builder: (BuildContext context) {
                  final result = feedConstants.getConcentrateOptions(context);
                  expect(result, isEmpty);
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });
  });

  group('getFeedIngredientLabel', () {
    testWidgets('should return correct label for fodder item',
        (WidgetTester tester) async {
      // Arrange
      final mockFodderItem = FeedIngredient(
        id: 'fodder1',
        name: 'Fodder 1',
        weight: 100,
        dmIntake: 90,
        meIntake: 2.5,
        cpIntake: 14,
        ndfIntake: 55,
        caIntake: 0.5,
        pIntake: 0.3,
        cost: 10,
        isFodder: true,
      );

      when(mockFeedState.fodderItems).thenReturn([mockFodderItem]);
      when(mockFeedState.concentrateItems).thenReturn([]);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            S.delegate,
          ],
          home: Material(
            child: InheritedProvider<FeedState>.value(
              value: mockFeedState,
              child: Builder(
                builder: (BuildContext context) {
                  final result =
                      feedConstants.getFeedIngredientLabel(context, 'fodder1');
                  expect(result, 'Fodder 1');
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });

    testWidgets('should throw StateError when item not found',
        (WidgetTester tester) async {
      when(mockFeedState.fodderItems).thenReturn([]);
      when(mockFeedState.concentrateItems).thenReturn([]);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: InheritedProvider<FeedState>.value(
              value: mockFeedState,
              child: Builder(
                builder: (BuildContext context) {
                  expect(
                    () => feedConstants.getFeedIngredientLabel(
                        context, 'nonexistent'),
                    throwsStateError,
                  );
                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    });
  });
}
