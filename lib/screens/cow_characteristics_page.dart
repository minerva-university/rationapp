import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';
import '../screens/feed_formula_page.dart';
import '../screens/cow_characteristics_content.dart';

class CowCharacteristicsPage extends StatefulWidget {
  @override
  _CowCharacteristicsPageState createState() => _CowCharacteristicsPageState();
}

class _CowCharacteristicsPageState extends State<CowCharacteristicsPage> {
  bool _showFeedFormula = false;
  late CowRequirements _cowRequirements;

  void _navigateToFeedFormula(CowRequirements requirements) {
    setState(() {
      _showFeedFormula = true;
      _cowRequirements = requirements;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showFeedFormula
        ? FeedFormulaPage(
            cowRequirements: _cowRequirements,
            onBack: () => setState(() => _showFeedFormula = false),
          )
        : CowCharacteristicsContent(
            onNavigateToFeedFormula: _navigateToFeedFormula,
          );
  }
}
