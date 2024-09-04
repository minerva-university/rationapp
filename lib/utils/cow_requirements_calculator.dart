import '../models/cow_characteristics_model.dart';
import '../../utils/nutrition_calculator.dart';
import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';
import '../generated/l10n.dart';

class CowRequirementsCalculator {
  static void calculateCowRequirements(
      BuildContext context,
      TextEditingController liveWeightController,
      TextEditingController pregnancyController,
      TextEditingController volumeController,
      TextEditingController milkFatController,
      TextEditingController milkProteinController,
      String lactationStageId) {
    int liveWeight = int.tryParse(liveWeightController.text) ?? 0;
    int pregnancy = int.tryParse(pregnancyController.text) ?? 0;
    double volume = double.tryParse(volumeController.text) ?? 0;
    double milkFat = double.tryParse(milkFatController.text) ?? 0;
    double milkProtein = double.tryParse(milkProteinController.text) ?? 0;
    String lactation = lactationStageId;

    CowCharacteristics cowCharacteristics = CowCharacteristics(
      liveWeight: liveWeight,
      pregnancyMonths: pregnancy,
      milkVolume: volume,
      milkFat: milkFat,
      milkProtein: milkProtein,
      lactationStage: lactation,
    );

    double dmIntake = NutritionCalculator.calculateDMRequirement(
        cowCharacteristics.liveWeight);
    double meIntake = NutritionCalculator.calculateMEIntake(
        cowCharacteristics.liveWeight,
        cowCharacteristics.pregnancyMonths,
        cowCharacteristics.milkVolume,
        cowCharacteristics.milkFat,
        cowCharacteristics.milkProtein);
    double cpIntake = NutritionCalculator(context)
        .calculateCPIntake(cowCharacteristics.lactationStage);
    double caIntake = NutritionCalculator(context)
        .calculateCaIntake(cowCharacteristics.lactationStage);
    double pIntake = NutritionCalculator(context)
        .calculatePIntake(cowCharacteristics.lactationStage);

    double ndfIntake = 40.0;
    double concentrateIntake = 60.0;

    CowRequirements cowRequirements = CowRequirements(
        dmIntake: dmIntake,
        meIntake: meIntake,
        cpIntake: cpIntake,
        ndfIntake: ndfIntake,
        caIntake: caIntake,
        pIntake: pIntake,
        concentrateIntake: concentrateIntake);

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).cowRequirements),
          content: Text(
            '${S.of(context).dmIntakeLabel}: ${S.of(context).kgPerDay(cowRequirements.dmIntake.toStringAsFixed(2))}\n'
            '${S.of(context).meIntakeLabel}: ${S.of(context).mjPerDayValue(cowRequirements.meIntake.toStringAsFixed(2))}\n'
            '${S.of(context).cpIntakeLabel}: ${S.of(context).percentageValue((cowRequirements.cpIntake * 100).toStringAsFixed(2))}\n'
            '${S.of(context).ndfIntakeLabel}: ${S.of(context).percentageValue(cowRequirements.ndfIntake.toStringAsFixed(2))}\n'
            '${S.of(context).caIntakeLabel}: ${S.of(context).percentageValue(cowRequirements.caIntake.toStringAsFixed(2))}\n'
            '${S.of(context).pIntakeLabel}: ${S.of(context).percentageValue(cowRequirements.pIntake.toStringAsFixed(2))}\n'
            '${S.of(context).concentrateIntakeLabel}: ${S.of(context).percentageValue(cowRequirements.concentrateIntake.toStringAsFixed(2))}',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/feed_formula',
                  arguments: {
                    'cowCharacteristics': cowCharacteristics,
                    'cowRequirements': cowRequirements,
                  },
                );
              },
              child: Text(S.of(context).planFeed),
            ),
          ],
        );
      },
    );
  }
}
