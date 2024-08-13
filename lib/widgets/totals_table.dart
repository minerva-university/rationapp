import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';

class TotalsTable extends StatelessWidget {
  final List<Map<String, dynamic>> fodderItems;
  final List<Map<String, dynamic>> concentrateItems;
  final CowRequirements cowRequirements;

  TotalsTable({
    super.key,
    required this.fodderItems,
    required this.concentrateItems,
    required this.cowRequirements,
  });

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
        totals[key] = (totals[key] ?? 0) + (item[key] as num);
      }
    }

    return totals;
  }

  Widget _buildComparisonIcon(
      double total, double requirement, bool isPercentage) {
    const double percentageThreshold = 2;
    const double absoluteThreshold = 0.05;

    bool isWithinRange;
    if (isPercentage) {
      isWithinRange = (total - requirement).abs() <= percentageThreshold;
    } else {
      isWithinRange =
          (total - requirement).abs() <= absoluteThreshold * requirement;
    }

    if (isWithinRange) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (total < requirement) {
      return Icon(Icons.arrow_upward, color: Colors.red);
    } else {
      return Icon(Icons.arrow_downward, color: Colors.orange);
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
              String? reqKey = col['reqKey'] as String?;
              bool isPercentage = col['isPercentage'] as bool;
              double total = totals[key]!;

              Widget? comparisonIcon;
              if (reqKey != null) {
                double requirement = cowRequirements.toJson()[reqKey] as double;
                comparisonIcon =
                    _buildComparisonIcon(total, requirement, isPercentage);
              }

              return DataCell(
                Row(
                  children: [
                    Text(total.toStringAsFixed(decimals)),
                    if (comparisonIcon != null) SizedBox(width: 5),
                    if (comparisonIcon != null) comparisonIcon,
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
