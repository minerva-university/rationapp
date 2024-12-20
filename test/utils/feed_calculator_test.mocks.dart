// Mocks generated by Mockito 5.4.4 from annotations
// in rationapp/test/utils/feed_calculator_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i6;

import 'package:flutter/material.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rationapp/feed_state.dart' as _i3;
import 'package:rationapp/models/feed_formula_model.dart' as _i4;
import 'package:rationapp/services/persistence_manager.dart' as _i2;

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

class _FakeSharedPrefsService_0 extends _i1.SmartFake
    implements _i2.SharedPrefsService {
  _FakeSharedPrefsService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FeedState].
///
/// See the documentation for Mockito's code generation for more information.
class MockFeedState extends _i1.Mock implements _i3.FeedState {
  MockFeedState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.FeedIngredient> get fodderItems => (super.noSuchMethod(
        Invocation.getter(#fodderItems),
        returnValue: <_i4.FeedIngredient>[],
      ) as List<_i4.FeedIngredient>);

  @override
  set fodderItems(List<_i4.FeedIngredient>? _fodderItems) => super.noSuchMethod(
        Invocation.setter(
          #fodderItems,
          _fodderItems,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i4.FeedIngredient> get concentrateItems => (super.noSuchMethod(
        Invocation.getter(#concentrateItems),
        returnValue: <_i4.FeedIngredient>[],
      ) as List<_i4.FeedIngredient>);

  @override
  set concentrateItems(List<_i4.FeedIngredient>? _concentrateItems) =>
      super.noSuchMethod(
        Invocation.setter(
          #concentrateItems,
          _concentrateItems,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.SharedPrefsService get sharedPrefsService => (super.noSuchMethod(
        Invocation.getter(#sharedPrefsService),
        returnValue: _FakeSharedPrefsService_0(
          this,
          Invocation.getter(#sharedPrefsService),
        ),
      ) as _i2.SharedPrefsService);

  @override
  set sharedPrefsService(_i2.SharedPrefsService? _sharedPrefsService) =>
      super.noSuchMethod(
        Invocation.setter(
          #sharedPrefsService,
          _sharedPrefsService,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i4.FeedIngredient> get availableFodderItems => (super.noSuchMethod(
        Invocation.getter(#availableFodderItems),
        returnValue: <_i4.FeedIngredient>[],
      ) as List<_i4.FeedIngredient>);

  @override
  List<_i4.FeedIngredient> get availableConcentrateItems => (super.noSuchMethod(
        Invocation.getter(#availableConcentrateItems),
        returnValue: <_i4.FeedIngredient>[],
      ) as List<_i4.FeedIngredient>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void initializeWithContext(_i5.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #initializeWithContext,
          [context],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void updateIngredient(_i4.FeedIngredient? updatedIngredient) =>
      super.noSuchMethod(
        Invocation.method(
          #updateIngredient,
          [updatedIngredient],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void loadSavedPrices() => super.noSuchMethod(
        Invocation.method(
          #loadSavedPrices,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
