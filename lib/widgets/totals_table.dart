import 'package:flutter/material.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import '../models/cow_requirements_model.dart';
import '../models/feed_formula_model.dart';

class TotalsTable extends StatelessWidget {
  final List<FeedIngredient> fodderItems;
  final List<FeedIngredient> concentrateItems;
  final CowRequirements cowRequirements;
  final CowCharacteristics cowCharacteristics;

  TotalsTable(
      {super.key,
      required this.fodderItems,
      required this.concentrateItems,
      required this.cowRequirements,
      required this.cowCharacteristics});

  bool get isLactating => cowCharacteristics.lactationStage != 'Dry';

  List<Map<String, dynamic>> get columns {
    return [
      {
        'label': 'DM Intake\n(kg/d)',
        'key': 'dmIntake',
        'decimals': 2,
        'reqKey': 'dmIntake',
        'min': cowRequirements.dmIntake * 0.95,
        'max': cowRequirements.dmIntake * 1.05
      },
      {
        'label': 'ME Intake\n(MJ/d)',
        'key': 'meIntake',
        'decimals': 2,
        'reqKey': 'meIntake',
        'min': cowRequirements.meIntake * 0.95,
        'max': cowRequirements.meIntake * 1.05
      },
      {
        'label': 'CP Intake\n(%DM)',
        'key': 'cpIntake',
        'decimals': 2,
        'reqKey': 'cpIntake',
        'min': isLactating ? 16 : 12,
        'max': isLactating ? 18 : 14,
      },
      {
        'label': 'NDF Intake\n(%DM)',
        'key': 'ndfIntake',
        'decimals': 2,
        'reqKey': 'ndfIntake',
        'min': 28,
        'max': 40
      },
      {
        'label': 'Ca Intake\n(%DM)',
        'key': 'caIntake',
        'decimals': 2,
        'reqKey': 'caIntake',
        'min': isLactating ? 0.7 : 0.35,
        'max': isLactating ? 1.0 : 0.55,
      },
      {
        'label': 'P Intake\n(%DM)',
        'key': 'pIntake',
        'decimals': 2,
        'reqKey': 'pIntake',
        'min': isLactating ? 0.35 : 0.25,
        'max': isLactating ? 0.45 : 0.40,
      },
      {
        'label': 'Concentrate Intake\n(%DM)',
        'key': 'concentrateIntake',
        'decimals': 2,
        'reqKey': 'concentrateIntake',
        'min': 0,
        'max': 60
      },
      {
        'label': 'Cost\n(ERN)',
        'key': 'cost',
        'decimals': 2,
        'reqKey': null,
      },
    ];
  }

  Map<String, double> _calculateTotals() {
    Map<String, double> totals = {};

    for (var col in columns) {
      String key = col['key'] as String;
      totals[key] = 0;
    }

    for (var item in [...fodderItems, ...concentrateItems]) {
      for (var col in columns) {
        String key = col['key'] as String;
        // skip 'concentrateIntake'
        if (key != 'concentrateIntake') {
          totals[key] = (totals[key] ?? 0) + item[key];
        }
      }
    }

    double totalDM = totals['dmIntake']!;
    totals['concentrateIntake'] = 0;

    // dmIntake totals for concentrate items
    for (var item in concentrateItems) {
      totals['concentrateIntake'] =
          (totals['concentrateIntake'] ?? 0) + (item['dmIntake'] ?? 0);
    }

    // Convert to %DM
    List<String> percentageKeys = [
      'concentrateIntake',
      'cpIntake',
      'ndfIntake',
      'caIntake',
      'pIntake'
    ];
    for (String key in percentageKeys) {
      if (totalDM > 0) {
        totals[key] = (totals[key]! / totalDM) * 100;
      } else {
        totals[key] = 0;
      }
    }

    return totals;
  }

  Widget _buildComparisonIcon(
      String key, double total, Map<String, dynamic> columnData) {
    if (columnData['reqKey'] == null) {
      return SizedBox.shrink(); // No comparison for this key
    }

    double min = columnData['min'].toDouble();
    double max = columnData['max'].toDouble();

    if (total < min) {
      return Icon(Icons.arrow_upward, color: Colors.red);
    } else if (total > max) {
      return Icon(Icons.arrow_downward, color: Colors.orange);
    } else {
      return Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns
            .map((col) => DataColumn(label: Text(col['label'] as String)))
            .toList(),
        rows: [
          DataRow(
            cells: columns.map((col) {
              String key = col['key'] as String;
              int decimals = col['decimals'] as int;
              double total = totals[key]!;

              Widget comparisonIcon = _buildComparisonIcon(key, total, col);

              return DataCell(
                Row(
                  children: [
                    Text(total.toStringAsFixed(decimals)),
                    SizedBox(width: 5),
                    comparisonIcon,
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
