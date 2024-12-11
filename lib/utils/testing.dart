import 'types.dart';
import 'yalps.dart';

// Simple FeedIngredient class without Flutter dependencies
class FeedIngredient {
  final String id;
  final String name;
  final double dmIntake;
  final double meIntake;
  final double cpIntake;
  final double ndfIntake;
  final double caIntake;
  final double pIntake;
  final double cost;
  final bool isFodder;

  FeedIngredient({
    required this.id,
    required this.name,
    required this.dmIntake,
    required this.meIntake,
    required this.cpIntake,
    required this.ndfIntake,
    required this.caIntake,
    required this.pIntake,
    required this.cost,
    required this.isFodder,
  });
}

// Nutrition data without Flutter dependencies
class NutritionData {
  List<FeedIngredient> get fodderItems => [
        FeedIngredient(
          id: 'fodderGreenMaizeForage',
          name: 'Green Maize Forage',
          dmIntake: 23.3,
          meIntake: 9.6,
          cpIntake: 7.9,
          ndfIntake: 63.2,
          caIntake: 0.36,
          pIntake: 0.2,
          cost: 2.50,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderAlfafa',
          name: 'Alfafa',
          dmIntake: 19.9,
          meIntake: 9.4,
          cpIntake: 20.6,
          ndfIntake: 39.3,
          caIntake: 19.4,
          pIntake: 2.5,
          cost: 6.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderBananaStalks',
          name: 'Banana Stalks',
          dmIntake: 7.2,
          meIntake: 16.9,
          cpIntake: 5.1,
          ndfIntake: 57.5,
          caIntake: 0.75,
          pIntake: 0.29,
          cost: 0,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderBananaLeaves',
          name: 'Banana Leaves',
          dmIntake: 20.7,
          meIntake: 18.1,
          cpIntake: 9.5,
          ndfIntake: 1.67,
          caIntake: 0.12,
          pIntake: 0,
          cost: 0,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderSorghumForage',
          name: 'Sorghum Forage',
          dmIntake: 28.1,
          meIntake: 8.8,
          cpIntake: 8.2,
          ndfIntake: 57.9,
          caIntake: 0.41,
          pIntake: 0.2,
          cost: 0,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderSorghumStalk',
          name: 'Sorghum Stalk',
          dmIntake: 93.3,
          meIntake: 7.3,
          cpIntake: 3.7,
          ndfIntake: 76.6,
          caIntake: 0.31,
          pIntake: 0.07,
          cost: 5.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderMaizeSilage',
          name: 'Maize Silage',
          dmIntake: 23.5,
          meIntake: 10.5,
          cpIntake: 8.9,
          ndfIntake: 49.3,
          caIntake: 0.21,
          pIntake: 0.19,
          cost: 0,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderSorghumBiProductResidue',
          name: 'Sorghum BiProduct Residue',
          dmIntake: 89.8,
          meIntake: 13.2,
          cpIntake: 11.7,
          ndfIntake: 42.9,
          caIntake: 0.9,
          pIntake: 4.9,
          cost: 4.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderPearlMilletStalk',
          name: 'Pearl Millet Stalk',
          dmIntake: 93.1,
          meIntake: 6.3,
          cpIntake: 5.2,
          ndfIntake: 80,
          caIntake: 2.5,
          pIntake: 1.5,
          cost: 5.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderPearlMilletFreshForage',
          name: 'Pearl Millet Fresh Forage',
          dmIntake: 19.4,
          meIntake: 9.2,
          cpIntake: 12.4,
          ndfIntake: 64.8,
          caIntake: 5.5,
          pIntake: 2.8,
          cost: 16.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderWheatStraw',
          name: 'Wheat Straw',
          dmIntake: 91.0,
          meIntake: 6.8,
          cpIntake: 4.2,
          ndfIntake: 77.8,
          caIntake: 4.8,
          pIntake: 0.7,
          cost: 2.80,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderBarleyStraw',
          name: 'Barley Straw',
          dmIntake: 90.9,
          meIntake: 6.5,
          cpIntake: 3.8,
          ndfIntake: 80.5,
          caIntake: 4.6,
          pIntake: 1.0,
          cost: 2.80,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderCabbage',
          name: 'Cabbage',
          dmIntake: 12.0,
          meIntake: 18.0,
          cpIntake: 16.6,
          ndfIntake: 20.0,
          caIntake: 2.1,
          pIntake: 0.6,
          cost: 2.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderElephantGrass',
          name: 'Elephant Grass',
          dmIntake: 17.9,
          meIntake: 8.2,
          cpIntake: 9.7,
          ndfIntake: 39.3,
          caIntake: 3.6,
          pIntake: 2.9,
          cost: 3.50,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderEragrostisTefHay',
          name: 'Eragrostis Tef Hay',
          dmIntake: 91.7,
          meIntake: 8.6,
          cpIntake: 14.6,
          ndfIntake: 56.6,
          caIntake: 4.7,
          pIntake: 2.6,
          cost: 3.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderBananaFruit',
          name: 'Banana Fruit',
          dmIntake: 21.9,
          meIntake: 11.3,
          cpIntake: 5.2,
          ndfIntake: 16.2,
          caIntake: 0.2,
          pIntake: 0.9,
          cost: 1.25,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderWildGrassFresh',
          name: 'Wild Grass Fresh',
          dmIntake: 38.2,
          meIntake: 7.6,
          cpIntake: 9.0,
          ndfIntake: 73.3,
          caIntake: 2.0,
          pIntake: 1.2,
          cost: 3.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderWildGrassHay',
          name: 'Wild Grass Hay',
          dmIntake: 91.7,
          meIntake: 8.6,
          cpIntake: 14.6,
          ndfIntake: 56.6,
          caIntake: 4.7,
          pIntake: 2.6,
          cost: 3.00,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderElephantGrassHay',
          name: 'Elephant Grass Hay',
          dmIntake: 89.3,
          meIntake: 7.9,
          cpIntake: 10.3,
          ndfIntake: 71.1,
          caIntake: 2.8,
          pIntake: 2.3,
          cost: 3.50,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderBarleyHay',
          name: 'Barley Hay',
          dmIntake: 84.9,
          meIntake: 9.3,
          cpIntake: 8.7,
          ndfIntake: 53.1,
          caIntake: 2.1,
          pIntake: 2.8,
          cost: 2.80,
          isFodder: true,
        ),
        FeedIngredient(
          id: 'fodderWheatHay',
          name: 'Wheat Hay',
          dmIntake: 84.9,
          meIntake: 7.8,
          cpIntake: 5.4,
          ndfIntake: 54.2,
          caIntake: 0.25,
          pIntake: 0.2,
          cost: 2.80,
          isFodder: true,
        ),
      ];

  List<FeedIngredient> get concentrateItems => [
        FeedIngredient(
          id: 'concentrateSesameSeedMeal',
          name: 'Sesame Seed Meal',
          dmIntake: 92.8,
          meIntake: 12.5,
          cpIntake: 44.9,
          ndfIntake: 24.6,
          caIntake: 1.97,
          pIntake: 1.26,
          cost: 18.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateSorghumGrain',
          name: 'Sorghum Grain',
          dmIntake: 87.4,
          meIntake: 13.5,
          cpIntake: 10.8,
          ndfIntake: 11.0,
          caIntake: 0.3,
          pIntake: 3.3,
          cost: 18.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentratePearlMilletGrain',
          name: 'Pearl Millet Grain',
          dmIntake: 89.6,
          meIntake: 13.3,
          cpIntake: 12.5,
          ndfIntake: 17.2,
          caIntake: 0.5,
          pIntake: 3.3,
          cost: 18.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateGroundnutMeal',
          name: 'Groundnut Meal',
          dmIntake: 90.0,
          meIntake: 12.0,
          cpIntake: 40.0,
          ndfIntake: 13.0,
          caIntake: 0.15,
          pIntake: 0.6,
          cost: 14.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateChickpeaMeal',
          name: 'Chickpea Meal',
          dmIntake: 89.0,
          meIntake: 14.1,
          cpIntake: 22.1,
          ndfIntake: 22.8,
          caIntake: 1.7,
          pIntake: 3.9,
          cost: 14.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateMaizeBran',
          name: 'Maize Bran',
          dmIntake: 88.7,
          meIntake: 11.0,
          cpIntake: 11.9,
          ndfIntake: 44.2,
          caIntake: 0.03,
          pIntake: 0.05,
          cost: 5.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateBrewersByProductFresh',
          name: 'Brewers By Product Fresh',
          dmIntake: 24.9,
          meIntake: 10.0,
          cpIntake: 25.9,
          ndfIntake: 49.6,
          caIntake: 3.0,
          pIntake: 5.8,
          cost: 15.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateMineralLick',
          name: 'Mineral Lick',
          dmIntake: 95.0,
          meIntake: 0.0,
          cpIntake: 0.0,
          ndfIntake: 0.0,
          caIntake: 30.0,
          pIntake: 10.0,
          cost: 15.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateSalt',
          name: 'Salt',
          dmIntake: 0.0,
          meIntake: 0.0,
          cpIntake: 0.0,
          ndfIntake: 0.0,
          caIntake: 0.0,
          pIntake: 0.0,
          cost: 2.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateDryBread',
          name: 'Dry Bread',
          dmIntake: 90.7,
          meIntake: 14.5,
          cpIntake: 12.4,
          ndfIntake: 7.0,
          caIntake: 1.0,
          pIntake: 6.2,
          cost: 10.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateSorghumBrewersGrainFresh',
          name: 'Sorghum Brewers Grain Fresh',
          dmIntake: 31.6,
          meIntake: 13.8,
          cpIntake: 35.5,
          ndfIntake: 35.6,
          caIntake: 1.5,
          pIntake: 8.7,
          cost: 0.0,
          isFodder: false,
        ),
        FeedIngredient(
          id: 'concentrateWheatBran',
          name: 'Wheat Bran',
          dmIntake: 87.0,
          meIntake: 11.0,
          cpIntake: 17.3,
          ndfIntake: 45.2,
          caIntake: 1.4,
          pIntake: 11.1,
          cost: 0.0,
          isFodder: false,
        ),
      ];
}

Map<String, Map<String, double>> buildVariablesMap() {
  final nutritionData = NutritionData();
  final variables = <String, Map<String, double>>{};

  void addIngredient(FeedIngredient ingredient) {
    final normalizedName = ingredient.name.toLowerCase().replaceAll(' ', '-');
    variables[normalizedName] = {
      'dry-matter': ingredient.dmIntake / 100,
      'energy-intake': ingredient.meIntake,
      'crude-protein': ingredient.cpIntake / 100,
      'calcium': ingredient.caIntake / 100,
      'phosphorus': ingredient.pIntake / 100,
      'ndf': ingredient.ndfIntake / 100,
      'cost': ingredient.cost,
    };
  }

  for (var fodder in nutritionData.fodderItems) {
    addIngredient(fodder);
  }

  for (var concentrate in nutritionData.concentrateItems) {
    addIngredient(concentrate);
  }

  return variables;
}

void main() {
  final variables = buildVariablesMap();

  final model = Model(
    direction: OptimizationDirection.minimize,
    objective: 'cost',
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

  // Print the variables map to verify the data
  // print('\nGenerated Variables Map:');
  // variables.forEach((key, value) {
  //   print('\n$key:');
  //   value.forEach((prop, val) => print('  $prop: $val'));
  // });

  // Solve the model
  final solution = solve(model, options);

  // Print the solution
  print('\nSolution:');
  print('Status: ${solution.status}');
  print('Cost: ${solution.result}');
  print('Variables:');
  for (final variable in solution.variables) {
    print('${variable.key}: ${variable.value}');
  }
}
