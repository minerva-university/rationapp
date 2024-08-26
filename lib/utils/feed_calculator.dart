import 'package:rationapp/models/feed_formula_model.dart';
import '../services/persistence_manager.dart';
import '../data/nutrition_tables.dart';

class FeedCalculator {
  List<FeedIngredient> fodderItems = [];
  List<FeedIngredient> concentrateItems = [];

  FeedCalculator() {
    _loadAvailableItems();
  }

  void _loadAvailableItems() {
    final savedPricesAndAvailability =
        SharedPrefsService.getFeedPricesAndAvailability();
    if (savedPricesAndAvailability != null) {
      fodderItems =
          savedPricesAndAvailability.where((item) => item.isFodder).toList();
      concentrateItems =
          savedPricesAndAvailability.where((item) => !item.isFodder).toList();
    } else {
      fodderItems = NutritionTables.fodderItems;
      concentrateItems = NutritionTables.concentrateItems;
    }
  }

  FeedIngredient calculateIngredientValues(
      String name, double weight, bool isFodder) {
    final table = isFodder ? fodderItems : concentrateItems;
    final ingredient =
        table.firstWhere((e) => e['name'].toLowerCase() == name.toLowerCase());

    final dmIntake =
        ((ingredient['dmIntake'])?.toDouble() ?? 0.0) * weight / 100;
    final meIntake = ((ingredient['meIntake'])?.toDouble() ?? 0.0) * dmIntake;
    final cost = ((ingredient['costPerKg'])?.toDouble() ?? 0.0) * weight;

    double calculateValue(String key) {
      return ((ingredient[key])?.toDouble() ?? 0.0) * dmIntake / 100;
    }

    return FeedIngredient(
        name: name,
        weight: weight,
        dmIntake: dmIntake,
        meIntake: meIntake,
        cpIntake: calculateValue('cpIntake'),
        ndfIntake: calculateValue('ndfIntake'),
        caIntake: calculateValue('caIntake'),
        pIntake: calculateValue('pIntake'),
        costPerKg: cost,
        isFodder: isFodder);
  }
}
