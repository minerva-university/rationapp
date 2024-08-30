import 'package:flutter/material.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';
import '../generated/l10n.dart';

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
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  String? selectedIngredient;
  late TextEditingController feedWeightController;

  @override
  void initState() {
    super.initState();
    selectedIngredient = widget.initialWeight != null // when editing
        ? widget.availableOptions.first
        : '';
    feedWeightController = TextEditingController(
      text: widget.initialWeight?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isFodder
          ? S.of(context).addFodder
          : S.of(context).addConcentrate),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomDropdownField(
            options: widget.availableOptions,
            value: selectedIngredient!,
            onChanged: (value) => selectedIngredient = value,
            labelText: widget.isFodder
                ? S.of(context).chooseFodder
                : S.of(context).chooseConcentrate,
          ),
          CustomTextField(
            labelText: S.of(context).freshFeedIntake,
            controller: feedWeightController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            if (selectedIngredient != '' &&
                feedWeightController.text.isNotEmpty) {
              double weight = double.tryParse(feedWeightController.text) ?? 0;
              widget.onAdd(selectedIngredient!, weight);
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).pleaseAllFields),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Text(S.of(context).add),
        ),
      ],
    );
  }
}
