// src/types.dart

class Constraint {
  final double? equal;
  final double? min;
  final double? max;

  Constraint({this.equal, this.min, this.max});
}

typedef Coefficients<ConstraintKey> = Map<ConstraintKey, double>;

enum OptimizationDirection { maximize, minimize }

class Model<VariableKey, ConstraintKey> {
  final OptimizationDirection? direction;
  final ConstraintKey? objective;
  final Map<ConstraintKey, Constraint> constraints;
  final Map<VariableKey, Coefficients<ConstraintKey>> variables;
  final bool? binaries;

  Model({
    this.direction,
    this.objective,
    required this.constraints,
    required this.variables,
    this.binaries,
  });
}

enum SolutionStatus { optimal, infeasible, unbounded, timedout, cycled }

class Solution<VariableKey> {
  final SolutionStatus status;
  final double result;
  final List<MapEntry<VariableKey, double>> variables;

  Solution({
    required this.status,
    required this.result,
    required this.variables,
  });
}

class Options {
  double precision = 1e-8;
  bool checkCycles = false;
  int maxPivots = 1000;
  double tolerance = 1e-8;
  double timeout = 60;
  int maxIterations = 1000;
  bool includeZeroVariables = true;

  Options({
    required this.precision,
    required this.checkCycles,
    required this.maxPivots,
    required this.tolerance,
    required this.timeout,
    required this.maxIterations,
    required this.includeZeroVariables,
  });

  Options copyWith({
    double? precision,
    bool? checkCycles,
    int? maxPivots,
    double? tolerance,
    double? timeout,
    int? maxIterations,
    bool? includeZeroVariables,
  }) {
    return Options(
      precision: precision ?? this.precision,
      checkCycles: checkCycles ?? this.checkCycles,
      maxPivots: maxPivots ?? this.maxPivots,
      tolerance: tolerance ?? this.tolerance,
      timeout: timeout ?? this.timeout,
      maxIterations: maxIterations ?? this.maxIterations,
      includeZeroVariables: includeZeroVariables ?? this.includeZeroVariables,
    );
  }
}
