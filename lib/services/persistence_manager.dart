import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cow_characteristics_model.dart';
import '../models/feed_formula_model.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;
  static const String _cowCharacteristicsKey = 'cow_characteristics';
  static const String _feedFormulaKey = 'feed_formula';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setCowCharacteristics(
      CowCharacteristics cowCharacteristics) async {
    final String cowCharacteristicsJson =
        json.encode(cowCharacteristics.toJson());
    return await _prefs?.setString(
            _cowCharacteristicsKey, cowCharacteristicsJson) ??
        false;
  }

  static CowCharacteristics? getCowCharacteristics() {
    final String? cowCharacteristicsJson =
        _prefs?.getString(_cowCharacteristicsKey);
    if (cowCharacteristicsJson != null) {
      final Map<String, dynamic> cowCharacteristicsMap =
          json.decode(cowCharacteristicsJson);
      return CowCharacteristics.fromJson(cowCharacteristicsMap);
    }
    return null;
  }

  static Future<bool> setFeedFormula(FeedFormula feedFormula) async {
    final String feedFormulaJson = json.encode(feedFormula.toJson());
    return await _prefs?.setString(_feedFormulaKey, feedFormulaJson) ?? false;
  }

  static FeedFormula? getFeedFormula() {
    final String? feedFormulaJson = _prefs?.getString(_feedFormulaKey);
    if (feedFormulaJson != null) {
      final Map<String, dynamic> feedFormulaMap = json.decode(feedFormulaJson);
      return FeedFormula.fromJson(feedFormulaMap);
    }
    return null;
  }

  static Future<bool> clearCowCharacteristics() async {
    return await _prefs?.remove(_cowCharacteristicsKey) ?? false;
  }

  static Future<bool> clearFeedFormula() async {
    return await _prefs?.remove(_feedFormulaKey) ?? false;
  }

  static Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }
}
