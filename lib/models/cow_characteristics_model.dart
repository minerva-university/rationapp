class CowCharacteristics {
  final int liveWeight;
  final int pregnancyMonths;
  final double milkVolume;
  final double milkFat;
  final double milkProtein;
  final String lactationStage;

  CowCharacteristics({
    required this.liveWeight,
    required this.pregnancyMonths,
    required this.milkVolume,
    required this.milkFat,
    required this.milkProtein,
    required this.lactationStage,
  });

  factory CowCharacteristics.fromJson(Map<String, dynamic> json) {
    return CowCharacteristics(
      liveWeight: json['liveWeight'] as int,
      pregnancyMonths: json['pregnancyMonths'] as int,
      milkVolume: json['milkVolume'] as double,
      milkFat: json['milkFat'] as double,
      milkProtein: json['milkProtein'] as double,
      lactationStage: json['lactationStage']!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'liveWeight': liveWeight,
      'pregnancyMonths': pregnancyMonths,
      'milkVolume': milkVolume,
      'milkFat': milkFat,
      'milkProtein': milkProtein,
      'lactationStage': lactationStage,
    };
  }
}
