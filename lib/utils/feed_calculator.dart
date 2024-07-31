import '../data/nutrition_tables.dart';

class FeedCalculator {
  static Map<String, dynamic> calculateIngredientValues(
      String name, double weight, bool isFodder) {
    final table =
        isFodder ? NutritionTables.fodder : NutritionTables.concentrates;
    final ingredient =
        table.firstWhere((e) => e['name'].toLowerCase() == name.toLowerCase());

    final dmIntake = ((ingredient['dm'])?.toDouble() ?? 0.0) * weight / 100;
    final meIntake = ((ingredient['me'])?.toDouble() ?? 0.0) * dmIntake;
    final cost = ((ingredient['costPerKg'])?.toDouble() ?? 0.0) * weight;

    double calculateValue(String key) {
      return ((ingredient[key])?.toDouble() ?? 0.0) * dmIntake / 100;
    }

    return {
      'name': name,
      'weight': weight,
      'dmIntake': dmIntake,
      'meIntake': meIntake,
      'cpIntake': calculateValue('cp'),
      'ndfIntake': calculateValue('ndf'),
      'caIntake': calculateValue('ca'),
      'pIntake': calculateValue('p'),
      'cost': cost,
    };
  }
}
