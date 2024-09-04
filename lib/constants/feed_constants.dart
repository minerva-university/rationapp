import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feed_state.dart';
import '../models/feed_formula_model.dart';

class FeedConstants {
  List<FeedIngredient> getFodderOptions(BuildContext context) {
    final fodder =
        Provider.of<FeedState>(context, listen: false).availableFodderItems;
    return [...fodder];
  }

  List<FeedIngredient> getConcentrateOptions(BuildContext context) {
    final concentrate = Provider.of<FeedState>(context, listen: false)
        .availableConcentrateItems;
    return [...concentrate];
  }

  String getFeedIngredientLabel(BuildContext context, String id) {
    final feedState = Provider.of<FeedState>(context, listen: false);
    final allItems = [...feedState.fodderItems, ...feedState.concentrateItems];
    final item = allItems.firstWhere((item) => item.id == id);
    return item.getName(context);
  }
}
