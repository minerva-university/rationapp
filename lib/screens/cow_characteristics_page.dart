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

  // State for CowCharacteristicsContent
  final TextEditingController liveWeightController = TextEditingController();
  final TextEditingController pregnancyController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController milkFatController = TextEditingController();
  final TextEditingController milkProteinController = TextEditingController();
  final TextEditingController lactationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    liveWeightController.text = 'Choose live weight (kg)';
    pregnancyController.text = 'Choose pregnancy month';
    volumeController.text = '';
    milkFatController.text = 'Choose milk fat %';
    milkProteinController.text = 'Choose milk protein %';
    lactationController.text = 'Choose lactation stage';
  }

  void _navigateToFeedFormula(CowRequirements requirements) {
    setState(() {
      _showFeedFormula = true;
      _cowRequirements = requirements;
    });
  }

  void _navigateBack() {
    setState(() {
      _showFeedFormula = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showFeedFormula
          ? FeedFormulaPage(
              cowRequirements: _cowRequirements,
              onBack: _navigateBack,
            )
          : CowCharacteristicsContent(
              onNavigateToFeedFormula: _navigateToFeedFormula,
              liveWeightController: liveWeightController,
              pregnancyController: pregnancyController,
              volumeController: volumeController,
              milkFatController: milkFatController,
              milkProteinController: milkProteinController,
              lactationController: lactationController,
            ),
    );
  }
}
