import 'package:rationapp/models/feed_formula_model.dart';
import 'package:flutter/material.dart';
import '../feed_state.dart';
import 'package:provider/provider.dart';

class FeedCalculator {
  FeedIngredient calculateIngredientValues(
      String id, double weight, bool isFodder, BuildContext context) {
    final feedState = Provider.of<FeedState>(context, listen: false);
    final fodderItems = feedState.availableFodderItems;
    final concentrateItems = feedState.availableConcentrateItems;

    final table = isFodder ? fodderItems : concentrateItems;
    final ingredient = table.firstWhere((item) => item.id == id);

    final dmIntake = ingredient.dmIntake * weight / 100;
    final meIntake = ingredient.meIntake * dmIntake;
    final cost = ingredient.cost * weight;

    double calculateValue(double value) {
      return value * dmIntake / 100;
    }

    return FeedIngredient(
        id: ingredient.id,
        name: ingredient.name,
        weight: weight,
        dmIntake: dmIntake,
        meIntake: meIntake,
        cpIntake: calculateValue(ingredient.cpIntake),
        ndfIntake: calculateValue(ingredient.ndfIntake),
        caIntake: calculateValue(ingredient.caIntake),
        pIntake: calculateValue(ingredient.pIntake),
        cost: cost,
        isFodder: isFodder);
  }
}
