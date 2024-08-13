import 'package:flutter/material.dart';

class FeedingGuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text(
          'Feeding Guidelines',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ExpansionTile(
            leading: const Icon(Icons.pets, size: 40),
            title: const Text('Early Lactation Feeding'),
            children: [
              _buildGuidelineTable(
                period: 'Early Lactation (14-100 days)',
                dryMatterIntake: '16.5 kg',
                meIntake: '179.96 MJ/day',
                crudeProtein: '16%',
                ndf: '40%',
                caIntake: '0.80%',
                pIntake: '0.40%',
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.pets, size: 40),
            title: const Text('Mid Lactation Feeding'),
            children: [
              _buildGuidelineTable(
                period: 'Mid lactation (100 to 200 days)',
                dryMatterIntake: '16.5 kg',
                meIntake: '149.72 MJ/day',
                crudeProtein: '14%',
                ndf: '40%',
                caIntake: '0.70%',
                pIntake: '0.35%',
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.pets, size: 40),
            title: const Text('Late Lactation Feeding'),
            children: [
              _buildGuidelineTable(
                period: 'Late Lactation (>200 days)',
                dryMatterIntake: '16.5 kg',
                meIntake: '109.32 MJ/day',
                crudeProtein: '12%',
                ndf: '40%',
                caIntake: '0.40%',
                pIntake: '0.20%',
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.pets, size: 40),
            title: const Text('Dry Cow Feeding'),
            children: [
              _buildGuidelineTable(
                period: 'Due to calve in 45 to 60 days',
                dryMatterIntake: '16.5 kg',
                meIntake: '90 MJ/day',
                crudeProtein: '16%',
                ndf: '40%',
                caIntake: '0.40%',
                pIntake: '0.20%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineTable({
    required String period,
    required String dryMatterIntake,
    required String meIntake,
    required String crudeProtein,
    required String ndf,
    required String caIntake,
    required String pIntake,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
        },
        children: [
          _buildTableRow('Period', period),
          _buildTableRow('Dry Matter Intake', dryMatterIntake),
          _buildTableRow('ME Intake', meIntake),
          _buildTableRow('Crude Protein', crudeProtein),
          _buildTableRow('NDF', ndf),
          _buildTableRow('Ca Intake', caIntake),
          _buildTableRow('P Intake', pIntake),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
}
