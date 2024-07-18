import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/ration_formulation_page.dart';
import 'screens/budget_tool_page.dart';
import 'screens/feeding_guidelines_page.dart';
import 'screens/cow_requirements_page.dart';
import 'screens/feed_formula_page.dart';
import 'screens/feed_formula_results_page.dart';

void main() {
  runApp(RationCalculatorApp());
}

class RationCalculatorApp extends StatelessWidget {
  const RationCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/rationFormulation': (context) => RationFormulationPage(),
        '/budgetTool': (context) => BudgetToolPage(),
        '/feedingGuidelines': (context) => FeedingGuidelinesPage(),
        '/cowRequirements': (context) => CowRequirementsPage(),
        '/feedFormula': (context) => FeedFormulaPage(),
        '/feedFormulaResults': (context) => FeedFormulaResultsPage(),
      },
    );
  }
}
