import '../models/cow_characteristics_model.dart';
import '../../utils/nutrition_calculator.dart';
import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';

class CowRequirementsCalculator {
  static void calculateCowRequirements(
      BuildContext context,
      TextEditingController liveWeightController,
      TextEditingController pregnancyController,
      TextEditingController volumeController,
      TextEditingController milkFatController,
      TextEditingController milkProteinController,
      TextEditingController lactationController) {
    int liveWeight = int.tryParse(liveWeightController.text) ?? 0;
    int pregnancy = int.tryParse(pregnancyController.text) ?? 0;
    double volume = double.tryParse(volumeController.text) ?? 0;
    double milkFat = double.tryParse(milkFatController.text) ?? 0;
    double milkProtein = double.tryParse(milkProteinController.text) ?? 0;
    String lactation = lactationController.text;

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
    double cpIntake = NutritionCalculator.calculateCPIntake(
        cowCharacteristics.lactationStage);
    double caIntake = NutritionCalculator.calculateCaIntake(
        cowCharacteristics.lactationStage);
    double pIntake =
        NutritionCalculator.calculatePIntake(cowCharacteristics.lactationStage);

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
          title: const Text('Cow Requirements'),
          content: Text(
            'DM Intake: ${dmIntake.toStringAsFixed(2)} kg/day\nME Intake: ${meIntake.toStringAsFixed(2)} MJ/day\nCP Intake: ${(cpIntake * 100).toStringAsFixed(2)}%\nNDF Intake: ${(ndfIntake).toStringAsFixed(2)}%\nCa Intake: ${(caIntake).toStringAsFixed(2)}%\nP Intake: ${(pIntake).toStringAsFixed(2)}%\nConcentrate Intake: ${(concentrateIntake).toStringAsFixed(2)}%',
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
              child: const Text('Plan feed'),
            ),
          ],
        );
      },
    );
  }
}
