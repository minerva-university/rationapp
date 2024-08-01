import 'package:flutter/material.dart';
import '../widgets/cow_requirements_table.dart';
import '../widgets/ingredient_table.dart';
import '../widgets/add_ingredient_dialog.dart';
import '../constants/feed_constants.dart';
import '../models/cow_characteristics_model.dart';
import '../models/cow_requirements_model.dart';
import '../utils/feed_calculator.dart';

class FeedFormulaPage extends StatefulWidget {
  final CowCharacteristics cowCharacteristics;
  final CowRequirements cowRequirements;

  FeedFormulaPage({
    super.key,
    required this.cowCharacteristics,
    required this.cowRequirements,
  });

  @override
  _FeedFormulaPageState createState() => _FeedFormulaPageState();
}

class _FeedFormulaPageState extends State<FeedFormulaPage> {
  List<Map<String, dynamic>> fodderItems = [];
  List<Map<String, dynamic>> concentrateItems = [];
  final TextEditingController feedWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    feedWeightController.text = '';
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
        title: const Text('Feed Formula',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Fixed Cow Requirements section
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Cow Requirements', Icons.label_important),
                CowRequirementsTable(cowRequirements: widget.cowRequirements),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Fodder', Icons.grass),
                    IngredientTable(
                        items: fodderItems,
                        onEdit: (index) => _editIngredient(index, true),
                        onDelete: (index) => _deleteIngredient(index, true)),
                    ElevatedButton(
                      onPressed: () => _showAddIngredientDialog(true),
                      child: Text('Add Fodder'),
                    ),
                    SizedBox(height: 8),
                    _buildSectionTitle('Concentrate', Icons.scatter_plot),
                    IngredientTable(
                        items: concentrateItems,
                        onEdit: (index) => _editIngredient(index, false),
                        onDelete: (index) => _deleteIngredient(index, false)),
                    ElevatedButton(
                      onPressed: () => _showAddIngredientDialog(false),
                      child: Text('Add Concentrate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer image
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/sense-200px.png', height: 20),
          ),
        ],
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

  void _showAddIngredientDialog(bool isFodder) {
    List<String> availableOptions = (isFodder
            ? FeedConstants.fodderOptions
            : FeedConstants.concentrateOptions)
        .where((option) => !(isFodder ? fodderItems : concentrateItems)
            .any((item) => item['name'].toLowerCase() == option.toLowerCase()))
        .toList();
    if (availableOptions.length == 1 &&
        availableOptions[0].contains('Choose')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'All ${isFodder ? 'fodder' : 'concentrate'} options have been added.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AddIngredientDialog(
        isFodder: isFodder,
        availableOptions: availableOptions,
        onAdd: (name, weight) => _addIngredient(name, weight, isFodder),
      ),
    );
  }

  void _addIngredient(String name, double weight, bool isFodder) {
    setState(() {
      final newItem =
          FeedCalculator.calculateIngredientValues(name, weight, isFodder);
      if (isFodder) {
        fodderItems.add(newItem);
      } else {
        concentrateItems.add(newItem);
      }
    });
  }

  void _editIngredient(int index, bool isFodder) {
    final items = isFodder ? fodderItems : concentrateItems;
    final item = items[index];

    showDialog(
      context: context,
      builder: (context) => AddIngredientDialog(
        isFodder: isFodder,
        availableOptions: [item['name']], // only editing weight
        initialWeight: item['weight'],
        onAdd: (name, weight) {
          setState(() {
            final updatedItem = FeedCalculator.calculateIngredientValues(
                name, weight, isFodder);
            items[index] = updatedItem;
          });
        },
      ),
    );
  }

  void _deleteIngredient(int index, bool isFodder) {
    setState(() {
      if (isFodder) {
        fodderItems.removeAt(index);
      } else {
        concentrateItems.removeAt(index);
      }
    });
  }
}
