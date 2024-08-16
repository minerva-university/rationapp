import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class NutritionTables {
  final BuildContext context;

  NutritionTables(this.context);

  static final List<Map<String, dynamic>> weightRequirement = [
    {"weight": 100, "meReq": 17.00, "dm": 3.0},
    {"weight": 125, "meReq": 19.06, "dm": 3.75},
    {"weight": 150, "meReq": 22.00, "dm": 4.5},
    {"weight": 175, "meReq": 24.57, "dm": 5.25},
    {"weight": 200, "meReq": 27.00, "dm": 6.0},
    {"weight": 225, "meReq": 29.65, "dm": 6.75},
    {"weight": 250, "meReq": 31.00, "dm": 7.5},
    {"weight": 275, "meReq": 34.52, "dm": 8.25},
    {"weight": 300, "meReq": 36.00, "dm": 9.0},
    {"weight": 325, "meReq": 39.08, "dm": 9.75},
    {"weight": 350, "meReq": 40.00, "dm": 10.5},
    {"weight": 375, "meReq": 43.42, "dm": 11.25},
    {"weight": 400, "meReq": 45.00, "dm": 12.0},
    {"weight": 425, "meReq": 47.76, "dm": 12.75},
    {"weight": 450, "meReq": 49.00, "dm": 13.5},
    {"weight": 475, "meReq": 51.89, "dm": 14.25},
    {"weight": 500, "meReq": 54.00, "dm": 15.0},
    {"weight": 525, "meReq": 56.02, "dm": 15.75},
    {"weight": 550, "meReq": 59.00, "dm": 16.5},
    {"weight": 575, "meReq": 59.77, "dm": 17.25},
    {"weight": 600, "meReq": 63.00, "dm": 18.0},
  ];

  List<Map<String, dynamic>> get lactationStageRequirements {
    return [
      {
        "stage": S.of(context).lactationStageDry,
        "proteinReq": 12,
        "caReq": 0.40,
        "pReq": 0.20
      },
      {
        "stage": S.of(context).lactationStageEarlyLactation,
        "proteinReq": 16,
        "caReq": 0.80,
        "pReq": 0.40
      },
      {
        "stage": S.of(context).lactationStageMidLactation,
        "proteinReq": 14,
        "caReq": 0.70,
        "pReq": 0.35
      },
      {
        "stage": S.of(context).lactationStageLateLactation,
        "proteinReq": 12,
        "caReq": 0.40,
        "pReq": 0.20
      },
    ];
  }

  static final List<Map<String, dynamic>> agePregnancyRequirements = [
    {"pregnancyMonth": 0, "meReq": 0},
    {"pregnancyMonth": 1, "meReq": 0},
    {"pregnancyMonth": 2, "meReq": 0},
    {"pregnancyMonth": 3, "meReq": 0},
    {"pregnancyMonth": 4, "meReq": 0},
    {"pregnancyMonth": 5, "meReq": 0},
    {"pregnancyMonth": 6, "meReq": 8},
    {"pregnancyMonth": 7, "meReq": 10},
    {"pregnancyMonth": 8, "meReq": 15},
    {"pregnancyMonth": 9, "meReq": 20},
  ];

  static final Map<double, Map<double, double>> energyProteinRequirements = {
    3.0: {
      2.6: 4.50,
      2.7: 4.50,
      2.8: 4.50,
      2.9: 4.55,
      3.0: 4.60,
      3.1: 4.65,
      3.2: 4.70,
      3.3: 4.75,
      3.4: 4.80,
      3.5: 4.80,
      3.6: 4.80
    },
    3.1: {
      2.6: 4.55,
      2.7: 4.55,
      2.8: 4.60,
      2.9: 4.60,
      3.0: 4.65,
      3.1: 4.70,
      3.2: 4.75,
      3.3: 4.80,
      3.4: 4.85,
      3.5: 4.85,
      3.6: 4.90
    },
    3.2: {
      2.6: 4.60,
      2.7: 4.65,
      2.8: 4.70,
      2.9: 4.70,
      3.0: 4.70,
      3.1: 4.75,
      3.2: 4.80,
      3.3: 4.85,
      3.4: 4.90,
      3.5: 4.95,
      3.6: 5.00
    },
    3.3: {
      2.6: 4.65,
      2.7: 4.69,
      2.8: 4.73,
      2.9: 4.77,
      3.0: 4.81,
      3.1: 4.85,
      3.2: 4.85,
      3.3: 4.93,
      3.4: 4.95,
      3.5: 5.01,
      3.6: 5.05
    },
    3.4: {
      2.6: 4.70,
      2.7: 4.75,
      2.8: 4.80,
      2.9: 4.85,
      3.0: 4.90,
      3.1: 4.93,
      3.2: 4.90,
      3.3: 4.95,
      3.4: 5.00,
      3.5: 5.09,
      3.6: 5.10
    },
    3.5: {
      2.6: 4.80,
      2.7: 4.84,
      2.8: 4.88,
      2.9: 4.92,
      3.0: 4.96,
      3.1: 5.00,
      3.2: 5.04,
      3.3: 5.08,
      3.4: 5.08,
      3.5: 5.15,
      3.6: 5.16
    },
    3.6: {
      2.6: 4.90,
      2.7: 4.90,
      2.8: 4.90,
      2.9: 5.00,
      3.0: 5.00,
      3.1: 5.08,
      3.2: 5.10,
      3.3: 5.16,
      3.4: 5.10,
      3.5: 5.15,
      3.6: 5.20
    },
    3.7: {
      2.6: 4.95,
      2.7: 4.99,
      2.8: 5.01,
      2.9: 5.07,
      3.0: 5.07,
      3.1: 5.15,
      3.2: 5.13,
      3.3: 5.23,
      3.4: 5.19,
      3.5: 5.20,
      3.6: 5.25
    },
    3.8: {
      2.6: 5.00,
      2.7: 5.07,
      2.8: 5.10,
      2.9: 5.17,
      3.0: 5.10,
      3.1: 5.15,
      3.2: 5.20,
      3.3: 5.33,
      3.4: 5.30,
      3.5: 5.30,
      3.6: 5.30
    },
    3.9: {
      2.6: 5.05,
      2.7: 5.14,
      2.8: 5.11,
      2.9: 5.27,
      3.0: 5.17,
      3.1: 5.20,
      3.2: 5.23,
      3.3: 5.43,
      3.4: 5.29,
      3.5: 5.30,
      3.6: 5.35
    },
    4.0: {
      2.6: 5.10,
      2.7: 5.19,
      2.8: 5.20,
      2.9: 5.19,
      3.0: 5.30,
      3.1: 5.25,
      3.2: 5.30,
      3.3: 5.31,
      3.4: 5.40,
      3.5: 5.42,
      3.6: 5.50
    },
    4.1: {
      2.6: 5.20,
      2.7: 5.24,
      2.8: 5.27,
      2.9: 5.24,
      3.0: 5.34,
      3.1: 5.30,
      3.2: 5.41,
      3.3: 5.36,
      3.4: 5.48,
      3.5: 5.52,
      3.6: 5.55
    },
    4.2: {
      2.6: 5.30,
      2.7: 5.33,
      2.8: 5.30,
      2.9: 5.33,
      3.0: 5.40,
      3.1: 5.39,
      3.2: 5.50,
      3.3: 5.46,
      3.4: 5.50,
      3.5: 5.61,
      3.6: 5.60
    },
    4.3: {
      2.6: 5.35,
      2.7: 5.43,
      2.8: 5.41,
      2.9: 5.43,
      3.0: 5.47,
      3.1: 5.49,
      3.2: 5.53,
      3.3: 5.56,
      3.4: 5.59,
      3.5: 5.71,
      3.6: 5.65
    },
    4.4: {
      2.6: 5.40,
      2.7: 5.45,
      2.8: 5.50,
      2.9: 5.53,
      3.0: 5.50,
      3.1: 5.59,
      3.2: 5.60,
      3.3: 5.63,
      3.4: 5.70,
      3.5: 5.81,
      3.6: 5.70
    },
    4.5: {
      2.6: 5.45,
      2.7: 5.50,
      2.8: 5.52,
      2.9: 5.63,
      3.0: 5.59,
      3.1: 5.69,
      3.2: 5.66,
      3.3: 5.70,
      3.4: 5.73,
      3.5: 5.91,
      3.6: 5.80
    },
    4.6: {
      2.6: 5.50,
      2.7: 5.60,
      2.8: 5.60,
      2.9: 5.72,
      3.0: 5.70,
      3.1: 5.78,
      3.2: 5.70,
      3.3: 5.76,
      3.4: 5.80,
      3.5: 6.00,
      3.6: 5.90
    },
    4.7: {
      2.6: 5.55,
      2.7: 5.60,
      2.8: 5.63,
      2.9: 5.80,
      3.0: 5.80,
      3.1: 5.80,
      3.2: 5.90,
      3.3: 5.83,
      3.4: 5.87,
      3.5: 6.10,
      3.6: 5.95
    },
    4.8: {
      2.6: 5.60,
      2.7: 5.70,
      2.8: 5.70,
      2.9: 5.92,
      3.0: 5.80,
      3.1: 5.87,
      3.2: 5.90,
      3.3: 5.89,
      3.4: 5.90,
      3.5: 6.10,
      3.6: 6.00
    },
    4.9: {
      2.6: 5.70,
      2.7: 5.70,
      2.8: 5.77,
      2.9: 6.02,
      3.0: 5.84,
      3.1: 5.87,
      3.2: 5.90,
      3.3: 5.95,
      3.4: 5.98,
      3.5: 6.10,
      3.6: 6.05
    },
    5.0: {
      2.6: 5.80,
      2.7: 5.80,
      2.8: 5.80,
      2.9: 5.85,
      3.0: 5.90,
      3.1: 5.87,
      3.2: 6.00,
      3.3: 6.02,
      3.4: 6.10,
      3.5: 6.10,
      3.6: 6.10
    },
    5.1: {
      2.6: 5.85,
      2.7: 5.85,
      2.8: 5.92,
      2.9: 5.92,
      3.0: 5.95,
      3.1: 6.00,
      3.2: 6.06,
      3.3: 6.10,
      3.4: 6.13,
      3.5: 6.20,
      3.6: 6.20
    },
    5.2: {
      2.6: 5.90,
      2.7: 5.94,
      2.8: 6.00,
      2.9: 6.02,
      3.0: 6.00,
      3.1: 6.10,
      3.2: 6.10,
      3.3: 6.18,
      3.4: 6.20,
      3.5: 6.26,
      3.6: 6.30
    },
  };

  List<Map<String, dynamic>> get concentrates {
    return [
      {
        "name": S.of(context).concentrateSesameSeedMeal,
        "dm": 92.8,
        "me": 12.5,
        "cp": 44.9,
        "ndf": 24.6,
        "ca": 1.97,
        "p": 1.26,
        "costPerKg": 25
      },
      {
        "name": S.of(context).concentrateMolasses,
        "dm": 80,
        "me": 14,
        "cp": 3,
        "ndf": 1,
        "ca": null,
        "p": null,
        "costPerKg": null
      },
      {
        "name": S.of(context).concentrateMaizeGrain,
        "dm": 90,
        "me": 13,
        "cp": 11,
        "ndf": 10,
        "ca": 0.05,
        "p": 0.3,
        "costPerKg": null
      },
      {
        "name": S.of(context).concentrateSoybeanCake,
        "dm": 90,
        "me": 14,
        "cp": 45,
        "ndf": 20,
        "ca": 0.39,
        "p": 0.69,
        "costPerKg": null
      },
    ];
  }

  List<Map<String, dynamic>> get fodder {
    return [
      {
        "name": S.of(context).fodderGreenMaizeForage,
        "dm": 23.3,
        "me": 9.6,
        "cp": 7.9,
        "ndf": 63.2,
        "ca": 0.36,
        "p": 0.2,
        "costPerKg": 10
      },
      {
        "name": S.of(context).fodderAlfafa,
        "dm": 90.6,
        "me": 8.5,
        "cp": 18.3,
        "ndf": 45.9,
        "ca": 2.21,
        "p": 0.27,
        "costPerKg": 12
      },
      {
        "name": S.of(context).fodderMoringaLeaves,
        "dm": 26.2,
        "me": 10.6,
        "cp": 24.3,
        "ndf": 28.3,
        "ca": 2.65,
        "p": 0.31,
        "costPerKg": 13
      },
      {
        "name": S.of(context).fodderSoyaBeanForage,
        "dm": 24,
        "me": 9.2,
        "cp": 15.7,
        "ndf": 48.1,
        "ca": 1.48,
        "p": 0.27,
        "costPerKg": 15
      },
      {
        "name": S.of(context).fodderGroundnutSeeds,
        "dm": 95.5,
        "me": 18.2,
        "cp": 29.5,
        "ndf": 9.3,
        "ca": 0.08,
        "p": 0.46,
        "costPerKg": 16
      },
      {
        "name": S.of(context).fodderBanannaStalks,
        "dm": 7.2,
        "me": 16.9,
        "cp": 5.1,
        "ndf": 57.5,
        "ca": 0.75,
        "p": 0.29,
        "costPerKg": 18
      },
      {
        "name": S.of(context).fodderBananaLeaves,
        "dm": 20.7,
        "me": 18.1,
        "cp": 9.5,
        "ndf": null,
        "ca": 1.67,
        "p": 0.12,
        "costPerKg": 19
      },
      {
        "name": S.of(context).fodderSorghumForage,
        "dm": 28.1,
        "me": 8.8,
        "cp": 8.2,
        "ndf": 57.9,
        "ca": 0.41,
        "p": 0.2,
        "costPerKg": 21
      },
      {
        "name": S.of(context).fodderSorghumStraw,
        "dm": 93.3,
        "me": 7.3,
        "cp": 3.7,
        "ndf": 76.6,
        "ca": 0.31,
        "p": 0.07,
        "costPerKg": 22
      },
      {
        "name": S.of(context).fodderMaizeSilage,
        "dm": 23.5,
        "me": 10.5,
        "cp": 8.9,
        "ndf": 49.3,
        "ca": 0.21,
        "p": 0.19,
        "costPerKg": 24
      },
      {
        "name": S.of(context).fodderMoringaLeavesFresh,
        "dm": 26.2,
        "me": 10.6,
        "cp": 24.3,
        "ndf": 28.3,
        "ca": 2.65,
        "p": 0.31,
        "costPerKg": 27
      },
      {
        "name": S.of(context).fodderFreshGrass,
        "dm": 20,
        "me": 8,
        "cp": 12,
        "ndf": 60,
        "ca": null,
        "p": null,
        "costPerKg": 10
      },
      {
        "name": S.of(context).fodderRiceHay,
        "dm": 85,
        "me": 6,
        "cp": 6,
        "ndf": 80,
        "ca": null,
        "p": null,
        "costPerKg": 12
      },
      {
        "name": S.of(context).fodderSweetCornTrash,
        "dm": 15,
        "me": 11,
        "cp": 8,
        "ndf": 40,
        "ca": null,
        "p": null,
        "costPerKg": 13
      },
      {
        "name": S.of(context).fodderBeanSilage,
        "dm": 20,
        "me": 9,
        "cp": 25,
        "ndf": 30,
        "ca": null,
        "p": null,
        "costPerKg": 15
      },
      {
        "name": S.of(context).fodderRiceBranA,
        "dm": 90,
        "me": 11,
        "cp": 14,
        "ndf": 27,
        "ca": 0.09,
        "p": 1.79,
        "costPerKg": 16
      },
      {
        "name": S.of(context).fodderRiceBranB,
        "dm": 90,
        "me": 8,
        "cp": 8,
        "ndf": 35,
        "ca": null,
        "p": null,
        "costPerKg": 18
      },
      {
        "name": S.of(context).fodderRejectPotatoes,
        "dm": 15,
        "me": 13,
        "cp": 6,
        "ndf": 20,
        "ca": null,
        "p": null,
        "costPerKg": 19
      },
      {
        "name": S.of(context).fodderCornStover,
        "dm": 23,
        "me": 9,
        "cp": 6,
        "ndf": 50,
        "ca": null,
        "p": null,
        "costPerKg": 21
      },
      {
        "name": S.of(context).fodderBrewersGrain,
        "dm": 80,
        "me": 10,
        "cp": 25,
        "ndf": 40,
        "ca": 0.27,
        "p": 0.57,
        "costPerKg": 22
      },
      {
        "name": S.of(context).fodderSagoChips,
        "dm": 88,
        "me": 13,
        "cp": 2,
        "ndf": 10,
        "ca": null,
        "p": null,
        "costPerKg": 24
      },
      {
        "name": S.of(context).fodderRiceStraw,
        "dm": 90,
        "me": 5,
        "cp": 5,
        "ndf": 80,
        "ca": null,
        "p": null,
        "costPerKg": 27
      },
      {
        "name": S.of(context).fodderDiCalciumPhosphate,
        "dm": 97.5,
        "me": null,
        "cp": null,
        "ndf": null,
        "ca": 23,
        "p": 18,
        "costPerKg": 24
      },
      {
        "name": S.of(context).fodderElephantGrassNapierGrass,
        "dm": 17.9,
        "me": 8.2,
        "cp": 9.7,
        "ndf": 71.5,
        "ca": 3.6,
        "p": 2.9,
        "costPerKg": 24
      },
      {
        "name": S.of(context).fodderElephantGrassHay,
        "dm": 89.3,
        "me": 7.9,
        "cp": 10.3,
        "ndf": 71.1,
        "ca": 2.8,
        "p": 2.3,
        "costPerKg": 27
      },
    ];
  }
}
