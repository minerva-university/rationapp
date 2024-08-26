import '../data/nutrition_tables.dart';
import '../models/feed_formula_model.dart';
import '../services/persistence_manager.dart';

class FeedConstants {
  List<FeedIngredient> fodderItems = [];
  List<FeedIngredient> concentrateItems = [];

  FeedConstants() {
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

  List<String> get fodderOptions => [
        'Choose fodder',
        ...fodderItems
            .where((item) => item.isAvailable)
            .map((item) => item.name)
      ];
  List<String> get concentrateOptions => [
        'Choose concentrate',
        ...concentrateItems
            .where((item) => item.isAvailable)
            .map((item) => item.name)
      ];
}
