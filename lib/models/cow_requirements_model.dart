class CowRequirements {
  final double dmIntake;
  final double meIntake;
  final double cpIntake;
  final double ndfIntake;
  final double caIntake;
  final double pIntake;
  final double concentrateIntake;

  CowRequirements(
      {required this.dmIntake,
      required this.meIntake,
      required this.cpIntake,
      required this.ndfIntake,
      required this.caIntake,
      required this.pIntake,
      required this.concentrateIntake});

  factory CowRequirements.fromJson(Map<String, dynamic> json) {
    return CowRequirements(
        dmIntake: json['dmIntake'],
        meIntake: json['meIntake'],
        cpIntake: json['cpIntake'],
        ndfIntake: json['ndfIntake'],
        caIntake: json['caIntake'],
        pIntake: json['pIntake'],
        concentrateIntake: json['concentrateIntake']);
  }

  Map<String, dynamic> toJson() {
    return {
      'dmIntake': dmIntake,
      'meIntake': meIntake,
      'cpIntake': cpIntake,
      'ndfIntake': ndfIntake,
      'caIntake': caIntake,
      'pIntake': pIntake,
      'concentrateIntake': concentrateIntake
    };
  }
}
