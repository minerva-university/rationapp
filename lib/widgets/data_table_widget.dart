import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<List<String>> data;
  final List<String> columns;

  DataTableWidget({required this.data, required this.columns});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
      rows: data
          .map((row) =>
              DataRow(cells: row.map((cell) => DataCell(Text(cell))).toList()))
          .toList(),
    );
  }
}
