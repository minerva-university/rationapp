import 'package:flutter/material.dart';
import '../models/cow_requirements_model.dart';
import '../generated/l10n.dart';

class CowRequirementsTable extends StatelessWidget {
  final CowRequirements cowRequirements;

  const CowRequirementsTable({super.key, required this.cowRequirements});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text(S.of(context).dmIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).meIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).cpIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).ndfIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).caIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).pIntakeLabelWithUnit)),
          DataColumn(label: Text(S.of(context).concentrateIntakeLabelWithUnit)),
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
