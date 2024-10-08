import 'package:flutter/material.dart';
import 'package:rationapp/generated/l10n.dart';

class FeedIngredient {
  final String id;
  final String name;
  final double weight;
  final double dmIntake;
  final double meIntake;
  final double cpIntake;
  final double ndfIntake;
  final double caIntake;
  final double pIntake;
  double cost;
  bool isAvailable;
  final bool isFodder;

  FeedIngredient({
    required this.id,
    required this.name,
    required this.weight,
    required this.dmIntake,
    required this.meIntake,
    required this.cpIntake,
    required this.ndfIntake,
    required this.caIntake,
    required this.pIntake,
    required this.cost,
    this.isAvailable = true,
    required this.isFodder,
  });

  dynamic operator [](String key) {
    switch (key) {
      case 'id':
        return id;
      case 'name':
        return name;
      case 'weight':
        return weight;
      case 'dmIntake':
        return dmIntake;
      case 'meIntake':
        return meIntake;
      case 'cpIntake':
        return cpIntake;
      case 'ndfIntake':
        return ndfIntake;
      case 'caIntake':
        return caIntake;
      case 'pIntake':
        return pIntake;
      case 'cost':
        return cost;
      case 'isAvailable':
        return isAvailable;
      case 'isFodder':
        return isFodder;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }

  factory FeedIngredient.fromJson(Map<String, dynamic> json) {
    return FeedIngredient(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      dmIntake: json['dmIntake'],
      meIntake: json['meIntake'],
      cpIntake: json['cpIntake'],
      ndfIntake: json['ndfIntake'],
      caIntake: json['caIntake'],
      pIntake: json['pIntake'],
      cost: json['cost'] ?? 0.0,
      isAvailable: json['isAvailable'] ?? true,
      isFodder: json['isFodder'] ?? true,
    );
  }

  String getName(BuildContext context) {
    return S.of(context).getTranslation(id);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'dmIntake': dmIntake,
      'meIntake': meIntake,
      'cpIntake': cpIntake,
      'ndfIntake': ndfIntake,
      'caIntake': caIntake,
      'pIntake': pIntake,
      'cost': cost,
      'isAvailable': isAvailable,
      'isFodder': isFodder,
    };
  }

  FeedIngredient copyWith({bool? isAvailable, double? cost}) {
    return FeedIngredient(
      id: id,
      name: name,
      weight: weight,
      dmIntake: dmIntake,
      meIntake: meIntake,
      cpIntake: cpIntake,
      ndfIntake: ndfIntake,
      caIntake: caIntake,
      pIntake: pIntake,
      cost: cost ?? this.cost,
      isAvailable: isAvailable ?? this.isAvailable,
      isFodder: isFodder,
    );
  }

  @override
  String toString() {
    return 'FeedIngredient(id: $id, name: $name, weight: $weight, dmIntake: $dmIntake, meIntake: $meIntake, cpIntake: $cpIntake, ndfIntake: $ndfIntake, caIntake: $caIntake, pIntake: $pIntake, cost: $cost, isAvailable: $isAvailable, isFodder: $isFodder)';
  }
}

class FeedFormula {
  final List<FeedIngredient> fodder;
  final List<FeedIngredient> concentrate;

  FeedFormula({
    required this.fodder,
    required this.concentrate,
  });

  factory FeedFormula.fromJson(Map<String, dynamic> json) {
    return FeedFormula(
      fodder: (json['fodder'] as List)
          .map((item) => FeedIngredient.fromJson(item))
          .toList(),
      concentrate: (json['concentrate'] as List)
          .map((item) => FeedIngredient.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fodder': fodder.map((item) => item.toJson()).toList(),
      'concentrate': concentrate.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'FeedFormula(fodder: $fodder, concentrate: $concentrate)';
  }
}
