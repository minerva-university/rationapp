import '../models/cow_requirements_model.dart';
import '../models/feed_formula_model.dart';
import './optimization/types.dart';
import './optimization/yalps.dart';

class FeedOptimizer {
  FeedFormula? optimize({
    required CowRequirements requirements,
    required List<FeedIngredient> availableFodder,
    required List<FeedIngredient> availableConcentrates,
  }) {
    // Build variables map for the optimizer
    final variables = <String, Map<String, double>>{};

    // Add fodder ingredients
    for (var fodder in availableFodder) {
      final normalizedName = fodder.id.toLowerCase();
      variables[normalizedName] = {
        'dry-matter': fodder.dmIntake / 100,
        'energy-intake': fodder.meIntake,
        'crude-protein': fodder.cpIntake / 100,
        'calcium': fodder.caIntake / 100,
        'phosphorus': fodder.pIntake / 100,
        'ndf': fodder.ndfIntake / 100,
        'cost': fodder.cost,
      };
    }

    // Add concentrate ingredients
    for (var concentrate in availableConcentrates) {
      final normalizedName = concentrate.id.toLowerCase();
      variables[normalizedName] = {
        'dry-matter': concentrate.dmIntake / 100,
        'energy-intake': concentrate.meIntake,
        'crude-protein': concentrate.cpIntake / 100,
        'calcium': concentrate.caIntake / 100,
        'phosphorus': concentrate.pIntake / 100,
        'ndf': concentrate.ndfIntake / 100,
        'cost': concentrate.cost,
      };
    }

    // Create optimization model
    final model = Model(
      direction: OptimizationDirection.minimize,
      objective: 'cost',
      // constraints: {
      //   'dry-matter': Constraint(
      //     min: requirements.dmIntake * 0.7,
      //     max: requirements.dmIntake * 1.35,
      //   ),
      //   'energy-intake': Constraint(
      //     min: requirements.meIntake * 0.7,
      //     max: requirements.meIntake * 1.35,
      //   ),
      //   'crude-protein': Constraint(
      //     min: requirements.cpIntake * 0.7,
      //     max: requirements.cpIntake * 1.35,
      //   ),
      //   'calcium': Constraint(
      //     min: requirements.caIntake * 0.7,
      //     max: requirements.caIntake * 1.35,
      //   ),
      //   'phosphorus': Constraint(
      //     min: requirements.pIntake * 0.7,
      //     max: requirements.pIntake * 1.35,
      //   ),
      //   'ndf': Constraint(
      //     min: requirements.ndfIntake * 0.7,
      //     max: requirements.ndfIntake * 1.35,
      //   ),
      // },
      constraints: {
        'dry-matter': Constraint(min: 4.4, max: 4.7),
        'energy-intake': Constraint(min: 80, max: 90),
        'crude-protein': Constraint(min: 0.10, max: 7.5),
        'calcium': Constraint(min: 0.004, max: 5),
        'phosphorus': Constraint(min: 0.0010, max: 14),
        'ndf': Constraint(min: 0.4, max: 6),
      },
      variables: variables,
    );

    final options = Options(
      precision: 1e-8,
      checkCycles: false,
      maxPivots: 1000,
      tolerance: 0,
      timeout: double.infinity,
      maxIterations: 1000,
      includeZeroVariables: false,
    );

    try {
      final solution = solve(model, options);
      print(solution.toString());
      print(solution.status);
      print(solution.result);
      print(solution.variables);
      if (solution.status == SolutionStatus.optimal) {
        // Convert solution back to FeedFormula
        final fodderItems = <FeedIngredient>[];
        final concentrateItems = <FeedIngredient>[];

        for (final variable in solution.variables) {
          final amount = variable.value;
          if (amount > 0) {
            final ingredientId = variable.key;

            // Find the original ingredient
            final fodder = availableFodder.firstWhere(
              (f) => f.id.toLowerCase() == ingredientId,
              orElse: () => availableConcentrates.firstWhere(
                (c) => c.id.toLowerCase() == ingredientId,
              ),
            );

            // Create new ingredient with optimized amount
            final optimizedIngredient = FeedIngredient(
              id: fodder.id,
              name: fodder.name,
              weight: amount,
              dmIntake: fodder.dmIntake,
              meIntake: fodder.meIntake,
              cpIntake: fodder.cpIntake,
              ndfIntake: fodder.ndfIntake,
              caIntake: fodder.caIntake,
              pIntake: fodder.pIntake,
              cost: fodder.cost * amount,
              isFodder: fodder.isFodder,
            );

            if (fodder.isFodder) {
              fodderItems.add(optimizedIngredient);
            } else {
              concentrateItems.add(optimizedIngredient);
            }
          }
        }

        return FeedFormula(
          fodder: fodderItems,
          concentrate: concentrateItems,
        );
      }
    } catch (e) {
      print('Optimization error: $e');
    }

    return null;
  }
}
