import 'package:flutter/material.dart';
import 'cow_characteristics_page.dart';

class CowRequirementsPage extends StatelessWidget {
  const CowRequirementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text(
          'Cow Requirements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.pets, size: 40),
              title: const Text('Cow Characteristics'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CowCharacteristicsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
