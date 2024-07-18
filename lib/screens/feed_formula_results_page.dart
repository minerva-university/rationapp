import 'package:flutter/material.dart';

class FeedFormulaResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text(
          'Feed Formula Results',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Fodder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildDataTable(fodderData, fodderColumns),
            const SizedBox(height: 20),
            const Text(
              'Concentrate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildDataTable(concentrateData, concentrateColumns),
            const SizedBox(height: 20),
            const Text(
              'Ration Formulated',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildDataTable(rationFormulatedData, rationFormulatedColumns),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cowRequirements');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('View Cow requirements'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement download functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Download Results'),
            ),
          ],
        ),
      ),
    );
  }

  DataTable buildDataTable(List<List<String>> data, List<String> columns) {
    return DataTable(
      columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
      rows: data
          .map((row) =>
              DataRow(cells: row.map((cell) => DataCell(Text(cell))).toList()))
          .toList(),
    );
  }
}

// Sample data and columns based on the design
final List<String> fodderColumns = [
  'Ration Ingredients',
  'DM intake (Kg/d)',
  'ME intake (MJ/d)',
  'CP intake',
  'NDF intake',
  'Ca intake',
  'P intake',
  'Cost'
];

final List<List<String>> fodderData = [
  ['Wheat Hay', '34', '62', '234', '256', '564', '53', '24'],
  ['Elephant Grass Hay', '34', '62', '234', '256', '564', '53', '24'],
  ['Banana Stalks', '34', '62', '234', '256', '564', '53', '14'],
  ['Cabbage', '15', '34', '62', '234', '256', '53', '14'],
  ['Total Fodder', '484', '56', '345', '256', '564', '53', '44']
];

final List<String> concentrateColumns = [
  'Ration Ingredients',
  'DM intake (Kg/d)',
  'ME intake (MJ/d)',
  'CP intake',
  'NDF intake',
  'Ca intake',
  'P intake',
  'Cost'
];

final List<List<String>> concentrateData = [
  ['Concentrate 1', '34', '62', '234', '256', '564', '53', '24'],
  ['Concentrate 2', '34', '62', '234', '256', '564', '53', '24'],
  ['Concentrate 3', '34', '62', '234', '256', '564', '53', '14'],
  ['Total Concentrate', '102', '186', '702', '768', '1692', '159', '62']
];

final List<String> rationFormulatedColumns = [
  'Ration Ingredients',
  'DM intake (Kg/d)',
  'ME intake (MJ/d)',
  'CP intake',
  'NDF intake',
  'Ca intake',
  'P intake',
  'Cost'
];

final List<List<String>> rationFormulatedData = [
  ['Total Fodder', '484', '56', '345', '256', '564', '53', '44'],
  ['Total Concentrate', '102', '186', '702', '768', '1692', '159', '62'],
  ['Grand Total', '586', '242', '1047', '1024', '2256', '212', '106']
];
