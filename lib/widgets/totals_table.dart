import 'package:flutter/material.dart';
import 'package:rationapp/models/cow_characteristics_model.dart';
import '../models/cow_requirements_model.dart';

class TotalsTable extends StatelessWidget {
  final List<Map<String, dynamic>> fodderItems;
  final List<Map<String, dynamic>> concentrateItems;
  final CowRequirements cowRequirements;
  final CowCharacteristics cowCharacteristics;

  TotalsTable(
      {super.key,
      required this.fodderItems,
      required this.concentrateItems,
      required this.cowRequirements,
      required this.cowCharacteristics});

  final List<Map<String, dynamic>> columns = const [
    {
      'label': 'DM Intake\n(kg/d)',
      'key': 'dmIntake',
      'decimals': 2,
      'reqKey': 'dmIntake',
      'isPercentage': false,
    },
    {
      'label': 'ME Intake\n(MJ/d)',
      'key': 'meIntake',
      'decimals': 2,
      'reqKey': 'meIntake',
      'isPercentage': false,
    },
    {
      'label': 'CP Intake\n(%)',
      'key': 'cpIntake',
      'decimals': 2,
      'reqKey': 'cpIntake',
      'isPercentage': true,
    },
    {
      'label': 'NDF Intake\n(%)',
      'key': 'ndfIntake',
      'decimals': 2,
      'reqKey': 'ndfIntake',
      'isPercentage': true,
    },
    {
      'label': 'Ca Intake\n(%)',
      'key': 'caIntake',
      'decimals': 2,
      'reqKey': 'caIntake',
      'isPercentage': true,
    },
    {
      'label': 'P Intake\n(%)',
      'key': 'pIntake',
      'decimals': 2,
      'reqKey': 'pIntake',
      'isPercentage': true,
    },
    {
      'label': 'Concentrate Intake\n(%)',
      'key': 'concentrateIntake',
      'decimals': 2,
      'reqKey': 'concentrateIntake',
      'isPercentage': true,
    },
    {
      'label': 'Cost\n(ERN)',
      'key': 'cost',
      'decimals': 2,
      'reqKey': null,
      'isPercentage': false,
    },
  ];

  Map<String, double> _calculateTotals() {
    Map<String, double> totals = {};
    for (var col in columns) {
      String key = col['key'] as String;
      totals[key] = 0;
    }

    for (var item in [...fodderItems, ...concentrateItems]) {
      for (var col in columns) {
        String key = col['key'] as String;
        totals[key] = (totals[key] ?? 0) + (item[key] ?? 0);
      }
    }

    double totalConcentrateDM = 0;

    // dmIntake totals for concentrate items
    for (var item in concentrateItems) {
      totalConcentrateDM += item['dmIntake'] ?? 0;
    }
    totals['concentrateIntake'] =
        totalConcentrateDM / totals['dmIntake']! * 100;

    return totals;
  }

  Widget _buildComparisonIcon(String key, double total, bool isLactating) {
    Map<String, Map<String, double>> limits = {
      'concentrateIntake': {'min': 0, 'max': 60},
      'caIntake': {
        'min': isLactating ? 0.7 : 0.35,
        'max': isLactating ? 1.0 : 0.55,
      },
      'pIntake': {
        'min': isLactating ? 0.35 : 0.25,
        'max': isLactating ? 0.45 : 0.40,
      },
      'ndfIntake': {'min': 28, 'max': 35},
      'cpIntake': {
        'min': isLactating ? 16 : 12,
        'max': isLactating ? 18 : 14,
      },
      'dmIntake': {'min': 0.95, 'max': 1.05},
      'meIntake': {'min': 0.95, 'max': 1.05},
    };

    if (!limits.containsKey(key)) {
      return SizedBox.shrink(); // No comparison for this key
    }

    double min, max;
    if (key == 'dmIntake') {
      double requiredDM = cowRequirements.dmIntake;
      min = limits[key]!['min']! * requiredDM;
      max = limits[key]!['min']! * requiredDM;
    } else {
      min = limits[key]!['min']!;
      max = limits[key]!['max']!;
    }

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
              bool isLactating = cowCharacteristics.lactationStage != 'Dry';
              double total = totals[key]!;

              Widget comparisonIcon =
                  _buildComparisonIcon(key, total, isLactating);

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
