import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown_field.dart';
import '../constants/cow_characteristics_constants.dart';
import '../../utils/cow_requirements_calculator.dart';
import '../services/persistence_manager.dart';
import '../models/cow_characteristics_model.dart';

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
    _loadSavedCharacteristics();
  }

  void _loadSavedCharacteristics() {
    final savedCharacteristics = SharedPrefsService.getCowCharacteristics();
    if (savedCharacteristics != null) {
      setState(() {
        liveWeightController.text =
            savedCharacteristics.liveWeight.toInt().toString();
        pregnancyController.text =
            savedCharacteristics.pregnancyMonths.toInt().toString();
        volumeController.text = savedCharacteristics.milkVolume.toString();
        milkFatController.text = savedCharacteristics.milkFat.toString();
        milkProteinController.text =
            savedCharacteristics.milkProtein.toString();
        lactationController.text =
            savedCharacteristics.lactationStage.toString();
      });
    } else {
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    liveWeightController.text =
        CowCharacteristicsConstants.liveWeightOptions.first;
    pregnancyController.text =
        CowCharacteristicsConstants.pregnancyOptions.first;
    volumeController.text = '';
    milkFatController.text = CowCharacteristicsConstants.milkFatOptions.first;
    milkProteinController.text =
        CowCharacteristicsConstants.milkProteinOptions.first;
    lactationController.text =
        CowCharacteristicsConstants.lactationOptions.first;
  }

  bool _isFormValid() {
    return liveWeightController.text !=
            CowCharacteristicsConstants.liveWeightOptions.first &&
        pregnancyController.text !=
            CowCharacteristicsConstants.pregnancyOptions.first &&
        volumeController.text.isNotEmpty &&
        milkFatController.text !=
            CowCharacteristicsConstants.milkFatOptions.first &&
        milkProteinController.text !=
            CowCharacteristicsConstants.milkProteinOptions.first &&
        lactationController.text !=
            CowCharacteristicsConstants.lactationOptions.first;
  }

  void _handleButtonPress() {
    if (_isFormValid()) {
      _saveCowCharacteristics();
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

  void _saveCowCharacteristics() {
    final cowCharacteristics = CowCharacteristics(
      liveWeight: int.tryParse(liveWeightController.text) ?? 0,
      pregnancyMonths: int.tryParse(pregnancyController.text) ?? 0,
      milkVolume: double.tryParse(volumeController.text) ?? 0.0,
      milkFat: double.tryParse(milkFatController.text) ?? 0.0,
      milkProtein: double.tryParse(milkProteinController.text) ?? 0.0,
      lactationStage: lactationController.text,
    );
    SharedPrefsService.setCowCharacteristics(cowCharacteristics);
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
                labelText: 'Milk volume per day (kg)',
                controller: volumeController),
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
