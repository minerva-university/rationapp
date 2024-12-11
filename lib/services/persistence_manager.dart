import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cow_characteristics_model.dart';
import '../models/feed_formula_model.dart';

class SharedPrefsService {
  static SharedPreferences? prefs;
  static const String _cowCharacteristicsKey = 'cow_characteristics';
  static const String _feedFormulaKey = 'feed_formula';
  static const String _feedPricesKey = 'feed_prices';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setCowCharacteristics(
      CowCharacteristics cowCharacteristics) async {
    final String cowCharacteristicsJson =
        json.encode(cowCharacteristics.toJson());
    return await prefs?.setString(
            _cowCharacteristicsKey, cowCharacteristicsJson) ??
        false;
  }

  CowCharacteristics? getCowCharacteristics() {
    final String? cowCharacteristicsJson =
        prefs?.getString(_cowCharacteristicsKey);
    if (cowCharacteristicsJson != null) {
      final Map<String, dynamic> cowCharacteristicsMap =
          json.decode(cowCharacteristicsJson);
      return CowCharacteristics.fromJson(cowCharacteristicsMap);
    }
    return null;
  }

  Future<bool> setFeedFormula(FeedFormula? feedFormula) async {
    final String feedFormulaJson = json.encode(feedFormula!.toJson());
    return await prefs?.setString(_feedFormulaKey, feedFormulaJson) ?? false;
  }

  FeedFormula? getFeedFormula() {
    final String? feedFormulaJson = prefs?.getString(_feedFormulaKey);
    if (feedFormulaJson != null) {
      final Map<String, dynamic> feedFormulaMap = json.decode(feedFormulaJson);
      return FeedFormula.fromJson(feedFormulaMap);
    }
    return null;
  }

  Future<bool> setFeedPricesAndAvailability(
      List<FeedIngredient> feedIngredients) async {
    final List<Map<String, dynamic>> ingredientsJson =
        feedIngredients.map((ingredient) => ingredient.toJson()).toList();
    final String pricesJson = json.encode(ingredientsJson);
    return await prefs?.setString(_feedPricesKey, pricesJson) ?? false;
  }

  List<FeedIngredient>? getFeedPricesAndAvailability() {
    final String? pricesJson = prefs?.getString(_feedPricesKey);
    if (pricesJson != null) {
      final List<dynamic> decodedList = json.decode(pricesJson);
      return decodedList.map((json) => FeedIngredient.fromJson(json)).toList();
    }
    return null;
  }

  static Future<bool> clearCowCharacteristics() async {
    return await prefs?.remove(_cowCharacteristicsKey) ?? false;
  }

  static Future<bool> clearFeedFormula() async {
    return await prefs?.remove(_feedFormulaKey) ?? false;
  }

  static Future<bool> clearFeedPrices() async {
    return await prefs?.remove(_feedPricesKey) ?? false;
  }

  static Future<bool> clearAll() async {
    return await prefs?.clear() ?? false;
  }
}
