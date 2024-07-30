import 'package:flutter/material.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custom_text_field.dart';
import '../data/nutrition_tables.dart';
import '../constants/feed_constants.dart';
import '../models/cow_characteristics_model.dart';
import '../models/cow_requirements_model.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildCowRequirementsSection(),
                  const Divider(height: 30, thickness: 2),
                  buildSectionTitle('Fodder', Icons.grass),
                  ...fodderItems.map(
                      (item) => buildIngredientDisplay(item, isFodder: true)),
                  ElevatedButton(
                    onPressed: () => _showAddIngredientDialog(true),
                    child: Text('Add Fodder'),
                  ),
                  SizedBox(height: 20),
                  buildSectionTitle('Concentrate', Icons.scatter_plot),
                  ...concentrateItems.map(
                      (item) => buildIngredientDisplay(item, isFodder: false)),
                  ElevatedButton(
                    onPressed: () => _showAddIngredientDialog(false),
                    child: Text('Add Concentrate'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/sense-200px.png', height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCowRequirementsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cow Requirements',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'DM Intake: ${widget.cowRequirements.dmIntake.toStringAsFixed(2)} kg/day'),
            Text(
                'ME Intake: ${widget.cowRequirements.meIntake.toStringAsFixed(2)} MJ/day'),
            Text(
                'CP Intake: ${(widget.cowRequirements.cpIntake * 100).toStringAsFixed(2)}%'),
            Text(
                'Ca Intake: ${widget.cowRequirements.caIntake.toStringAsFixed(2)}%'),
            Text(
                'P Intake: ${widget.cowRequirements.pIntake.toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, IconData icon) {
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

  Widget buildIngredientDisplay(Map<String, dynamic> item,
      {required bool isFodder}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item['name']} - ${item['weight']} kg',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('DM Intake: ${item['dmIntake'].toStringAsFixed(5)} kg/d'),
            Text('ME Intake: ${item['meIntake'].toStringAsFixed(5)} MJ/d'),
            Text('CP Intake: ${item['cpIntake'].toStringAsFixed(5)} kg/d'),
            Text('NDF Intake: ${item['ndfIntake'].toStringAsFixed(5)} kg/d'),
            Text('Ca Intake: ${item['caIntake'].toStringAsFixed(5)} kg/d'),
            Text('P Intake: ${item['pIntake'].toStringAsFixed(5)} kg/d'),
            Text('Cost: ${item['cost'].toStringAsFixed(2)} ERN'),
          ],
        ),
      ),
    );
  }

  void _showAddIngredientDialog(bool isFodder) {
    String? selectedIngredient;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${isFodder ? 'Fodder' : 'Concentrate'}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField(
              hintText: 'Select Ration Ingredient',
              options: isFodder
                  ? FeedConstants.fodderOptions
                  : FeedConstants.concentrateOptions,
              onChanged: (value) => selectedIngredient = value,
            ),
            CustomTextField(
              labelText: 'Fresh feed intake (kg/d)',
              controller: feedWeightController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (selectedIngredient != null &&
                  feedWeightController.text.isNotEmpty) {
                double weight = double.tryParse(feedWeightController.text) ?? 0;
                _addIngredient(selectedIngredient!, weight, isFodder);
                feedWeightController.text = '';
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addIngredient(String name, double weight, bool isFodder) {
    final table =
        isFodder ? NutritionTables.fodder : NutritionTables.concentrates;
    final ingredient =
        table.firstWhere((e) => e['name'].toLowerCase() == name.toLowerCase());

    final dmIntake = ((ingredient['dm'])?.toDouble() ?? 0.0) * weight / 100;
    final meIntake = ((ingredient['me'])?.toDouble() ?? 0.0) * dmIntake;
    final cost = ((ingredient['costPerKg'])?.toDouble() ?? 0.0) * weight;

    double calculateValue(String key) {
      return ((ingredient[key])?.toDouble() ?? 0.0) * dmIntake / 100;
    }

    final newItem = {
      'name': name,
      'weight': weight,
      'dmIntake': dmIntake,
      'meIntake': meIntake,
      'cpIntake': calculateValue('cp'),
      'ndfIntake': calculateValue('ndf'),
      'caIntake': calculateValue('ca'),
      'pIntake': calculateValue('p'),
      'cost': cost,
    };

    setState(() {
      if (isFodder) {
        fodderItems.add(newItem);
      } else {
        concentrateItems.add(newItem);
      }
    });
  }
}
