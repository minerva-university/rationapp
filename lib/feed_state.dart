import 'package:flutter/foundation.dart';
import '../models/feed_formula_model.dart';
import '../services/persistence_manager.dart';
import '../data/nutrition_tables.dart';

class FeedState extends ChangeNotifier {
  List<FeedIngredient> fodderItems = [];
  List<FeedIngredient> concentrateItems = [];

  FeedState() {
    loadSavedPrices();
  }

  void updateIngredient(FeedIngredient updatedIngredient) {
    List<FeedIngredient> targetList =
        updatedIngredient.isFodder ? fodderItems : concentrateItems;
    final index =
        targetList.indexWhere((item) => item.name == updatedIngredient.name);
    if (index != -1) {
      targetList[index] = updatedIngredient;
      _savePricesAndAvailability();
      notifyListeners();
    }
  }

  void loadSavedPrices() {
    final savedPrices = SharedPrefsService.getFeedPricesAndAvailability();
    if (savedPrices != null) {
      fodderItems = savedPrices.where((item) => item.isFodder).toList();
      concentrateItems = savedPrices.where((item) => !item.isFodder).toList();
      notifyListeners();
    } else {
      fodderItems = NutritionTables.fodderItems;
      concentrateItems = NutritionTables.concentrateItems;
    }
  }

  void _savePricesAndAvailability() {
    List<FeedIngredient> allItems = [...fodderItems, ...concentrateItems];
    SharedPrefsService.setFeedPricesAndAvailability(allItems);
  }

  List<FeedIngredient> get availableFodderItems =>
      fodderItems.where((item) => item.isAvailable).toList();

  List<FeedIngredient> get availableConcentrateItems =>
      concentrateItems.where((item) => item.isAvailable).toList();
}
