import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown_field.dart';
import '../constants/cow_characteristics_constants.dart';
import '../../utils/cow_requirements_calculator.dart';

class CowCharacteristicsPage extends StatefulWidget {
  const CowCharacteristicsPage({super.key});

  @override
  State<CowCharacteristicsPage> createState() => _CowCharacteristicsPageState();
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

  bool _isFormValid() {
    return liveWeightController.text != 'Choose live weight (kg)' &&
        pregnancyController.text != 'Choose pregnancy month' &&
        volumeController.text.isNotEmpty &&
        milkFatController.text != 'Choose milk fat %' &&
        milkProteinController.text != 'Choose milk protein %' &&
        lactationController.text != 'Choose lactation stage';
  }

  void _handleButtonPress() {
    if (_isFormValid()) {
      CowRequirementsCalculator.calculateCowRequirements(
          context,
          liveWeightController,
          pregnancyController,
          volumeController,
          milkFatController,
          milkProteinController,
          lactationController);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please fill in all fields before viewing requirements.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              onPressed: _handleButtonPress,
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
}
