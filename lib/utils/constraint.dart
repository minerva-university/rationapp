// src/constraint.dart
import 'types.dart';

///
/// Returns a `Constraint` that specifies something should be less than or equal to `value`.
/// Equivalent to `{ max: value }`.
///
Constraint lessEq(double value) {
  return Constraint(max: value);
}

///
/// Returns a `Constraint` that specifies something should be greater than or equal to `value`.
/// Equivalent to `{ min: value }`.
///
Constraint greaterEq(double value) {
  return Constraint(min: value);
}

///
/// Returns a `Constraint` that specifies something should be exactly equal to `value`.
/// Equivalent to `{ equal: value }`.
///
Constraint equalTo(double value) {
  return Constraint(equal: value);
}

///
/// Returns a `Constraint` that specifies something should be between `lower` and `upper` (both inclusive).
/// Equivalent to `{ min: lower, max: upper }`.
///
Constraint inRange(double lower, double upper) {
  return Constraint(min: lower, max: upper);
}
