import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';

class CowRequirementsTable extends StatelessWidget {
  final CowRequirements cowRequirements;

  const CowRequirementsTable({super.key, required this.cowRequirements});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('DM Intake\n(kg/day)')),
          DataColumn(label: Text('ME Intake\n(MJ/day)')),
          DataColumn(label: Text('CP Intake\n(%)')),
          DataColumn(label: Text('NDF Intake\n(%)')),
          DataColumn(label: Text('Ca Intake\n(%)')),
          DataColumn(label: Text('P Intake\n(%)')),
          DataColumn(label: Text('Concentrate Intake\n(%)')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(cowRequirements.dmIntake.toStringAsFixed(2))),
            DataCell(Text(cowRequirements.meIntake.toStringAsFixed(2))),
            DataCell(Text((cowRequirements.cpIntake * 100).toStringAsFixed(2))),
            DataCell(Text((cowRequirements.ndfIntake).toStringAsFixed(2))),
            DataCell(Text(cowRequirements.caIntake.toStringAsFixed(2))),
            DataCell(Text(cowRequirements.pIntake.toStringAsFixed(2))),
            DataCell(
                Text((cowRequirements.concentrateIntake).toStringAsFixed(2))),
          ]),
        ],
      ),
    );
  }
}
