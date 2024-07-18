import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../models/cow_characteristics_model.dart';

class CowCharacteristicsPage extends StatefulWidget {
  const CowCharacteristicsPage({super.key});

  @override
  _CowCharacteristicsPageState createState() => _CowCharacteristicsPageState();
}

class _CowCharacteristicsPageState extends State<CowCharacteristicsPage> {
  final TextEditingController liveWeightController = TextEditingController();
  final TextEditingController pregnancyController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController milkFatController = TextEditingController();
  final TextEditingController milkProteinController = TextEditingController();
  final TextEditingController lactationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    liveWeightController.text = '500';
    pregnancyController.text = '3';
    volumeController.text = '20';
    milkFatController.text = '4.0';
    milkProteinController.text = '3.2';
    lactationController.text = 'Early lactation';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text(
          'Cow Characteristics',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const ListTile(
              leading: Icon(Icons.pets, size: 40),
              title: Text('Cow Characteristics',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle: Text('Milk Yield', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            CustomTextField(
                labelText: 'Live weight (kg)',
                controller: liveWeightController),
            CustomTextField(
                labelText: 'Pregnancy (mth)', controller: pregnancyController),
            CustomTextField(
                labelText: 'Volume (kg)', controller: volumeController),
            CustomTextField(
                labelText: 'Milk fat (%)', controller: milkFatController),
            CustomTextField(
                labelText: 'Milk protein (%)',
                controller: milkProteinController),
            CustomTextField(
                labelText: 'Lactation stage', controller: lactationController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCowRequirements,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('View Cow requirements'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateCowRequirements() {
    double liveWeight = double.tryParse(liveWeightController.text) ?? 0;
    double pregnancy = double.tryParse(pregnancyController.text) ?? 0;
    double volume = double.tryParse(volumeController.text) ?? 0;
    double milkFat = double.tryParse(milkFatController.text) ?? 0;
    double milkProtein = double.tryParse(milkProteinController.text) ?? 0;
    String lactation = lactationController.text;

    CowCharacteristics cowCharacteristics = CowCharacteristics(
      liveWeight: liveWeight,
      pregnancyMonths: pregnancy,
      milkVolume: volume,
      milkFat: milkFat,
      milkProtein: milkProtein,
      lactationStage: lactation,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cow Requirements'),
          content: Text(
              'Live weight: ${cowCharacteristics.liveWeight} kg\nPregnancy: ${cowCharacteristics.pregnancyMonths} months\nVolume: ${cowCharacteristics.milkVolume} kg\nMilk fat: ${cowCharacteristics.milkFat}%\nMilk protein: ${cowCharacteristics.milkProtein}%\nLactation: ${cowCharacteristics.lactationStage}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
