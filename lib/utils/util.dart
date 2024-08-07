// src/util.dart

double roundToPrecision(double num, double precision) {
  final rounding = (1.0 / precision).round();
  return ((num + double.minPositive) * rounding).round() / rounding;
}
