import 'package:flutter/material.dart';

class RationFormulationPage extends StatefulWidget {
  @override
  _RationFormulationPageState createState() => _RationFormulationPageState();
}

class _RationFormulationPageState extends State<RationFormulationPage> {
  final List<String> ingredients = [
    'Wheat Hay',
    'Elephant Grass Hay',
    'Banana Stalks',
    'Cabbage'
  ];
  final List<TextEditingController> freshFeedControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> dmIntakeControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (var controller in freshFeedControllers) {
      controller.text = '6';
    }
    for (var controller in dmIntakeControllers) {
      controller.text = '6';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text('Ration Formulation',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Ration Formulation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ...List.generate(ingredients.length, (index) {
              return Column(
                children: [
                  Text(ingredients[index]),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: freshFeedControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Fresh feed intake (kg)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: dmIntakeControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'DM intake (kg/d)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
            ElevatedButton(
              onPressed: () {
                // Calculate Ration
              },
              child: const Text('Calculate Ration'),
            ),
          ],
        ),
      ),
    );
  }
}
