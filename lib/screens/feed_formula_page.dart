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
                  buildSectionTitle('Cow Requirements', Icons.label_important),
                  buildCowRequirementsTable(),
                  const Divider(height: 30, thickness: 2),
                  buildSectionTitle('Fodder', Icons.grass),
                  buildIngredientTable(fodderItems),
                  ElevatedButton(
                    onPressed: () => _showAddIngredientDialog(true),
                    child: Text('Add Fodder'),
                  ),
                  SizedBox(height: 20),
                  buildSectionTitle('Concentrate', Icons.scatter_plot),
                  buildIngredientTable(concentrateItems),
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

  Widget buildCowRequirementsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('DM Intake\n(kg/day)')),
          DataColumn(label: Text('ME Intake\n(MJ/day)')),
          DataColumn(label: Text('CP Intake\n(%)')),
          DataColumn(label: Text('Ca Intake\n(%)')),
          DataColumn(label: Text('P Intake\n(%)')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(widget.cowRequirements.dmIntake.toStringAsFixed(2))),
            DataCell(Text(widget.cowRequirements.meIntake.toStringAsFixed(2))),
            DataCell(Text(
                (widget.cowRequirements.cpIntake * 100).toStringAsFixed(2))),
            DataCell(Text(widget.cowRequirements.caIntake.toStringAsFixed(2))),
            DataCell(Text(widget.cowRequirements.pIntake.toStringAsFixed(2))),
          ]),
        ],
      ),
    );
  }

  Widget buildIngredientTable(List<Map<String, dynamic>> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Ingredient')),
          DataColumn(label: Text('Fresh feed\nintake (kg/d)')),
          DataColumn(label: Text('DM Intake\n(kg/d)')),
          DataColumn(label: Text('ME Intake\n(MJ/d)')),
          DataColumn(label: Text('CP Intake\n(kg/d)')),
          DataColumn(label: Text('NDF Intake\n(kg/d)')),
          DataColumn(label: Text('Ca Intake\n(kg/d)')),
          DataColumn(label: Text('P Intake\n(kg/d)')),
          DataColumn(label: Text('Cost\n(ERN)')),
        ],
        rows: items
            .map((item) => DataRow(
                  cells: [
                    DataCell(Text(item['name'])),
                    DataCell(Text(item['weight'].toStringAsFixed(2))),
                    DataCell(Text(item['dmIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['meIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['cpIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['ndfIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['caIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['pIntake'].toStringAsFixed(5))),
                    DataCell(Text(item['cost'].toStringAsFixed(2))),
                  ],
                ))
            .toList(),
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

  void _showAddIngredientDialog(bool isFodder) {
    String? selectedIngredient;
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
      builder: (context) => AlertDialog(
        title: Text('Add ${isFodder ? 'Fodder' : 'Concentrate'}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField(
              hintText: 'Select Ration Ingredient',
              options: availableOptions,
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
