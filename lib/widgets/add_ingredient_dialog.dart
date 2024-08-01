import 'package:flutter/material.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';

class AddIngredientDialog extends StatefulWidget {
  final bool isFodder;
  final List<String> availableOptions;
  final Function(String, double) onAdd;
  final double? initialWeight;

  const AddIngredientDialog({
    super.key,
    required this.isFodder,
    required this.availableOptions,
    required this.onAdd,
    this.initialWeight,
  });

  @override
  _AddIngredientDialogState createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  String? selectedIngredient;
  late TextEditingController feedWeightController;

  @override
  void initState() {
    super.initState();
    selectedIngredient = widget.availableOptions.first;
    feedWeightController = TextEditingController(
      text: widget.initialWeight?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add ${widget.isFodder ? 'Fodder' : 'Concentrate'}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropdownField(
            hintText: 'Select Ration Ingredient',
            options: widget.availableOptions,
            onChanged: (value) => selectedIngredient = value,
            value: selectedIngredient,
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
              widget.onAdd(selectedIngredient!, weight);
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
