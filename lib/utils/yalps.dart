// Copied from https://github.com/Ivordir/YALPS/tree/main
// ChatGPT converted to Dart

import 'types.dart';
import 'tableau.dart';
import 'util.dart';
// import 'simplex.dart';
import "package:rationapp/utils/simplex.dart";

// Creates a solution object representing the optimal solution (if any).
Solution<VarKey> solution<VarKey, ConKey>(
  TableauModel<VarKey, ConKey> tableauModel,
  SolutionStatus status,
  double result,
  Options options,
) {
  final tableau = tableauModel.tableau;
  final sign = tableauModel.sign;
  final vars = tableauModel.variables;
  final precision = options.precision;
  final includeZeroVariables = options.includeZeroVariables;

  if (status == SolutionStatus.optimal ||
      (status == SolutionStatus.timedout && !result.isNaN)) {
    final variables = <MapEntry<VarKey, double>>[];
    for (var i = 0; i < vars.length; i++) {
      final variable = vars[i].key;
      final row = tableau.positionOfVariable[i + 1] - tableau.width;
      final value = row >= 0 ? index(tableau, row, 0) : 0.0;
      if (value > precision) {
        variables.add(MapEntry(variable, roundToPrecision(value, precision)));
      } else if (includeZeroVariables) {
        variables.add(MapEntry(variable, 0.0));
      }
    }
    return Solution<VarKey>(
      status: status,
      result: -sign * result,
      variables: variables,
    );
  } else if (status == SolutionStatus.unbounded) {
    final variable = tableau.variableAtPosition[result.toInt()] - 1;
    return Solution<VarKey>(
      status: SolutionStatus.unbounded,
      result: sign * double.infinity,
      variables: (0 <= variable && variable < vars.length)
          ? [MapEntry(vars[variable].key, double.infinity)]
          : [],
    );
  } else {
    // infeasible | cycled | (timedout and result is NaN)
    return Solution<VarKey>(
      status: status,
      result: double.nan,
      variables: [],
    );
  }
}

final defaultOptionValues = Options(
  precision: 1e-8,
  checkCycles: false,
  maxPivots: 8192,
  tolerance: 0,
  timeout: double.infinity,
  maxIterations: 32768,
  includeZeroVariables: false,
);

///
/// The default options used by the solver.
///
final defaultOptions = defaultOptionValues.copyWith();

///
/// Runs the solver on the given model and using the given options (if any).
/// @see `Model` on how to specify/create the model.
/// @see `Options` for the kinds of options available.
/// @see `Solution` for more detailed information on what is returned.
///
Solution<VarKey> solve<VarKey, ConKey>(Model<VarKey, ConKey> model,
    [Options? options]) {
  final tabmod = tableauModel(model);
  final opt = options ?? defaultOptionValues;
  final simplexResult = simplex(tabmod.tableau, opt);

  final status = simplexResult[0];
  final result = simplexResult[1];

  // If a non-integer problem, return the simplex result.
  // Otherwise, the problem has integer variables, but the initial solution is either:
  // 1) unbounded | infeasible => all branches will also be unbounded | infeasible
  // 2) cycled => cannot get an initial solution, return invalid solution
  return solution(tabmod, status, result, opt);
}

// void main() {
//   // Define the model
//   final model = Model(
//     direction: OptimizationDirection.maximize,
//     objective: 'profit',
//     constraints: {
//       'wood': Constraint(max: 300),
//       'labor': Constraint(min: 10, max: 110),
//       'storage': Constraint(max: 400),
//     },
//     variables: {
//       'table': {
//         'wood': 30,
//         'labor': 5,
//         'profit': 1200,
//         'storage': 30,
//       },
//       'dresser': {
//         'wood': 20,
//         'labor': 10,
//         'profit': 1600,
//         'storage': 50,
//       },
//     },
//   );

//   // Define the options
//   final options = Options(
//     precision: 1e-8,
//     checkCycles: false,
//     maxPivots: 8192,
//     tolerance: 0,
//     timeout: double.infinity,
//     maxIterations: 32768,
//     includeZeroVariables: false,
//   );

//   // Solve the model
//   final solution = solve(model, options);

//   // Print the solution
//   print('Status: ${solution.status}');
//   print('Result: ${solution.result}');
//   print('Variables:');
//   for (final variable in solution.variables) {
//     print('${variable.key}: ${variable.value}');
//   }
// }

