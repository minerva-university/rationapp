import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

class BudgetToolPage extends StatefulWidget {
  const BudgetToolPage({super.key});

  @override
  _BudgetToolPageState createState() => _BudgetToolPageState();
}

class _BudgetToolPageState extends State<BudgetToolPage> {
  final List<Map<String, dynamic>> incomeItems = [
    {
      'item': 'Milk sales',
      'amount': 10000.0,
      'controller': TextEditingController()
    },
    {
      'item': 'Other sales',
      'amount': 2000.0,
      'controller': TextEditingController()
    },
  ];

  final List<Map<String, dynamic>> expenseItems = [
    {
      'item': 'Veterinary costs',
      'amount': 10000.0,
      'controller': TextEditingController()
    },
    {
      'item': 'Electricity',
      'amount': 2000.0,
      'controller': TextEditingController()
    },
  ];

  double get totalIncome => incomeItems.fold(
      0.0,
      (sum, item) =>
          sum + (double.tryParse(item['controller'].text) ?? item['amount']));
  double get totalExpenses => expenseItems.fold(
      0.0,
      (sum, item) =>
          sum + (double.tryParse(item['controller'].text) ?? item['amount']));
  double get balance => totalIncome - totalExpenses;

  @override
  void initState() {
    super.initState();
    // Initialize TextEditingControllers with default values
    for (var item in incomeItems) {
      item['controller'].text = item['amount'].toString();
    }
    for (var item in expenseItems) {
      item['controller'].text = item['amount'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Budget Tool',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Monthly Income',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildDataTable(incomeItems),
            const SizedBox(height: 20),
            const Text(
              'Monthly Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildDataTable(expenseItems),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Recalculate'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            buildSummaryTable(),
            const SizedBox(height: 20),
            // Container(
            //   height: 200,
            //   child: BarChart(
            //     BarChartData(
            //       alignment: BarChartAlignment.spaceAround,
            //       barGroups: [
            //         BarChartGroupData(
            //           x: 0,
            //           barRods: [
            //             BarChartRodData(y: totalIncome, colors: [Colors.green]),
            //           ],
            //         ),
            //         BarChartGroupData(
            //           x: 1,
            //           barRods: [
            //             BarChartRodData(y: totalExpenses, colors: [Colors.red]),
            //           ],
            //         ),
            //       ],
            //       titlesData: FlTitlesData(
            //         leftTitles: SideTitles(showTitles: true),
            //         bottomTitles: SideTitles(
            //           showTitles: true,
            //           getTitles: (double value) {
            //             switch (value.toInt()) {
            //               case 0:
            //                 return 'Income';
            //               case 1:
            //                 return 'Expenses';
            //               default:
            //                 return '';
            //             }
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  DataTable buildDataTable(List<Map<String, dynamic>> items) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Items')),
        DataColumn(label: Text('Amount')),
      ],
      rows: items
          .map((item) => DataRow(cells: [
                DataCell(Text(item['item'])),
                DataCell(
                  TextField(
                    controller: item['controller'],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ]))
          .toList(),
    );
  }

  DataTable buildSummaryTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Total Income')),
        DataColumn(label: Text('Total Expenses')),
        DataColumn(label: Text('Balance')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text(totalIncome.toString())),
          DataCell(Text(totalExpenses.toString())),
          DataCell(Text(balance.toString())),
        ]),
      ],
    );
  }
}
