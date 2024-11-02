import 'package:flutter/material.dart';
import 'cow_characteristics_page.dart';
import 'feed_formula_page.dart';
import '../services/persistence_manager.dart';
import '../utils/cow_requirements_calculator.dart';
import 'package:provider/provider.dart';

class CowRequirementsView extends StatelessWidget {
  const CowRequirementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefsService = Provider.of<SharedPrefsService>(context);
    final calculator = Provider.of<CowRequirementsCalculator>(context);

    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return CowCharacteristicsPage(
                  sharedPrefsService: sharedPrefsService,
                  calculator: calculator,
                );
              case '/feed_formula':
                final args = settings.arguments as Map<String, dynamic>;
                return FeedFormulaPage(
                  cowCharacteristics: args['cowCharacteristics'],
                  cowRequirements: args['cowRequirements'],
                );
              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }
}
