// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Please fill in all fields before viewing requirements.`
  String get pleaseFillInAllFieldsBeforeViewingRequirements {
    return Intl.message(
      'Please fill in all fields before viewing requirements.',
      name: 'pleaseFillInAllFieldsBeforeViewingRequirements',
      desc: 'Error message shown when not all required fields are filled',
      args: [],
    );
  }

  /// `Cow Characteristics`
  String get cowCharacteristics {
    return Intl.message(
      'Cow Characteristics',
      name: 'cowCharacteristics',
      desc: 'Title for the cow characteristics section',
      args: [],
    );
  }

  /// `Milk Yield`
  String get milkYield {
    return Intl.message(
      'Milk Yield',
      name: 'milkYield',
      desc: 'Label for milk yield information',
      args: [],
    );
  }

  /// `View Cow requirements`
  String get viewCowRequirements {
    return Intl.message(
      'View Cow requirements',
      name: 'viewCowRequirements',
      desc: 'Button text to view cow requirements',
      args: [],
    );
  }

  /// `Feed Formula`
  String get feedFormula {
    return Intl.message(
      'Feed Formula',
      name: 'feedFormula',
      desc: 'Title for the feed formula section',
      args: [],
    );
  }

  /// `Add Fodder`
  String get addFodder {
    return Intl.message(
      'Add Fodder',
      name: 'addFodder',
      desc: 'Button text to add fodder to the feed formula',
      args: [],
    );
  }

  /// `Add Concentrate`
  String get addConcentrate {
    return Intl.message(
      'Add Concentrate',
      name: 'addConcentrate',
      desc: 'Button text to add concentrate to the feed formula',
      args: [],
    );
  }

  /// `Concentrate`
  String get concentrate {
    return Intl.message(
      'Concentrate',
      name: 'concentrate',
      desc: 'Label for concentrate feed type',
      args: [],
    );
  }

  /// `Totals`
  String get totals {
    return Intl.message(
      'Totals',
      name: 'totals',
      desc: 'Label for the totals section in feed formula',
      args: [],
    );
  }

  /// `Fodder`
  String get fodder {
    return Intl.message(
      'Fodder',
      name: 'fodder',
      desc: 'Label for fodder feed type',
      args: [],
    );
  }

  /// `Cow Requirements`
  String get cowRequirements {
    return Intl.message(
      'Cow Requirements',
      name: 'cowRequirements',
      desc: 'Title for the cow requirements section',
      args: [],
    );
  }

  /// `All {type} options have been added.`
  String allOptionsHaveBeenAdded(Object type) {
    return Intl.message(
      'All $type options have been added.',
      name: 'allOptionsHaveBeenAdded',
      desc: 'Message when all options of a type have been added',
      args: [type],
    );
  }

  /// `Feeding Guidelines`
  String get feedingGuidelines {
    return Intl.message(
      'Feeding Guidelines',
      name: 'feedingGuidelines',
      desc: 'Feeding guidelines label',
      args: [],
    );
  }

  /// `{value} kg`
  String kgValue(Object value) {
    return Intl.message(
      '$value kg',
      name: 'kgValue',
      desc: 'kg unit',
      args: [value],
    );
  }

  /// `{value} kg/day`
  String kgPerDay(Object value) {
    return Intl.message(
      '$value kg/day',
      name: 'kgPerDay',
      desc: 'Format for kg per day values',
      args: [value],
    );
  }

  /// `{value} MJ/day`
  String mjPerDayValue(Object value) {
    return Intl.message(
      '$value MJ/day',
      name: 'mjPerDayValue',
      desc: 'MJ/day unit',
      args: [value],
    );
  }

  /// `{value}%`
  String percentageValue(Object value) {
    return Intl.message(
      '$value%',
      name: 'percentageValue',
      desc: 'Generic percentage value',
      args: [value],
    );
  }

  /// `Dry Matter Intake`
  String get dryMatterIntakeLabel {
    return Intl.message(
      'Dry Matter Intake',
      name: 'dryMatterIntakeLabel',
      desc: 'Label for dry matter intake in feeding guidelines',
      args: [],
    );
  }

  /// `ME Intake`
  String get meIntakeLabel {
    return Intl.message(
      'ME Intake',
      name: 'meIntakeLabel',
      desc: 'Label for ME intake in feeding guidelines',
      args: [],
    );
  }

  /// `Crude Protein`
  String get crudeProteinLabel {
    return Intl.message(
      'Crude Protein',
      name: 'crudeProteinLabel',
      desc: 'Label for crude protein in feeding guidelines',
      args: [],
    );
  }

  /// `NDF`
  String get ndfLabel {
    return Intl.message(
      'NDF',
      name: 'ndfLabel',
      desc: 'Label for NDF in feeding guidelines',
      args: [],
    );
  }

  /// `Ca Intake`
  String get caIntakeLabel {
    return Intl.message(
      'Ca Intake',
      name: 'caIntakeLabel',
      desc: 'Label for calcium intake in feeding guidelines',
      args: [],
    );
  }

  /// `P Intake`
  String get pIntakeLabel {
    return Intl.message(
      'P Intake',
      name: 'pIntakeLabel',
      desc: 'Label for phosphorus intake in feeding guidelines',
      args: [],
    );
  }

  /// `Period`
  String get period {
    return Intl.message(
      'Period',
      name: 'period',
      desc: 'Period label',
      args: [],
    );
  }

  /// `Early Lactation Feeding`
  String get earlyLactationFeeding {
    return Intl.message(
      'Early Lactation Feeding',
      name: 'earlyLactationFeeding',
      desc: 'Title for early lactation feeding guidelines',
      args: [],
    );
  }

  /// `Early Lactation (14-100 days)`
  String get earlyLactationPeriod {
    return Intl.message(
      'Early Lactation (14-100 days)',
      name: 'earlyLactationPeriod',
      desc: 'Period description for early lactation',
      args: [],
    );
  }

  /// `Mid Lactation Feeding`
  String get midLactationFeeding {
    return Intl.message(
      'Mid Lactation Feeding',
      name: 'midLactationFeeding',
      desc: 'Title for mid lactation feeding guidelines',
      args: [],
    );
  }

  /// `Mid lactation (100 to 200 days)`
  String get midLactationPeriod {
    return Intl.message(
      'Mid lactation (100 to 200 days)',
      name: 'midLactationPeriod',
      desc: 'Period description for mid lactation',
      args: [],
    );
  }

  /// `Late Lactation Feeding`
  String get lateLactationFeeding {
    return Intl.message(
      'Late Lactation Feeding',
      name: 'lateLactationFeeding',
      desc: 'Title for late lactation feeding guidelines',
      args: [],
    );
  }

  /// `Late Lactation (>200 days)`
  String get lateLactationPeriod {
    return Intl.message(
      'Late Lactation (>200 days)',
      name: 'lateLactationPeriod',
      desc: 'Period description for late lactation',
      args: [],
    );
  }

  /// `Dry Cow Feeding`
  String get dryCowFeeding {
    return Intl.message(
      'Dry Cow Feeding',
      name: 'dryCowFeeding',
      desc: 'Title for dry cow feeding guidelines',
      args: [],
    );
  }

  /// `Due to calve in 45 to 60 days`
  String get dryCowPeriod {
    return Intl.message(
      'Due to calve in 45 to 60 days',
      name: 'dryCowPeriod',
      desc: 'Period description for dry cow feeding',
      args: [],
    );
  }

  /// `Plan feed`
  String get planFeed {
    return Intl.message(
      'Plan feed',
      name: 'planFeed',
      desc: 'Button text to plan feed',
      args: [],
    );
  }

  /// `DM Intake`
  String get dmIntakeLabel {
    return Intl.message(
      'DM Intake',
      name: 'dmIntakeLabel',
      desc: 'Label for Dry Matter Intake',
      args: [],
    );
  }

  /// `CP Intake`
  String get cpIntakeLabel {
    return Intl.message(
      'CP Intake',
      name: 'cpIntakeLabel',
      desc: 'Label for Crude Protein Intake',
      args: [],
    );
  }

  /// `NDF Intake`
  String get ndfIntakeLabel {
    return Intl.message(
      'NDF Intake',
      name: 'ndfIntakeLabel',
      desc: 'Label for Neutral Detergent Fiber Intake',
      args: [],
    );
  }

  /// `Concentrate Intake`
  String get concentrateIntakeLabel {
    return Intl.message(
      'Concentrate Intake',
      name: 'concentrateIntakeLabel',
      desc: 'Label for Concentrate Intake',
      args: [],
    );
  }

  /// `Select Ration Ingredient`
  String get selectRationIngredient {
    return Intl.message(
      'Select Ration Ingredient',
      name: 'selectRationIngredient',
      desc: 'Hint text for selecting a ration ingredient',
      args: [],
    );
  }

  /// `Fresh feed intake (kg/d)`
  String get freshFeedIntake {
    return Intl.message(
      'Fresh feed intake (kg/d)',
      name: 'freshFeedIntake',
      desc: 'Label for fresh feed intake input',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Text for cancel button',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: 'Text for add button',
      args: [],
    );
  }

  /// `Choose fodder`
  String get chooseFodder {
    return Intl.message(
      'Choose fodder',
      name: 'chooseFodder',
      desc: 'Default option for fodder dropdown',
      args: [],
    );
  }

  /// `Choose concentrate`
  String get chooseConcentrate {
    return Intl.message(
      'Choose concentrate',
      name: 'chooseConcentrate',
      desc: 'Default option for concentrate dropdown',
      args: [],
    );
  }

  /// `Please fill in all fields.`
  String get pleaseAllFields {
    return Intl.message(
      'Please fill in all fields.',
      name: 'pleaseAllFields',
      desc: 'Error message when fields are not filled',
      args: [],
    );
  }

  /// `DM Intake\n(kg/day)`
  String get dmIntakeLabelWithUnit {
    return Intl.message(
      'DM Intake\n(kg/day)',
      name: 'dmIntakeLabelWithUnit',
      desc: 'Label for Dry Matter Intake in kg per day',
      args: [],
    );
  }

  /// `ME Intake\n(MJ/day)`
  String get meIntakeLabelWithUnit {
    return Intl.message(
      'ME Intake\n(MJ/day)',
      name: 'meIntakeLabelWithUnit',
      desc: 'Label for Metabolizable Energy Intake in MJ per day',
      args: [],
    );
  }

  /// `CP Intake\n(%)`
  String get cpIntakeLabelWithUnit {
    return Intl.message(
      'CP Intake\n(%)',
      name: 'cpIntakeLabelWithUnit',
      desc: 'Label for Crude Protein Intake in percentage',
      args: [],
    );
  }

  /// `NDF Intake\n(%)`
  String get ndfIntakeLabelWithUnit {
    return Intl.message(
      'NDF Intake\n(%)',
      name: 'ndfIntakeLabelWithUnit',
      desc: 'Label for Neutral Detergent Fiber Intake in percentage',
      args: [],
    );
  }

  /// `Ca Intake\n(%)`
  String get caIntakeLabelWithUnit {
    return Intl.message(
      'Ca Intake\n(%)',
      name: 'caIntakeLabelWithUnit',
      desc: 'Label for Calcium Intake in percentage',
      args: [],
    );
  }

  /// `P Intake\n(%)`
  String get pIntakeLabelWithUnit {
    return Intl.message(
      'P Intake\n(%)',
      name: 'pIntakeLabelWithUnit',
      desc: 'Label for Phosphorus Intake in percentage',
      args: [],
    );
  }

  /// `Concentrate Intake\n(%)`
  String get concentrateIntakeLabelWithUnit {
    return Intl.message(
      'Concentrate Intake\n(%)',
      name: 'concentrateIntakeLabelWithUnit',
      desc: 'Label for Concentrate Intake in percentage',
      args: [],
    );
  }

  /// `Live weight (kg)`
  String get liveWeight {
    return Intl.message(
      'Live weight (kg)',
      name: 'liveWeight',
      desc: 'Label for live weight input',
      args: [],
    );
  }

  /// `Pregnancy (mth)`
  String get pregnancy {
    return Intl.message(
      'Pregnancy (mth)',
      name: 'pregnancy',
      desc: 'Label for pregnancy input',
      args: [],
    );
  }

  /// `Milk volume per day (kg)`
  String get milkVolumePerDay {
    return Intl.message(
      'Milk volume per day (kg)',
      name: 'milkVolumePerDay',
      desc: 'Label for daily milk volume input',
      args: [],
    );
  }

  /// `Milk fat (%)`
  String get milkFat {
    return Intl.message(
      'Milk fat (%)',
      name: 'milkFat',
      desc: 'Label for milk fat percentage input',
      args: [],
    );
  }

  /// `Milk protein (%)`
  String get milkProtein {
    return Intl.message(
      'Milk protein (%)',
      name: 'milkProtein',
      desc: 'Label for milk protein percentage input',
      args: [],
    );
  }

  /// `Lactation stage`
  String get lactationStage {
    return Intl.message(
      'Lactation stage',
      name: 'lactationStage',
      desc: 'Label for lactation stage input',
      args: [],
    );
  }

  /// `Ingredient`
  String get ingredientLabel {
    return Intl.message(
      'Ingredient',
      name: 'ingredientLabel',
      desc: 'Label for the ingredient column',
      args: [],
    );
  }

  /// `Fresh feed\nintake (kg/d)`
  String get freshFeedIntakeLabel {
    return Intl.message(
      'Fresh feed\nintake (kg/d)',
      name: 'freshFeedIntakeLabel',
      desc: 'Label for the fresh feed intake column',
      args: [],
    );
  }

  /// `CP Intake\n(kg/d)`
  String get cpIntakeLabelKgPerD {
    return Intl.message(
      'CP Intake\n(kg/d)',
      name: 'cpIntakeLabelKgPerD',
      desc: 'Label for the crude protein intake column',
      args: [],
    );
  }

  /// `NDF Intake\n(kg/d)`
  String get ndfIntakeLabelKgPerD {
    return Intl.message(
      'NDF Intake\n(kg/d)',
      name: 'ndfIntakeLabelKgPerD',
      desc: 'Label for the neutral detergent fiber intake column',
      args: [],
    );
  }

  /// `Ca Intake\n(kg/d)`
  String get caIntakeLabelKgPerD {
    return Intl.message(
      'Ca Intake\n(kg/d)',
      name: 'caIntakeLabelKgPerD',
      desc: 'Label for the calcium intake column',
      args: [],
    );
  }

  /// `P Intake\n(kg/d)`
  String get pIntakeLabelKgPerD {
    return Intl.message(
      'P Intake\n(kg/d)',
      name: 'pIntakeLabelKgPerD',
      desc: 'Label for the phosphorus intake column',
      args: [],
    );
  }

  /// `Cost\n(ERN)`
  String get costLabel {
    return Intl.message(
      'Cost\n(ERN)',
      name: 'costLabel',
      desc: 'Label for the cost column',
      args: [],
    );
  }

  /// `Dry`
  String get lactationStageDry {
    return Intl.message(
      'Dry',
      name: 'lactationStageDry',
      desc: 'Lactation stage: Dry',
      args: [],
    );
  }

  /// `Early lactation`
  String get lactationStageEarlyLactation {
    return Intl.message(
      'Early lactation',
      name: 'lactationStageEarlyLactation',
      desc: 'Lactation stage: Early lactation',
      args: [],
    );
  }

  /// `Mid lactation`
  String get lactationStageMidLactation {
    return Intl.message(
      'Mid lactation',
      name: 'lactationStageMidLactation',
      desc: 'Lactation stage: Mid lactation',
      args: [],
    );
  }

  /// `Late lactation`
  String get lactationStageLateLactation {
    return Intl.message(
      'Late lactation',
      name: 'lactationStageLateLactation',
      desc: 'Lactation stage: Late lactation',
      args: [],
    );
  }

  /// `sesame seed meal`
  String get concentrateSesameSeedMeal {
    return Intl.message(
      'sesame seed meal',
      name: 'concentrateSesameSeedMeal',
      desc: 'Concentrate: sesame seed meal',
      args: [],
    );
  }

  /// `Molasses`
  String get concentrateMolasses {
    return Intl.message(
      'Molasses',
      name: 'concentrateMolasses',
      desc: 'Concentrate: Molasses',
      args: [],
    );
  }

  /// `Maize grain`
  String get concentrateMaizeGrain {
    return Intl.message(
      'Maize grain',
      name: 'concentrateMaizeGrain',
      desc: 'Concentrate: Maize grain',
      args: [],
    );
  }

  /// `Soybean cake`
  String get concentrateSoybeanCake {
    return Intl.message(
      'Soybean cake',
      name: 'concentrateSoybeanCake',
      desc: 'Concentrate: Soybean cake',
      args: [],
    );
  }

  /// `Wheat bran`
  String get concentrateWheatBran {
    return Intl.message(
      'Wheat bran',
      name: 'concentrateWheatBran',
      desc: 'Concentrate: Wheat bran',
      args: [],
    );
  }

  /// `Sorghum grain`
  String get concentrateSorghumGrain {
    return Intl.message(
      'Sorghum grain',
      name: 'concentrateSorghumGrain',
      desc: 'Concentrate: Sorghum grain',
      args: [],
    );
  }

  /// `Pearl millet grain`
  String get concentratePearlMilletGrain {
    return Intl.message(
      'Pearl millet grain',
      name: 'concentratePearlMilletGrain',
      desc: 'Concentrate: Pearl millet grain',
      args: [],
    );
  }

  /// `Groundnut meal`
  String get concentrateGroundnutMeal {
    return Intl.message(
      'Groundnut meal',
      name: 'concentrateGroundnutMeal',
      desc: 'Concentrate: Groundnut meal',
      args: [],
    );
  }

  /// `Chickpea meal`
  String get concentrateChickpeaMeal {
    return Intl.message(
      'Chickpea meal',
      name: 'concentrateChickpeaMeal',
      desc: 'Concentrate: Chickpea meal',
      args: [],
    );
  }

  /// `Maize bran`
  String get concentrateMaizeBran {
    return Intl.message(
      'Maize bran',
      name: 'concentrateMaizeBran',
      desc: 'Concentrate: Maize bran',
      args: [],
    );
  }

  /// `Wheat grain`
  String get concentrateWheatGrain {
    return Intl.message(
      'Wheat grain',
      name: 'concentrateWheatGrain',
      desc: 'Concentrate: Wheat grain',
      args: [],
    );
  }

  /// `Soybean meal`
  String get concentrateSoybeanMeal {
    return Intl.message(
      'Soybean meal',
      name: 'concentrateSoybeanMeal',
      desc: 'Concentrate: Soybean meal',
      args: [],
    );
  }

  /// `Soybean hulls`
  String get concentrateSoybeanHulls {
    return Intl.message(
      'Soybean hulls',
      name: 'concentrateSoybeanHulls',
      desc: 'Concentrate: Soybean hulls',
      args: [],
    );
  }

  /// `Soybean oil`
  String get concentrateSoybeanOil {
    return Intl.message(
      'Soybean oil',
      name: 'concentrateSoybeanOil',
      desc: 'Concentrate: Soybean oil',
      args: [],
    );
  }

  /// `Brewers by-product`
  String get concentrateBrewersByProduct {
    return Intl.message(
      'Brewers by-product',
      name: 'concentrateBrewersByProduct',
      desc: 'Concentrate: Brewers by-product',
      args: [],
    );
  }

  /// `Mineral lick`
  String get concentrateMineralLick {
    return Intl.message(
      'Mineral lick',
      name: 'concentrateMineralLick',
      desc: 'Concentrate: Mineral lick',
      args: [],
    );
  }

  /// `Dry bread`
  String get concentrateDryBread {
    return Intl.message(
      'Dry bread',
      name: 'concentrateDryBread',
      desc: 'Concentrate: Dry bread',
      args: [],
    );
  }

  /// `Sorghum brewers grain fresh`
  String get concentrateSorghumBrewersGrainFresh {
    return Intl.message(
      'Sorghum brewers grain fresh',
      name: 'concentrateSorghumBrewersGrainFresh',
      desc: 'Concentrate: Sorghum brewers grain fresh',
      args: [],
    );
  }

  /// `Salt`
  String get concentrateSalt {
    return Intl.message(
      'Salt',
      name: 'concentrateSalt',
      desc: 'Concentrate: Salt',
      args: [],
    );
  }

  /// `green maize forage`
  String get fodderGreenMaizeForage {
    return Intl.message(
      'green maize forage',
      name: 'fodderGreenMaizeForage',
      desc: 'Fodder: green maize forage',
      args: [],
    );
  }

  /// `alfafa`
  String get fodderAlfafa {
    return Intl.message(
      'alfafa',
      name: 'fodderAlfafa',
      desc: 'Fodder: alfafa',
      args: [],
    );
  }

  /// `moringa leaves`
  String get fodderMoringaLeaves {
    return Intl.message(
      'moringa leaves',
      name: 'fodderMoringaLeaves',
      desc: 'Fodder: moringa leaves',
      args: [],
    );
  }

  /// `soya bean forage`
  String get fodderSoyaBeanForage {
    return Intl.message(
      'soya bean forage',
      name: 'fodderSoyaBeanForage',
      desc: 'Fodder: soya bean forage',
      args: [],
    );
  }

  /// `groundnut seeds`
  String get fodderGroundnutSeeds {
    return Intl.message(
      'groundnut seeds',
      name: 'fodderGroundnutSeeds',
      desc: 'Fodder: groundnut seeds',
      args: [],
    );
  }

  /// `bananna stalks`
  String get fodderBanannaStalks {
    return Intl.message(
      'bananna stalks',
      name: 'fodderBanannaStalks',
      desc: 'Fodder: bananna stalks',
      args: [],
    );
  }

  /// `banana leaves`
  String get fodderBananaLeaves {
    return Intl.message(
      'banana leaves',
      name: 'fodderBananaLeaves',
      desc: 'Fodder: banana leaves',
      args: [],
    );
  }

  /// `sorghum forage`
  String get fodderSorghumForage {
    return Intl.message(
      'sorghum forage',
      name: 'fodderSorghumForage',
      desc: 'Fodder: sorghum forage',
      args: [],
    );
  }

  /// `sorghum straw`
  String get fodderSorghumStraw {
    return Intl.message(
      'sorghum straw',
      name: 'fodderSorghumStraw',
      desc: 'Fodder: sorghum straw',
      args: [],
    );
  }

  /// `maize silage`
  String get fodderMaizeSilage {
    return Intl.message(
      'maize silage',
      name: 'fodderMaizeSilage',
      desc: 'Fodder: maize silage',
      args: [],
    );
  }

  /// `moringa leaves fresh`
  String get fodderMoringaLeavesFresh {
    return Intl.message(
      'moringa leaves fresh',
      name: 'fodderMoringaLeavesFresh',
      desc: 'Fodder: moringa leaves fresh',
      args: [],
    );
  }

  /// `Fresh grass`
  String get fodderFreshGrass {
    return Intl.message(
      'Fresh grass',
      name: 'fodderFreshGrass',
      desc: 'Fodder: Fresh grass',
      args: [],
    );
  }

  /// `Rice hay`
  String get fodderRiceHay {
    return Intl.message(
      'Rice hay',
      name: 'fodderRiceHay',
      desc: 'Fodder: Rice hay',
      args: [],
    );
  }

  /// `Sweet corn trash`
  String get fodderSweetCornTrash {
    return Intl.message(
      'Sweet corn trash',
      name: 'fodderSweetCornTrash',
      desc: 'Fodder: Sweet corn trash',
      args: [],
    );
  }

  /// `Bean silage`
  String get fodderBeanSilage {
    return Intl.message(
      'Bean silage',
      name: 'fodderBeanSilage',
      desc: 'Fodder: Bean silage',
      args: [],
    );
  }

  /// `Rice bran A`
  String get fodderRiceBranA {
    return Intl.message(
      'Rice bran A',
      name: 'fodderRiceBranA',
      desc: 'Fodder: Rice bran A',
      args: [],
    );
  }

  /// `Rice bran B`
  String get fodderRiceBranB {
    return Intl.message(
      'Rice bran B',
      name: 'fodderRiceBranB',
      desc: 'Fodder: Rice bran B',
      args: [],
    );
  }

  /// `Reject potatoes`
  String get fodderRejectPotatoes {
    return Intl.message(
      'Reject potatoes',
      name: 'fodderRejectPotatoes',
      desc: 'Fodder: Reject potatoes',
      args: [],
    );
  }

  /// `Corn stover`
  String get fodderCornStover {
    return Intl.message(
      'Corn stover',
      name: 'fodderCornStover',
      desc: 'Fodder: Corn stover',
      args: [],
    );
  }

  /// `Brewers grain`
  String get fodderBrewersGrain {
    return Intl.message(
      'Brewers grain',
      name: 'fodderBrewersGrain',
      desc: 'Fodder: Brewers grain',
      args: [],
    );
  }

  /// `Sago chips`
  String get fodderSagoChips {
    return Intl.message(
      'Sago chips',
      name: 'fodderSagoChips',
      desc: 'Fodder: Sago chips',
      args: [],
    );
  }

  /// `Rice straw`
  String get fodderRiceStraw {
    return Intl.message(
      'Rice straw',
      name: 'fodderRiceStraw',
      desc: 'Fodder: Rice straw',
      args: [],
    );
  }

  /// `Di-calcium phosphate`
  String get fodderDiCalciumPhosphate {
    return Intl.message(
      'Di-calcium phosphate',
      name: 'fodderDiCalciumPhosphate',
      desc: 'Fodder: Di-calcium phosphate',
      args: [],
    );
  }

  /// `elephant grass/Napier grass`
  String get fodderElephantGrassNapierGrass {
    return Intl.message(
      'elephant grass/Napier grass',
      name: 'fodderElephantGrassNapierGrass',
      desc: 'Fodder: elephant grass/Napier grass',
      args: [],
    );
  }

  /// `elephant grass hay`
  String get fodderElephantGrassHay {
    return Intl.message(
      'elephant grass hay',
      name: 'fodderElephantGrassHay',
      desc: 'Fodder: elephant grass hay',
      args: [],
    );
  }

  /// `Choose live weight (kg)`
  String get chooseLiveWeightKg {
    return Intl.message(
      'Choose live weight (kg)',
      name: 'chooseLiveWeightKg',
      desc: 'Choose live weight (kg) default selected',
      args: [],
    );
  }

  /// `Choose pregnancy month`
  String get choosePregnancyMonth {
    return Intl.message(
      'Choose pregnancy month',
      name: 'choosePregnancyMonth',
      desc: 'Choose pregnancy month default selected',
      args: [],
    );
  }

  /// `Choose milk fat %`
  String get chooseMilkFat {
    return Intl.message(
      'Choose milk fat %',
      name: 'chooseMilkFat',
      desc: 'Choose milk fat % default selected',
      args: [],
    );
  }

  /// `Choose milk protein %`
  String get chooseMilkProtein {
    return Intl.message(
      'Choose milk protein %',
      name: 'chooseMilkProtein',
      desc: 'Choose milk protein % default selected',
      args: [],
    );
  }

  /// `Choose lactation stage`
  String get chooseLactationStage {
    return Intl.message(
      'Choose lactation stage',
      name: 'chooseLactationStage',
      desc: 'Choose lactation stage default selected',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '\'Choose\' For checking Cow Characteristic\'s form validity',
      args: [],
    );
  }

  /// `Prices`
  String get prices {
    return Intl.message(
      'Prices',
      name: 'prices',
      desc: 'Label for the prices page',
      args: [],
    );
  }

  /// `Cost/kg`
  String get costPerKg {
    return Intl.message(
      'Cost/kg',
      name: 'costPerKg',
      desc: 'Label for the cost per kg input',
      args: [],
    );
  }

  /// `Feed Prices and Availability`
  String get feedPricesAndAvailability {
    return Intl.message(
      'Feed Prices and Availability',
      name: 'feedPricesAndAvailability',
      desc: 'Label for the feed prices and availability page',
      args: [],
    );
  }

  /// `Get translation`
  String getTranslation(String key) {
    switch (key) {
      case 'concentrateSesameSeedMeal':
        return concentrateSesameSeedMeal;
      case 'concentrateMolasses':
        return concentrateMolasses;
      case 'concentrateMaizeGrain':
        return concentrateMaizeGrain;
      case 'concentrateSoybeanCake':
        return concentrateSoybeanCake;
      case 'fodderGreenMaizeForage':
        return fodderGreenMaizeForage;
      case 'fodderAlfafa':
        return fodderAlfafa;
      case 'fodderMoringaLeaves':
        return fodderMoringaLeaves;
      case 'fodderSoyaBeanForage':
        return fodderSoyaBeanForage;
      case 'fodderGroundnutSeeds':
        return fodderGroundnutSeeds;
      case 'fodderBanannaStalks':
        return fodderBanannaStalks;
      case 'fodderBananaLeaves':
        return fodderBananaLeaves;
      case 'fodderSorghumForage':
        return fodderSorghumForage;
      case 'fodderSorghumStraw':
        return fodderSorghumStraw;
      case 'fodderMaizeSilage':
        return fodderMaizeSilage;
      case 'fodderMoringaLeavesFresh':
        return fodderMoringaLeavesFresh;
      case 'fodderFreshGrass':
        return fodderFreshGrass;
      case 'fodderRiceHay':
        return fodderRiceHay;
      case 'fodderSweetCornTrash':
        return fodderSweetCornTrash;
      case 'fodderBeanSilage':
        return fodderBeanSilage;
      case 'fodderRiceBranA':
        return fodderRiceBranA;
      case 'fodderRiceBranB':
        return fodderRiceBranB;
      case 'fodderRejectPotatoes':
        return fodderRejectPotatoes;
      case 'fodderCornStover':
        return fodderCornStover;
      case 'fodderBrewersGrain':
        return fodderBrewersGrain;
      case 'fodderSagoChips':
        return fodderSagoChips;
      case 'fodderRiceStraw':
        return fodderRiceStraw;
      case 'fodderDiCalciumPhosphate':
        return fodderDiCalciumPhosphate;
      case 'fodderElephantGrassNapierGrass':
        return fodderElephantGrassNapierGrass;
      case 'fodderElephantGrassHay':
        return fodderElephantGrassHay;
      default:
        return key;
    }
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
