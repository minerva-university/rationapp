import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class FeedConstants {
  final BuildContext context;

  FeedConstants(this.context);
  List<String> get fodderOptions {
    return [
      S.of(context).fodderGreenMaizeForage,
      S.of(context).fodderAlfafa,
      S.of(context).fodderMoringaLeaves,
      S.of(context).fodderSoyaBeanForage,
      S.of(context).fodderGroundnutSeeds,
      S.of(context).fodderBanannaStalks,
      S.of(context).fodderBananaLeaves,
      S.of(context).fodderSorghumForage,
      S.of(context).fodderSorghumStraw,
      S.of(context).fodderMaizeSilage,
      S.of(context).fodderMoringaLeavesFresh,
      S.of(context).fodderFreshGrass,
      S.of(context).fodderRiceHay,
      S.of(context).fodderSweetCornTrash,
      S.of(context).fodderBeanSilage,
      S.of(context).fodderRiceBranA,
      S.of(context).fodderRiceBranB,
      S.of(context).fodderRejectPotatoes,
      S.of(context).fodderCornStover,
      S.of(context).fodderBrewersGrain,
      S.of(context).fodderSagoChips,
      S.of(context).fodderRiceStraw,
      S.of(context).fodderDiCalciumPhosphate,
      S.of(context).fodderElephantGrassNapierGrass,
      S.of(context).fodderElephantGrassHay,
    ];
  }

  List<String> get concentrateOptions {
    return [
      S.of(context).concentrateSesameSeedMeal,
      S.of(context).concentrateMolasses,
      S.of(context).concentrateMaizeGrain,
      S.of(context).concentrateSoybeanCake,
    ];
  }
}
