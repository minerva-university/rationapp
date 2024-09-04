import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class CowCharacteristicsConstants {
  final BuildContext context;
  CowCharacteristicsConstants(this.context);
  static const List<String> liveWeightOptions = [
    '100',
    '125',
    '150',
    '175',
    '200',
    '225',
    '250',
    '275',
    '300',
    '325',
    '350',
    '375',
    '400',
    '425',
    '450',
    '475',
    '500',
    '525',
    '550',
    '575',
    '600'
  ];

  static const List<String> pregnancyOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];

  static const List<String> milkFatOptions = [
    '3.0',
    '3.1',
    '3.2',
    '3.3',
    '3.4',
    '3.5',
    '3.6',
    '3.7',
    '3.8',
    '3.9',
    '4.0',
    '4.1',
    '4.2',
    '4.3',
    '4.4',
    '4.5',
    '4.6',
    '4.7',
    '4.8',
    '4.9',
    '5.0',
    '5.1',
    '5.2'
  ];

  static const List<String> milkProteinOptions = [
    '2.6',
    '2.7',
    '2.8',
    '2.9',
    '3.0',
    '3.1',
    '3.2',
    '3.3',
    '3.4',
    '3.5',
    '3.6'
  ];

  List<String> get lactationStageOptions {
    return [
      S.of(context).lactationStageDry,
      S.of(context).lactationStageEarlyLactation,
      S.of(context).lactationStageMidLactation,
      S.of(context).lactationStageLateLactation,
    ];
  }

  String getLactationStageKey(String label) {
    if (label == S.of(context).lactationStageDry) return 'dry';
    if (label == S.of(context).lactationStageEarlyLactation) return 'early';
    if (label == S.of(context).lactationStageMidLactation) return 'mid';
    if (label == S.of(context).lactationStageLateLactation) return 'late';
    return '';
  }

  String getLactationStageLabel(String key) {
    switch (key) {
      case 'dry':
        return S.of(context).lactationStageDry;
      case 'early':
        return S.of(context).lactationStageEarlyLactation;
      case 'mid':
        return S.of(context).lactationStageMidLactation;
      case 'late':
        return S.of(context).lactationStageLateLactation;
      default:
        return '';
    }
  }
}
