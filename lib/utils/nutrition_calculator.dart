import '../../data/nutrition_tables.dart';
import 'package:flutter/material.dart';

class NutritionCalculator {
  final BuildContext context;

  NutritionCalculator(this.context);
  double calculateDMRequirement(int liveWeight) {
    var matchingRow = NutritionTables(context).weightRequirement.firstWhere(
          (row) => row["weight"] == liveWeight,
          orElse: () => {"dm": 0.0},
        );
    return matchingRow["dm"];
  }

  double calculateMEIntake(int liveWeight, int pregnancy, double volume,
      double milkFat, double milkProtein) {
    double meIntake = 0;

    // Part 1: ME from live weight
    var weightRow = NutritionTables(context).weightRequirement.firstWhere(
          (row) => row["weight"] == liveWeight,
          orElse: () => {"meReq": 0.0},
        );
    meIntake += weightRow["meReq"];

    // Part 2: ME from pregnancy
    var pregnancyRow =
        NutritionTables(context).agePregnancyRequirements.firstWhere(
              (row) => row["pregnancyMonth"] == pregnancy,
              orElse: () => {"meReq": 0.0},
            );
    meIntake += pregnancyRow["meReq"];

    // Part 3: ME from milk production
    if (NutritionTables(context)
        .energyProteinRequirements
        .containsKey(milkFat)) {
      var fatRow = NutritionTables(context).energyProteinRequirements[milkFat]!;
      if (fatRow.containsKey(milkProtein)) {
        double energyProteinFactor = fatRow[milkProtein]!;
        meIntake += volume * energyProteinFactor;
      }
    }

    return meIntake;
  }

  double calculateCPIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq =
        NutritionTables(context).lactationStageRequirements.firstWhere(
              (req) => req["id"].toLowerCase() == lactationStage.toLowerCase(),
              orElse: () => {"proteinReq": 0.0},
            );

    return stageReq["proteinReq"] / 100;
  }

  double calculateCaIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq =
        NutritionTables(context).lactationStageRequirements.firstWhere(
              (req) => req["id"].toLowerCase() == lactationStage.toLowerCase(),
              orElse: () => {"caReq": 0.0},
            );

    return stageReq["caReq"];
  }

  double calculatePIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq =
        NutritionTables(context).lactationStageRequirements.firstWhere(
              (req) => req["id"].toLowerCase() == lactationStage.toLowerCase(),
              orElse: () => {"pReq": 0.0},
            );

    return stageReq["pReq"];
  }
}
