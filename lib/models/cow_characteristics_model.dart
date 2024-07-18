class CowCharacteristics {
  final double liveWeight;
  final double pregnancyMonths;
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
      liveWeight: json['liveWeight'],
      pregnancyMonths: json['pregnancyMonths'],
      milkVolume: json['milkVolume'],
      milkFat: json['milkFat'],
      milkProtein: json['milkProtein'],
      lactationStage: json['lactationStage'],
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
