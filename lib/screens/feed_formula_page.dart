import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feed_state.dart';
import '../widgets/cow_requirements_table.dart';
import '../widgets/ingredient_table.dart';
import '../widgets/add_ingredient_dialog.dart';
import '../widgets/totals_table.dart';
import '../constants/feed_constants.dart';
import '../models/cow_characteristics_model.dart';
import '../models/cow_requirements_model.dart';
import '../models/feed_formula_model.dart';
import '../utils/feed_calculator.dart';
import '../generated/l10n.dart';
import '../services/persistence_manager.dart';

class FeedFormulaPage extends StatefulWidget {
  final CowCharacteristics cowCharacteristics;
  final CowRequirements cowRequirements;

  FeedFormulaPage({
    super.key,
    required this.cowCharacteristics,
    required this.cowRequirements,
  });

  @override
  State<FeedFormulaPage> createState() => _FeedFormulaPageState();
}

class _FeedFormulaPageState extends State<FeedFormulaPage> {
  final FeedConstants feedConstants = FeedConstants();
  List<FeedIngredient> selectedFodderItems = [];
  List<FeedIngredient> selectedConcentrateItems = [];

  void _saveFeedFormula() {
    final feedFormula = FeedFormula(
      fodder: selectedFodderItems,
      concentrate: selectedConcentrateItems,
    );
    SharedPrefsService.setFeedFormula(feedFormula);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).feedFormula,
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Consumer<FeedState>(
        builder: (context, feedState, child) {
          final savedFormula = SharedPrefsService.getFeedFormula() ??
              FeedFormula(fodder: [], concentrate: []);

          selectedFodderItems = savedFormula.fodder
              .where((fodder) => feedState.availableFodderItems
                  .any((item) => item.name == fodder.name))
              .map((fodder) {
            final latestItem = feedState.fodderItems
                .firstWhere((item) => item.name == fodder.name);
            return fodder.copyWith(
                cost: latestItem.cost * fodder.weight,
                isAvailable: latestItem.isAvailable);
          }).toList();

          selectedConcentrateItems = savedFormula.concentrate
              .where((concentrate) => feedState.availableConcentrateItems
                  .any((item) => item.name == concentrate.name))
              .map((concentrate) {
            final latestItem = feedState.concentrateItems
                .firstWhere((item) => item.name == concentrate.name);
            return concentrate.copyWith(
                cost: latestItem.cost * concentrate.weight,
                isAvailable: latestItem.isAvailable);
          }).toList();

          return Column(
            children: [
              // Fixed Cow Requirements section
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionTitle(
                        S.of(context).cowRequirements, Icons.label_important),
                    CowRequirementsTable(
                        cowRequirements: widget.cowRequirements),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 2),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSectionTitle(S.of(context).fodder, Icons.grass),
                        IngredientTable(
                          context: context,
                          items: selectedFodderItems,
                          onEdit: (index) => _editIngredient(index, true),
                          onDelete: (index) => _deleteIngredient(index, true),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _showAddIngredientDialog(true, context),
                          child: Text(S.of(context).addFodder),
                        ),
                        SizedBox(height: 8),
                        _buildSectionTitle(
                            S.of(context).concentrate, Icons.scatter_plot),
                        IngredientTable(
                          context: context,
                          items: selectedConcentrateItems,
                          onEdit: (index) => _editIngredient(index, false),
                          onDelete: (index) => _deleteIngredient(index, false),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              _showAddIngredientDialog(false, context),
                          child: Text(S.of(context).addConcentrate),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildSectionTitle(S.of(context).totals, Icons.calculate),
                    TotalsTable(
                      context: context,
                      fodderItems: selectedFodderItems,
                      concentrateItems: selectedConcentrateItems,
                      cowRequirements: widget.cowRequirements,
                      cowCharacteristics: widget.cowCharacteristics,
                    ),
                    // Image.asset('assets/sense-200px.png', height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 30),
          const SizedBox(width: 10),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showAddIngredientDialog(bool isFodder, BuildContext context) {
    List<String> availableOptions = (isFodder
            ? FeedConstants().getFodderOptions(context)
            : FeedConstants().getConcentrateOptions(context))
        .where((option) => !(isFodder
                ? selectedFodderItems
                : selectedConcentrateItems)
            .any((item) => item['name'].toLowerCase() == option.toLowerCase()))
        .toList();
    if (availableOptions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(S.of(context).allOptionsHaveBeenAdded(
                  isFodder ? S.of(context).fodder : S.of(context).concentrate,
                ))),
      );
      return;
    }

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => AddIngredientDialog(
        isFodder: isFodder,
        availableOptions: availableOptions,
        onAdd: (name, weight) => _addIngredient(name, weight, isFodder),
      ),
    );
  }

  void _addIngredient(String name, double weight, bool isFodder) {
    setState(() {
      final newItem = FeedCalculator()
          .calculateIngredientValues(name, weight, isFodder, context);
      if (isFodder) {
        selectedFodderItems.add(newItem);
      } else {
        selectedConcentrateItems.add(newItem);
      }
      _saveFeedFormula();
    });
  }

  void _editIngredient(int index, bool isFodder) {
    final items = isFodder ? selectedFodderItems : selectedConcentrateItems;
    final item = items[index];

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => AddIngredientDialog(
        isFodder: isFodder,
        availableOptions: [item['name']], // only editing weight
        initialWeight: item['weight'],
        onAdd: (name, weight) {
          setState(() {
            final updatedItem = FeedCalculator()
                .calculateIngredientValues(name, weight, isFodder, context);
            items[index] = updatedItem;
            _saveFeedFormula();
          });
        },
      ),
    );
  }

  void _deleteIngredient(int index, bool isFodder) {
    setState(() {
      if (isFodder) {
        selectedFodderItems.removeAt(index);
      } else {
        selectedConcentrateItems.removeAt(index);
      }
      _saveFeedFormula();
    });
  }
}
