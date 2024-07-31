import 'package:flutter/material.dart';

class ColumnDefinition {
  final String label;
  final String key;
  final int decimalPlaces;

  ColumnDefinition({
    required this.label,
    required this.key,
    this.decimalPlaces = 2,
  });
}

class IngredientTable extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  IngredientTable({super.key, required this.items});

  final List<ColumnDefinition> columns = [
    {'label': 'Ingredient', 'key': 'name', 'decimals': 0},
    {'label': 'Fresh feed\nintake (kg/d)', 'key': 'weight', 'decimals': 2},
    {'label': 'DM Intake\n(kg/d)', 'key': 'dmIntake', 'decimals': 5},
    {'label': 'ME Intake\n(MJ/d)', 'key': 'meIntake', 'decimals': 5},
    {'label': 'CP Intake\n(kg/d)', 'key': 'cpIntake', 'decimals': 5},
    {'label': 'NDF Intake\n(kg/d)', 'key': 'ndfIntake', 'decimals': 5},
    {'label': 'Ca Intake\n(kg/d)', 'key': 'caIntake', 'decimals': 5},
    {'label': 'P Intake\n(kg/d)', 'key': 'pIntake', 'decimals': 5},
    {'label': 'Cost\n(ERN)', 'key': 'cost', 'decimals': 2},
  ]
      .map((col) => ColumnDefinition(
          label: col['label'] as String,
          key: col['key'] as String,
          decimalPlaces: col['decimals'] as int))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            columns.map((col) => DataColumn(label: Text(col.label))).toList(),
        rows: items
            .map((item) => DataRow(
                  cells: columns
                      .map((col) => DataCell(Text(col.key == 'name'
                          ? item[col.key].toString()
                          : (item[col.key] as num)
                              .toStringAsFixed(col.decimalPlaces))))
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
