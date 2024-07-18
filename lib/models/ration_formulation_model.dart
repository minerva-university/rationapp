class RationFormulation {
  final String ingredient;
  final double freshFeedIntake;
  final double dmIntake;

  RationFormulation({
    required this.ingredient,
    required this.freshFeedIntake,
    required this.dmIntake,
  });

  factory RationFormulation.fromJson(Map<String, dynamic> json) {
    return RationFormulation(
      ingredient: json['ingredient'],
      freshFeedIntake: json['freshFeedIntake'],
      dmIntake: json['dmIntake'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredient': ingredient,
      'freshFeedIntake': freshFeedIntake,
      'dmIntake': dmIntake,
    };
  }
}
