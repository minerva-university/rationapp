import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown_field.dart';
import '../models/cow_characteristics_model.dart';
import '../constants/cow_characteristics_constants.dart';

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
    liveWeightController.text = 'Choose live weight (kg)';
    pregnancyController.text = 'Choose pregnancy month';
    volumeController.text = '';
    milkFatController.text = 'Choose milk fat %';
    milkProteinController.text = 'Choose milk protein %';
    lactationController.text = 'Choose lactation stage';
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
            ListTile(
              leading: Icon(Icons.pets, size: 40),
              title: Text('Cow Characteristics',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle: Text('Milk Yield', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              hintText: liveWeightController.text,
              options: CowCharacteristicsConstants.liveWeightOptions,
              onChanged: (value) {
                setState(() {
                  liveWeightController.text = value ?? '';
                });
              },
              value: liveWeightController.text,
              labelText: 'Live weight (kg)',
            ),
            CustomDropdownField(
              hintText: pregnancyController.text,
              options: CowCharacteristicsConstants.pregnancyOptions,
              onChanged: (value) {
                setState(() {
                  pregnancyController.text = value ?? '';
                });
              },
              value: pregnancyController.text,
              labelText: 'Pregnancy (mth)',
            ),
            CustomTextField(
                labelText: 'Volume (kg)', controller: volumeController),
            CustomDropdownField(
              hintText: milkFatController.text,
              options: CowCharacteristicsConstants.milkFatOptions,
              onChanged: (value) {
                setState(() {
                  milkFatController.text = value ?? '';
                });
              },
              value: milkFatController.text,
              labelText: 'Milk fat (%)',
            ),
            CustomDropdownField(
              hintText: milkProteinController.text,
              options: CowCharacteristicsConstants.milkProteinOptions,
              onChanged: (value) {
                setState(() {
                  milkProteinController.text = value ?? '';
                });
              },
              value: milkProteinController.text,
              labelText: 'Milk protein (%)',
            ),
            CustomDropdownField(
              hintText: lactationController.text,
              options: CowCharacteristicsConstants.lactationOptions,
              onChanged: (value) {
                setState(() {
                  lactationController.text = value ?? '';
                });
              },
              value: lactationController.text,
              labelText: 'Lactation stage',
            ),
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
