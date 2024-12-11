import 'package:flutter/material.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';
import '../generated/l10n.dart';
import '../models/feed_formula_model.dart';

class AddIngredientDialog extends StatefulWidget {
  final bool isFodder;
  final List<FeedIngredient> availableOptions;
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
  String? selectedIngredientId;
  late TextEditingController feedWeightController;

  @override
  void initState() {
    super.initState();
    selectedIngredientId = widget.initialWeight != null // when editing
        ? widget.availableOptions.first.id
        : '';
    feedWeightController = TextEditingController(
      text: widget.initialWeight?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(8.0),
      title: Text(widget.isFodder
          ? S.of(context).addFodder
          : S.of(context).addConcentrate),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField(
              options: widget.availableOptions
                  .map((option) => option.getName(context))
                  .toList(),
              value: selectedIngredientId != ''
                  ? widget.availableOptions
                      .firstWhere((option) => option.id == selectedIngredientId)
                      .getName(context)
                  : '',
              onChanged: (value) {
                setState(() {
                  selectedIngredientId = widget.availableOptions
                      .firstWhere((option) => option.getName(context) == value)
                      .id;
                });
              },
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            if (selectedIngredientId != '' &&
                feedWeightController.text.isNotEmpty) {
              double weight = double.tryParse(feedWeightController.text) ?? 0;
              widget.onAdd(selectedIngredientId!, weight);
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
