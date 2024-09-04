import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown_field.dart';
import '../constants/cow_characteristics_constants.dart';
import '../../utils/cow_requirements_calculator.dart';
import '../generated/l10n.dart';
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
  String selectedLactationStageKey = '';

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
        selectedLactationStageKey = savedCharacteristics.lactationStage;
      });
    } else {
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    liveWeightController.text = '';
    pregnancyController.text = '';
    volumeController.text = '';
    milkFatController.text = '';
    milkProteinController.text = '';
    lactationController.text = '';
    selectedLactationStageKey = '';
  }

  bool _isFormValid() {
    return liveWeightController.text != '' &&
        pregnancyController.text != '' &&
        volumeController.text.isNotEmpty &&
        milkFatController.text != '' &&
        milkProteinController.text != '' &&
        lactationController.text != '' &&
        selectedLactationStageKey.isNotEmpty;
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
          selectedLactationStageKey);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              S.of(context).pleaseFillInAllFieldsBeforeViewingRequirements),
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
      lactationStage: selectedLactationStageKey,
    );
    SharedPrefsService.setCowCharacteristics(cowCharacteristics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: Text(
          S.of(context).cowCharacteristics,
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
              title: Text(S.of(context).cowCharacteristics,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle:
                  Text(S.of(context).milkYield, style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              options: CowCharacteristicsConstants.liveWeightOptions,
              onChanged: (value) {
                setState(() {
                  liveWeightController.text = value ?? '';
                });
              },
              value: liveWeightController.text,
              labelText: S.of(context).liveWeight,
            ),
            CustomDropdownField(
              options: CowCharacteristicsConstants.pregnancyOptions,
              onChanged: (value) {
                setState(() {
                  pregnancyController.text = value ?? '';
                });
              },
              value: pregnancyController.text,
              labelText: S.of(context).pregnancy,
            ),
            CustomTextField(
                labelText: S.of(context).milkVolumePerDay,
                controller: volumeController),
            CustomDropdownField(
              options: CowCharacteristicsConstants.milkFatOptions,
              onChanged: (value) {
                setState(() {
                  milkFatController.text = value ?? '';
                });
              },
              value: milkFatController.text,
              labelText: S.of(context).milkFat,
            ),
            CustomDropdownField(
              options: CowCharacteristicsConstants.milkProteinOptions,
              onChanged: (value) {
                setState(() {
                  milkProteinController.text = value ?? '';
                });
              },
              value: milkProteinController.text,
              labelText: S.of(context).milkProtein,
            ),
            CustomDropdownField(
              options:
                  CowCharacteristicsConstants(context).lactationStageOptions,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedLactationStageKey =
                        CowCharacteristicsConstants(context)
                            .getLactationStageKey(value);
                    lactationController.text = value;
                  });
                }
              },
              value: CowCharacteristicsConstants(context)
                  .getLactationStageLabel(selectedLactationStageKey),
              labelText: S.of(context).lactationStage,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleButtonPress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(S.of(context).viewCowRequirements),
            ),
          ],
        ),
      ),
    );
  }
}
