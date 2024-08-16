import '../data/nutrition_tables.dart';
import 'package:flutter/material.dart';

class FeedCalculator {
  final BuildContext context;

  FeedCalculator(this.context);
  Map<String, dynamic> calculateIngredientValues(
      String name, double weight, bool isFodder) {
    final table = isFodder
        ? NutritionTables(context).fodder
        : NutritionTables(context).concentrates;
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
