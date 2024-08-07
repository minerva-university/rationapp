// src/tableau.dart

import 'dart:typed_data';
import 'types.dart';

// The tableau representing the problem.
// matrix is a 2D matrix (duh) represented as a 1D array.
// The first row, 0, is the objective row.
// The first column, 0, is the RHS column.
// Positions are numbered starting at the first column and ending at the last row.
// Thus, the position of the variable in the first row is width.
class Tableau {
  final Float64List matrix;
  final int width;
  final int height;
  final Int32List positionOfVariable;
  final Int32List variableAtPosition;

  Tableau({
    required this.matrix,
    required this.width,
    required this.height,
    required this.positionOfVariable,
    required this.variableAtPosition,
  });
}

double index(Tableau tableau, int row, int col) {
  return tableau.matrix[row * tableau.width + col];
}

void update(Tableau tableau, int row, int col, double value) {
  tableau.matrix[row * tableau.width + col] = value;
}

typedef Variables<VarKey, ConKey>
    = List<MapEntry<VarKey, Coefficients<ConKey>>>;

// A tableau with some additional context.
class TableauModel<VariableKey, ConstraintKey> {
  final Tableau tableau;
  final double sign;
  final Variables<VariableKey, ConstraintKey> variables;
  final List<int> integers;

  TableauModel({
    required this.tableau,
    required this.sign,
    required this.variables,
    required this.integers,
  });
}

// Iterable<MapEntry<K, V>> convertToIterable<K, V>(
//   dynamic seq,
// ) {
//   if (seq is Iterable<MapEntry<K, V>>) {
//     return seq;
//   } else if (seq is Map<K, V>) {
//     return seq.entries;
//   } else {
//     throw ArgumentError('Unsupported type for conversion to iterable');
//   }
// }

List<MapEntry<K, V>> convertToList<K, V>(
  dynamic seq,
) {
  if (seq is List<MapEntry<K, V>>) {
    return seq;
  } else if (seq is Map<K, V>) {
    return seq.entries.toList();
  } else {
    throw ArgumentError('Unsupported type for conversion to iterable');
  }
}

Set<T> convertToSet<T>(dynamic set) {
  if (set == true) {
    return Set<T>.from([true as T]);
  } else if (set == false) {
    return Set<T>();
  } else if (set is Set<T>) {
    return set;
  } else if (set is Iterable<T>) {
    return Set<T>.from(set);
  } else {
    throw ArgumentError('Unsupported type for conversion to set');
  }
}

TableauModel<VarKey, ConKey> tableauModel<VarKey, ConKey>(
  Model<VarKey, ConKey> model,
) {
  final direction = model.direction;
  final objective = model.objective;
  final binaries = model.binaries;
  final sign = direction == "minimize" ? -1.0 : 1.0;

  final constraintsIter = convertToList(model.constraints);
  final variablesIter = convertToList(model.variables);
  final variables =
      convertToList<VarKey, Map<ConKey, double>>(variablesIter).toList();

  final binaryConstraintCol = <int>[];
  final ints = <int>[];

  final constraints = <ConKey, _Constraint>{};
  for (var entry in constraintsIter) {
    final key = entry.key;
    final constraint = entry.value;
    final bounds = constraints[key] ??
        _Constraint(
            row: -1, lower: double.negativeInfinity, upper: double.infinity);
    bounds.lower =
        (constraint.equal != null && (bounds.lower < constraint.equal!))
            ? constraint.equal!
            : (constraint.min ?? double.negativeInfinity);
    bounds.upper =
        (constraint.equal != null && (bounds.upper > constraint.equal!))
            ? constraint.equal!
            : (constraint.max ?? double.infinity);
    if (!constraints.containsKey(key)) {
      constraints[key] = bounds;
    }
  }

  var numConstraints = 1;
  for (var constraint in constraints.values) {
    constraint.row = numConstraints;
    numConstraints += (constraint.lower.isFinite ? 1 : 0) +
        (constraint.upper.isFinite ? 1 : 0);
  }

  final width = variables.length + 1;
  final height = numConstraints + binaryConstraintCol.length;
  final numVars = width + height;
  final matrix = Float64List(width * height);
  final positionOfVariable = Int32List(numVars);
  final variableAtPosition = Int32List(numVars);
  final tableau = Tableau(
    matrix: matrix,
    width: width,
    height: height,
    positionOfVariable: positionOfVariable,
    variableAtPosition: variableAtPosition,
  );

  for (var i = 0; i < numVars; i++) {
    positionOfVariable[i] = i;
    variableAtPosition[i] = i;
  }

  for (var c = 1; c < width; c++) {
    for (var entry in convertToList(variables[c - 1].value)) {
      final constraint = entry.key;
      final coef = entry.value;
      if (constraint == objective) {
        update(tableau, 0, c, sign * coef);
      }
      final bounds = constraints[constraint];
      if (bounds != null) {
        if (bounds.upper.isFinite) {
          update(tableau, bounds.row, c, coef);
          if (bounds.lower.isFinite) {
            update(tableau, bounds.row + 1, c, -coef);
          }
        } else if (bounds.lower.isFinite) {
          update(tableau, bounds.row, c, -coef);
        }
      }
    }
  }

  for (var bounds in constraints.values) {
    if (bounds.upper.isFinite) {
      update(tableau, bounds.row, 0, bounds.upper);
      if (bounds.lower.isFinite) {
        update(tableau, bounds.row + 1, 0, -bounds.lower);
      }
    } else if (bounds.lower.isFinite) {
      update(tableau, bounds.row, 0, -bounds.lower);
    }
  }

  for (var b = 0; b < binaryConstraintCol.length; b++) {
    final row = numConstraints + b;
    update(tableau, row, 0, 1.0);
    update(tableau, row, binaryConstraintCol[b], 1.0);
  }

  return TableauModel(
    tableau: tableau,
    sign: sign,
    variables: variables,
    integers: ints,
  );
}

class _Constraint {
  int row;
  double lower;
  double upper;

  _Constraint({
    required this.row,
    required this.lower,
    required this.upper,
  });
}
