class FeedIngredient {
  final String name;
  final double weight;
  final double dmIntake;
  final double meIntake;
  final double cpIntake;
  final double ndfIntake;
  final double caIntake;
  final double pIntake;
  final double cost;

  FeedIngredient({
    required this.name,
    required this.weight,
    required this.dmIntake,
    required this.meIntake,
    required this.cpIntake,
    required this.ndfIntake,
    required this.caIntake,
    required this.pIntake,
    required this.cost,
  });

  dynamic operator [](String key) {
    switch (key) {
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
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }

  factory FeedIngredient.fromJson(Map<String, dynamic> json) {
    return FeedIngredient(
      name: json['name'],
      weight: json['weight'],
      dmIntake: json['dmIntake'],
      meIntake: json['meIntake'],
      cpIntake: json['cpIntake'],
      ndfIntake: json['ndfIntake'],
      caIntake: json['caIntake'],
      pIntake: json['pIntake'],
      cost: json['cost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'dmIntake': dmIntake,
      'meIntake': meIntake,
      'cpIntake': cpIntake,
      'ndfIntake': ndfIntake,
      'caIntake': caIntake,
      'pIntake': pIntake,
      'cost': cost,
    };
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
}
