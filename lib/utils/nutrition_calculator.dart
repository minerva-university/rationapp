import '../../data/nutrition_tables.dart';

class NutritionCalculator {
  static double calculateDMRequirement(int liveWeight) {
    var matchingRow = NutritionTables.weightRequirement.firstWhere(
      (row) => row["weight"] == liveWeight,
      orElse: () => {"dm": 0.0},
    );
    return matchingRow["dm"];
  }

  static double calculateMEIntake(int liveWeight, int pregnancy, double volume,
      double milkFat, double milkProtein) {
    double meIntake = 0;

    // Part 1: ME from live weight
    var weightRow = NutritionTables.weightRequirement.firstWhere(
      (row) => row["weight"] == liveWeight,
      orElse: () => {"meReq": 0.0},
    );
    meIntake += weightRow["meReq"];

    // Part 2: ME from pregnancy
    var pregnancyRow = NutritionTables.agePregnancyRequirements.firstWhere(
      (row) => row["pregnancyMonth"] == pregnancy,
      orElse: () => {"meReq": 0.0},
    );
    meIntake += pregnancyRow["meReq"];

    // Part 3: ME from milk production
    if (NutritionTables.energyProteinRequirements.containsKey(milkFat)) {
      var fatRow = NutritionTables.energyProteinRequirements[milkFat]!;
      if (fatRow.containsKey(milkProtein)) {
        double energyProteinFactor = fatRow[milkProtein]!;
        meIntake += volume * energyProteinFactor;
      }
    }

    return meIntake;
  }

  static double calculateCPIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq = NutritionTables.lactationStageRequirements.firstWhere(
      (req) => req["stage"].toLowerCase() == lactationStage.toLowerCase(),
      orElse: () => {"proteinReq": 0.0},
    );

    return stageReq["proteinReq"] / 100;
  }

  static double calculateCaIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq = NutritionTables.lactationStageRequirements.firstWhere(
      (req) => req["stage"].toLowerCase() == lactationStage.toLowerCase(),
      orElse: () => {"caReq": 0.0},
    );

    return stageReq["caReq"];
  }

  static double calculatePIntake(String lactationStage) {
    if (lactationStage.isEmpty) {
      return 0.0;
    }

    var stageReq = NutritionTables.lactationStageRequirements.firstWhere(
      (req) => req["stage"].toLowerCase() == lactationStage.toLowerCase(),
      orElse: () => {"pReq": 0.0},
    );

    return stageReq["pReq"];
  }
}
