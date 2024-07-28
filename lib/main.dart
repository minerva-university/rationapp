import 'package:flutter/material.dart';
import 'screens/cow_characteristics_page.dart';

void main() {
  runApp(RationCalculatorApp());
}

class RationCalculatorApp extends StatelessWidget {
  const RationCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CowCharacteristicsPage(),
    );
  }
}
