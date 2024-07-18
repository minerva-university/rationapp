class FeedIngredient {
  final String name;
  final double dmIntake;
  final double meIntake;
  final double cpIntake;
  final double ndfIntake;
  final double caIntake;
  final double pIntake;
  final double cost;

  FeedIngredient({
    required this.name,
    required this.dmIntake,
    required this.meIntake,
    required this.cpIntake,
    required this.ndfIntake,
    required this.caIntake,
    required this.pIntake,
    required this.cost,
  });

  factory FeedIngredient.fromJson(Map<String, dynamic> json) {
    return FeedIngredient(
      name: json['name'],
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
  final List<FeedIngredient> rationFormulated;

  FeedFormula({
    required this.fodder,
    required this.concentrate,
    required this.rationFormulated,
  });

  factory FeedFormula.fromJson(Map<String, dynamic> json) {
    return FeedFormula(
      fodder: (json['fodder'] as List)
          .map((item) => FeedIngredient.fromJson(item))
          .toList(),
      concentrate: (json['concentrate'] as List)
          .map((item) => FeedIngredient.fromJson(item))
          .toList(),
      rationFormulated: (json['rationFormulated'] as List)
          .map((item) => FeedIngredient.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fodder': fodder.map((item) => item.toJson()).toList(),
      'concentrate': concentrate.map((item) => item.toJson()).toList(),
      'rationFormulated':
          rationFormulated.map((item) => item.toJson()).toList(),
    };
  }
}
