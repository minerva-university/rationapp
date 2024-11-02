// Mocks generated by Mockito 5.4.4 from annotations
// in rationapp/test/screens/cow_characteristics_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter/material.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rationapp/models/cow_characteristics_model.dart' as _i4;
import 'package:rationapp/models/feed_formula_model.dart' as _i5;
import 'package:rationapp/services/persistence_manager.dart' as _i2;
import 'package:rationapp/utils/cow_requirements_calculator.dart' as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SharedPrefsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPrefsService extends _i1.Mock
    implements _i2.SharedPrefsService {
  MockSharedPrefsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> setCowCharacteristics(
          _i4.CowCharacteristics? cowCharacteristics) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCowCharacteristics,
          [cowCharacteristics],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<bool> setFeedPricesAndAvailability(
          List<_i5.FeedIngredient>? feedIngredients) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFeedPricesAndAvailability,
          [feedIngredients],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [CowRequirementsCalculator].
///
/// See the documentation for Mockito's code generation for more information.
class MockCowRequirementsCalculator extends _i1.Mock
    implements _i6.CowRequirementsCalculator {
  MockCowRequirementsCalculator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void calculateCowRequirements(
    _i7.BuildContext? context,
    _i7.TextEditingController? liveWeightController,
    _i7.TextEditingController? pregnancyController,
    _i7.TextEditingController? volumeController,
    _i7.TextEditingController? milkFatController,
    _i7.TextEditingController? milkProteinController,
    String? lactationStageId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #calculateCowRequirements,
          [
            context,
            liveWeightController,
            pregnancyController,
            volumeController,
            milkFatController,
            milkProteinController,
            lactationStageId,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
