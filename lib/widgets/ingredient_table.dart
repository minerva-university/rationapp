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
  final Function(int) onEdit;
  final Function(int) onDelete;

  IngredientTable({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  final List<ColumnDefinition> columns = [
    {'label': 'Ingredient', 'key': 'name', 'decimals': 0},
    {'label': 'Fresh feed\nintake (kg/d)', 'key': 'weight', 'decimals': 2},
    {'label': 'DM Intake\n(kg/d)', 'key': 'dmIntake', 'decimals': 5},
    {'label': 'ME Intake\n(MJ/d)', 'key': 'meIntake', 'decimals': 5},
    {'label': 'CP Intake\n(%)', 'key': 'cpIntake', 'decimals': 5},
    {'label': 'NDF Intake\n(%)', 'key': 'ndfIntake', 'decimals': 5},
    {'label': 'Ca Intake\n(%)', 'key': 'caIntake', 'decimals': 5},
    {'label': 'P Intake\n(%)', 'key': 'pIntake', 'decimals': 5},
    {'label': 'Cost\n(ERN)', 'key': 'cost', 'decimals': 2},
  ]
      .map((col) => ColumnDefinition(
          label: col['label'] as String,
          key: col['key'] as String,
          decimalPlaces: col['decimals'] as int))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scrollable data columns
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns
                  .map((col) => DataColumn(label: Text(col.label)))
                  .toList(),
              rows: List.generate(items.length, (index) {
                final item = items[index];
                return DataRow(
                  cells: columns
                      .map((col) => DataCell(Text(_formatValue(item, col))))
                      .toList(),
                );
              }),
            ),
          ),
        ),
        VerticalDivider(width: 1),
        // Fixed Actions column
        Column(
          children: [
            Container(
              height: 56,
              alignment: Alignment.center,
            ),
            ...List.generate(items.length, (index) {
              return SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCompactIconButton(Icons.edit, () => onEdit(index)),
                    _buildCompactIconButton(
                        Icons.delete, () => onDelete(index)),
                  ],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactIconButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  String _formatValue(Map<String, dynamic> item, ColumnDefinition col) {
    final value = item[col.key];
    return col.key == 'name'
        ? value.toString()
        : (value as num).toStringAsFixed(col.decimalPlaces);
  }
}
