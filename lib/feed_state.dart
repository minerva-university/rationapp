import 'package:flutter/material.dart';
import '../models/feed_formula_model.dart';
import '../services/persistence_manager.dart';
import '../data/nutrition_tables.dart';
import 'package:provider/provider.dart';

class FeedState extends ChangeNotifier {
  List<FeedIngredient> fodderItems = [];
  List<FeedIngredient> concentrateItems = [];
  late BuildContext _context;
  late SharedPrefsService sharedPrefsService;

  FeedState();

  void initializeWithContext(BuildContext context) {
    _context = context;
    sharedPrefsService = Provider.of<SharedPrefsService>(_context);
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
    final savedPrices = sharedPrefsService.getFeedPricesAndAvailability();
    if (savedPrices != null) {
      fodderItems = savedPrices.where((item) => item.isFodder).toList();
      concentrateItems = savedPrices.where((item) => !item.isFodder).toList();
    } else {
      final nutritionTables = NutritionTables(_context);
      fodderItems = nutritionTables.fodderItems;
      concentrateItems = nutritionTables.concentrateItems;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void _savePricesAndAvailability() {
    List<FeedIngredient> allItems = [...fodderItems, ...concentrateItems];
    sharedPrefsService.setFeedPricesAndAvailability(allItems);
  }

  List<FeedIngredient> get availableFodderItems =>
      fodderItems.where((item) => item.isAvailable).toList();

  List<FeedIngredient> get availableConcentrateItems =>
      concentrateItems.where((item) => item.isAvailable).toList();
}
