import 'types.dart';
import 'tableau.dart';
import 'util.dart';

void pivot(Tableau tableau, int row, int col) {
  final quotient = index(tableau, row, col);
  final leaving = tableau.variableAtPosition[tableau.width + row];
  final entering = tableau.variableAtPosition[col];
  tableau.variableAtPosition[tableau.width + row] = entering;
  tableau.variableAtPosition[col] = leaving;
  tableau.positionOfVariable[leaving] = col;
  tableau.positionOfVariable[entering] = tableau.width + row;

  final nonZeroColumns = <int>[];
  // (1 / quotient) * R_pivot -> R_pivot
  for (var c = 0; c < tableau.width; c++) {
    final value = index(tableau, row, c);
    if (value.abs() > 1e-16) {
      update(tableau, row, c, value / quotient);
      nonZeroColumns.add(c);
    } else {
      update(tableau, row, c, 0.0);
    }
  }
  update(tableau, row, col, 1.0 / quotient);

  // -M[r, col] * R_pivot + R_r -> R_r
  for (var r = 0; r < tableau.height; r++) {
    if (r == row) continue;
    final coef = index(tableau, r, col);
    if (coef.abs() > 1e-16) {
      for (var c in nonZeroColumns) {
        update(tableau, r, c,
            index(tableau, r, c) - coef * index(tableau, row, c));
      }
      update(tableau, r, col, -coef / quotient);
    }
  }
}

typedef PivotHistory = List<List<int>>;

// Checks if the simplex method has encountered a cycle.
bool hasCycle(PivotHistory history, Tableau tableau, int row, int col) {
  history.add([
    tableau.variableAtPosition[tableau.width + row],
    tableau.variableAtPosition[col]
  ]);
  // the minimum length of a cycle is 6
  for (var length = 6; length <= (history.length / 2).floor(); length++) {
    var cycle = true;
    for (var i = 0; i < length; i++) {
      final item = history.length - 1 - i;
      final row1 = history[item][0];
      final col1 = history[item][1];
      final row2 = history[item - length][0];
      final col2 = history[item - length][1];
      if (row1 != row2 || col1 != col2) {
        cycle = false;
        break;
      }
    }
    if (cycle) return true;
  }
  return false;
}

// Finds the optimal solution given some basic feasible solution.
List<dynamic> phase2(Tableau tableau, Options options) {
  final pivotHistory = <List<int>>[];
  final precision = options.precision;
  final maxPivots = options.maxPivots;
  final checkCycles = options.checkCycles;

  for (var iter = 0; iter < maxPivots; iter++) {
    // Find the entering column/variable
    var col = 0;
    var value = precision;
    for (var c = 1; c < tableau.width; c++) {
      final reducedCost = index(tableau, 0, c);
      if (reducedCost > value) {
        value = reducedCost;
        col = c;
      }
    }
    if (col == 0)
      return [
        SolutionStatus.optimal,
        roundToPrecision(index(tableau, 0, 0), precision)
      ];

    // Find the leaving row/variable
    var row = 0;
    var minRatio = double.infinity;
    for (var r = 1; r < tableau.height; r++) {
      final value = index(tableau, r, col);
      if (value <= precision) continue; // pivot entry must be positive
      final rhs = index(tableau, r, 0);
      final ratio = rhs / value;
      if (ratio < minRatio) {
        row = r;
        minRatio = ratio;
        if (ratio <= precision) break; // ratio is 0, lowest possible
      }
    }
    if (row == 0) return [SolutionStatus.unbounded, col];

    if (checkCycles && hasCycle(pivotHistory, tableau, row, col))
      return [SolutionStatus.cycled, double.nan];

    pivot(tableau, row, col);
  }
  return [SolutionStatus.cycled, double.nan];
}

// Transforms a tableau into a basic feasible solution.
List<dynamic> phase1(Tableau tableau, Options options) {
  final pivotHistory = <List<int>>[];
  final precision = options.precision;
  final maxPivots = options.maxPivots;
  final checkCycles = options.checkCycles;

  for (var iter = 0; iter < maxPivots; iter++) {
    // Find the leaving row/variable
    var row = 0;
    var rhs = -precision;
    for (var r = 1; r < tableau.height; r++) {
      final value = index(tableau, r, 0);
      if (value < rhs) {
        rhs = value;
        row = r;
      }
    }
    if (row == 0) return phase2(tableau, options);

    // Find the entering column/variable
    var col = 0;
    var maxRatio = -double.infinity;
    for (var c = 1; c < tableau.width; c++) {
      final coefficient = index(tableau, row, c);
      if (coefficient < -precision) {
        final ratio = -index(tableau, 0, c) / coefficient;
        if (ratio > maxRatio) {
          maxRatio = ratio;
          col = c;
        }
      }
    }
    if (col == 0) return [SolutionStatus.infeasible, double.nan];

    if (checkCycles && hasCycle(pivotHistory, tableau, row, col))
      return [SolutionStatus.cycled, double.nan];

    pivot(tableau, row, col);
  }
  return [SolutionStatus.cycled, double.nan];
}

List<dynamic> simplex(Tableau tableau, Options options) {
  return phase1(tableau, options);
}
