import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:rationapp/models/feed_formula_model.dart';

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
  final BuildContext context;
  final List<FeedIngredient> items;
  final Function(int) onEdit;
  final Function(int) onDelete;

  IngredientTable({
    super.key,
    required this.context,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  List<ColumnDefinition> get columns {
    return [
      {'label': S.of(context).ingredientLabel, 'key': 'name', 'decimals': 0},
      {
        'label': S.of(context).freshFeedIntakeLabel,
        'key': 'weight',
        'decimals': 2
      },
      {
        'label': S.of(context).dmIntakeLabelWithUnit,
        'key': 'dmIntake',
        'decimals': 5
      },
      {
        'label': S.of(context).meIntakeLabelWithUnit,
        'key': 'meIntake',
        'decimals': 5
      },
      {
        'label': S.of(context).caIntakeLabelKgPerD,
        'key': 'cpIntake',
        'decimals': 5
      },
      {
        'label': S.of(context).ndfIntakeLabelKgPerD,
        'key': 'ndfIntake',
        'decimals': 5
      },
      {
        'label': S.of(context).caIntakeLabelKgPerD,
        'key': 'caIntake',
        'decimals': 5
      },
      {
        'label': S.of(context).pIntakeLabelKgPerD,
        'key': 'pIntake',
        'decimals': 5
      },
      {'label': S.of(context).costLabel, 'key': 'cost', 'decimals': 2},
    ]
        .map((col) => ColumnDefinition(
            label: col['label'] as String,
            key: col['key'] as String,
            decimalPlaces: col['decimals'] as int))
        .toList();
  }

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
                      .map((col) =>
                          DataCell(Text(_formatValue(item, col, context))))
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

  String _formatValue(
      FeedIngredient item, ColumnDefinition col, BuildContext context) {
    final value = item[col.key];
    return col.key == 'name'
        ? item.getName(context)
        : (value as num).toStringAsFixed(col.decimalPlaces);
  }
}
