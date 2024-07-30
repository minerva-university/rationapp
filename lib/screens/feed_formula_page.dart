import 'package:flutter/material.dart';
import '../widgets/custom_dropdown_field.dart';
import '../widgets/custom_text_field.dart';

class FeedFormulaPage extends StatelessWidget {
  final List<String> fodderOptions = [
    'Wheat Hay',
    'Elephant Grass Hay',
    'Banana Stalks',
    'Cabbage'
  ];
  final List<String> concentrateOptions = [
    'Concentrate 1',
    'Concentrate 2',
    'Concentrate 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Feed Formula',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.green.shade200,
              child: const Center(
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Feed Formula',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildSectionTitle('Fodder', Icons.grass),
                  buildIngredientRow('Wheat Hay', fodderOptions),
                  buildIngredientRow('Elephant Grass Hay', fodderOptions),
                  buildIngredientRow('Banana Stalks', fodderOptions),
                  buildIngredientRow('Cabbage', fodderOptions),
                  buildSectionTitle('Concentrate', Icons.scatter_plot),
                  buildIngredientRow('Concentrate 1', concentrateOptions),
                  buildIngredientRow('Concentrate 2', concentrateOptions),
                  buildIngredientRow('Concentrate 3', concentrateOptions),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Results
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text('View Results'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/sense-200px.png', height: 50),
            ),
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

  Widget buildIngredientRow(String initialValue, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomDropdownField(
              hintText: initialValue,
              options: options,
              onChanged: (value) {},
              value: initialValue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: CustomTextField(
              labelText: 'Fresh feed intake (kg)',
              controller: TextEditingController(text: '6'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: CustomTextField(
              labelText: 'DM intake (kg/d)',
              controller: TextEditingController(text: '6'),
            ),
          ),
        ],
      ),
    );
  }
}
