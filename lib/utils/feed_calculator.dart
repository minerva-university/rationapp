import 'package:rationapp/models/feed_formula_model.dart';
import 'package:flutter/material.dart';
import '../feed_state.dart';
import 'package:provider/provider.dart';

class FeedCalculator {
  FeedIngredient calculateIngredientValues(
      String name, double weight, bool isFodder, BuildContext context) {
    final feedState = Provider.of<FeedState>(context, listen: false);
    final fodderItems = feedState.availableFodderItems;
    final concentrateItems = feedState.availableConcentrateItems;

    final table = isFodder ? fodderItems : concentrateItems;
    final ingredient = table
        .firstWhere((item) => item['name'].toLowerCase() == name.toLowerCase());

    final dmIntake =
        ((ingredient['dmIntake'])?.toDouble() ?? 0.0) * weight / 100;
    final meIntake = ((ingredient['meIntake'])?.toDouble() ?? 0.0) * dmIntake;
    final cost = ((ingredient['cost'])?.toDouble() ?? 0.0) * weight;

    double calculateValue(String key) {
      return ((ingredient[key])?.toDouble() ?? 0.0) * dmIntake / 100;
    }

    return FeedIngredient(
        id: ingredient['id'],
        name: name,
        weight: weight,
        dmIntake: dmIntake,
        meIntake: meIntake,
        cpIntake: calculateValue('cpIntake'),
        ndfIntake: calculateValue('ndfIntake'),
        caIntake: calculateValue('caIntake'),
        pIntake: calculateValue('pIntake'),
        cost: cost,
        isFodder: isFodder);
  }
}
