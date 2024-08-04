import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown_field.dart';
import '../constants/cow_characteristics_constants.dart';
import '../models/cow_requirements_model.dart';
import '../utils/cow_requirements_calculator.dart';

class CowCharacteristicsContent extends StatefulWidget {
  final Function(CowRequirements) onNavigateToFeedFormula;
  final TextEditingController liveWeightController;
  final TextEditingController pregnancyController;
  final TextEditingController volumeController;
  final TextEditingController milkFatController;
  final TextEditingController milkProteinController;
  final TextEditingController lactationController;

  CowCharacteristicsContent({
    required this.onNavigateToFeedFormula,
    required this.liveWeightController,
    required this.pregnancyController,
    required this.volumeController,
    required this.milkFatController,
    required this.milkProteinController,
    required this.lactationController,
  });

  @override
  _CowCharacteristicsContentState createState() =>
      _CowCharacteristicsContentState();
}

class _CowCharacteristicsContentState extends State<CowCharacteristicsContent> {
  bool _isFormValid() {
    return widget.liveWeightController.text != 'Choose live weight (kg)' &&
        widget.pregnancyController.text != 'Choose pregnancy month' &&
        widget.volumeController.text.isNotEmpty &&
        widget.milkFatController.text != 'Choose milk fat %' &&
        widget.milkProteinController.text != 'Choose milk protein %' &&
        widget.lactationController.text != 'Choose lactation stage';
  }

  void _handleButtonPress() {
    if (_isFormValid()) {
      CowRequirementsCalculator.calculateCowRequirements(
          context,
          widget.liveWeightController,
          widget.pregnancyController,
          widget.volumeController,
          widget.milkFatController,
          widget.milkProteinController,
          widget.lactationController,
          widget.onNavigateToFeedFormula);
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
              hintText: widget.liveWeightController.text,
              options: CowCharacteristicsConstants.liveWeightOptions,
              onChanged: (value) {
                setState(() {
                  widget.liveWeightController.text = value ?? '';
                });
              },
              value: widget.liveWeightController.text,
              labelText: 'Live weight (kg)',
            ),
            CustomDropdownField(
              hintText: widget.pregnancyController.text,
              options: CowCharacteristicsConstants.pregnancyOptions,
              onChanged: (value) {
                setState(() {
                  widget.pregnancyController.text = value ?? '';
                });
              },
              value: widget.pregnancyController.text,
              labelText: 'Pregnancy (mth)',
            ),
            CustomTextField(
                labelText: 'Volume (kg)', controller: widget.volumeController),
            CustomDropdownField(
              hintText: widget.milkFatController.text,
              options: CowCharacteristicsConstants.milkFatOptions,
              onChanged: (value) {
                setState(() {
                  widget.milkFatController.text = value ?? '';
                });
              },
              value: widget.milkFatController.text,
              labelText: 'Milk fat (%)',
            ),
            CustomDropdownField(
              hintText: widget.milkProteinController.text,
              options: CowCharacteristicsConstants.milkProteinOptions,
              onChanged: (value) {
                setState(() {
                  widget.milkProteinController.text = value ?? '';
                });
              },
              value: widget.milkProteinController.text,
              labelText: 'Milk protein (%)',
            ),
            CustomDropdownField(
              hintText: widget.lactationController.text,
              options: CowCharacteristicsConstants.lactationOptions,
              onChanged: (value) {
                setState(() {
                  widget.lactationController.text = value ?? '';
                });
              },
              value: widget.lactationController.text,
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
