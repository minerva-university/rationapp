// Mocks generated by Mockito 5.4.4 from annotations
// in rationapp/test/feed_state_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter/material.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rationapp/data/nutrition_tables.dart' as _i7;
import 'package:rationapp/models/cow_characteristics_model.dart' as _i5;
import 'package:rationapp/models/feed_formula_model.dart' as _i6;
import 'package:rationapp/services/persistence_manager.dart' as _i3;

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

class _FakeBuildContext_0 extends _i1.SmartFake implements _i2.BuildContext {
  _FakeBuildContext_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SharedPrefsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPrefsService extends _i1.Mock
    implements _i3.SharedPrefsService {
  MockSharedPrefsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> setCowCharacteristics(
          _i5.CowCharacteristics? cowCharacteristics) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCowCharacteristics,
          [cowCharacteristics],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> setFeedPricesAndAvailability(
          List<_i6.FeedIngredient>? feedIngredients) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFeedPricesAndAvailability,
          [feedIngredients],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [NutritionTables].
///
/// See the documentation for Mockito's code generation for more information.
class MockNutritionTables extends _i1.Mock implements _i7.NutritionTables {
  MockNutritionTables() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.BuildContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeBuildContext_0(
          this,
          Invocation.getter(#context),
        ),
      ) as _i2.BuildContext);

  @override
  List<Map<String, dynamic>> get lactationStageRequirements =>
      (super.noSuchMethod(
        Invocation.getter(#lactationStageRequirements),
        returnValue: <Map<String, dynamic>>[],
      ) as List<Map<String, dynamic>>);

  @override
  List<_i6.FeedIngredient> get concentrateItems => (super.noSuchMethod(
        Invocation.getter(#concentrateItems),
        returnValue: <_i6.FeedIngredient>[],
      ) as List<_i6.FeedIngredient>);

  @override
  List<_i6.FeedIngredient> get fodderItems => (super.noSuchMethod(
        Invocation.getter(#fodderItems),
        returnValue: <_i6.FeedIngredient>[],
      ) as List<_i6.FeedIngredient>);
}