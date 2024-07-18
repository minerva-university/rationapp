import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text('Ration Calculator',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.green.shade200,
            child: const Center(
                child: Icon(Icons.home, size: 30, color: Colors.white)),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.agriculture, size: 40),
                  title: const Text('Ration Formulation'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/rationFormulation');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.money, size: 40),
                  title: const Text('Budget Tool'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/budgetTool');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book, size: 40),
                  title: const Text('Feeding Guidelines'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/feedingGuidelines');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, size: 40),
                  title: const Text('Cow Requirements'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/cowRequirements');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/sense-200px.png', height: 50),
          ),
        ],
      ),
    );
  }
}
