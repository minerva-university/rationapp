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
      'decimals': 5,
      'reqKey': 'dmIntake'
    },
    {
      'label': 'ME Intake\n(MJ/d)',
      'key': 'meIntake',
      'decimals': 5,
      'reqKey': 'meIntake'
    },
    {
      'label': 'CP Intake\n(kg/d)',
      'key': 'cpIntake',
      'decimals': 5,
      'reqKey': 'cpIntake'
    },
    {
      'label': 'Ca Intake\n(kg/d)',
      'key': 'caIntake',
      'decimals': 5,
      'reqKey': 'caIntake'
    },
    {
      'label': 'P Intake\n(kg/d)',
      'key': 'pIntake',
      'decimals': 5,
      'reqKey': 'pIntake'
    },
    {'label': 'Cost\n(ERN)', 'key': 'cost', 'decimals': 2, 'reqKey': null},
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

  Widget _buildComparisonIcon(double total, double requirement) {
    const double threshold = 0.05; // 5% threshold for considering values equal
    if ((total - requirement).abs() < threshold * requirement) {
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
              double total = totals[key]!;

              Widget? comparisonIcon;
              if (reqKey != null) {
                double requirement = cowRequirements.toJson()[reqKey] as double;
                comparisonIcon = _buildComparisonIcon(total, requirement);
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
