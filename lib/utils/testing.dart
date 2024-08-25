import 'types.dart';
import 'yalps.dart';

void main() {
  // Define the model
  final model = Model(
    direction: OptimizationDirection.minimize,
    objective: 'cost',
    constraints: {
      'dry-matter': Constraint(min: 4.4, max: 4.7),
      'energy-intake': Constraint(min: 80, max: 90),
      'crude-protein':
          Constraint(min: 0.10, max: 7.5), // Max constraint is not realistic
      'calcium':
          Constraint(min: 0.004, max: 5), // Max constraint is not realistic
      'phosphorus':
          Constraint(min: 0.0010, max: 14), // Max constraint is not realistic
      'ndf': Constraint(min: 0.4, max: 6), // Max constraint is not realistic
    },
    variables: {
      // Normal feeds:
      'green-maize': {
        'dry-matter': 0.23,
        'energy-intake': 9.6,
        'crude-protein': 0.079,
        'calcium': 0.004,
        'phosphorus': 0.002,
        'ndf': 0.632,
        'cost': 10,
      },
      'alfalfa': {
        'dry-matter': 0.906,
        'energy-intake': 9.6,
        'crude-protein': 0.183,
        'calcium': 0.0221,
        'phosphorus': 0.0027,
        'ndf': 0.459,
        'cost': 12,
      },
      'sorghum-straw': {
        'dry-matter': 0.933,
        'energy-intake': 7.3,
        'crude-protein': 0.037,
        'calcium': 0.0031,
        'phosphorus': 0.0007,
        'ndf': 0.766,
        'cost': 22,
      },
      'soya-bean-forage': {
        'dry-matter': 0.24,
        'energy-intake': 9.2,
        'crude-protein': 0.157,
        'calcium': 0.0148,
        'phosphorus': 0.0027,
        'ndf': 0.481,
        'cost': 15,
      },
      'groundnut seeds': {
        'dry-matter': 0.955,
        'energy-intake': 18.2,
        'crude-protein': 0.295,
        'calcium': 0.0008,
        'phosphorus': 0.0046,
        'ndf': 0.093,
        'cost': 16,
      }, // Contrates:
      'sesame-seed-meal': {
        'dry-matter': 0.928,
        'energy-intake': 12.5,
        'crude-protein': 0.449,
        'calcium': 0.0197,
        'phosphorus': 0.0126,
        'ndf': 0.246,
        'cost': 25,
      },
      'molasses': {
        'dry-matter': 0.955,
        'energy-intake': 18.2,
        'crude-protein': 0.295,
        'calcium': 0.0008,
        'phosphorus': 0.0046,
        'ndf': 0.093,
        'cost': 25,
      },
      'maize-grain': {
        'dry-matter': 0.955,
        'energy-intake': 18.2,
        'crude-protein': 0.295,
        'calcium': 0.0008,
        'phosphorus': 0.0046,
        'ndf': 0.093,
        'cost': 25,
      },
    },
  );

  // Define the options
  final options = Options(
    precision: 1e-8,
    checkCycles: false,
    maxPivots: 1000,
    tolerance: 0,
    timeout: double.infinity,
    maxIterations: 1000,
    includeZeroVariables: false,
  );

  // Solve the model
  final solution = solve(model, options);

  // Print the solution
  print('Status: ${solution.status}');
  print('Cost: ${solution.result}');
  print('Variables:');
  for (final variable in solution.variables) {
    print('${variable.key}: ${variable.value}');
  }
}
