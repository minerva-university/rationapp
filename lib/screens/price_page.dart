import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/feed_formula_model.dart';
import '../feed_state.dart';

class PricesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text('Feed Prices and Availability',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Consumer<FeedState>(
        builder: (context, feedState, child) {
          return ListView(
            children: [
              _buildSectionTitle('Fodder'),
              ...feedState.fodderItems
                  .map((item) => _buildFeedItemTile(item, feedState)),
              _buildSectionTitle('Concentrates'),
              ...feedState.concentrateItems
                  .map((item) => _buildFeedItemTile(item, feedState)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFeedItemTile(FeedIngredient item, FeedState feedState) {
    return ListTile(
      title: Text(item.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: item.isAvailable,
            onChanged: (bool? value) {
              feedState
                  .updateIngredient(item.copyWith(isAvailable: value ?? false));
            },
          ),
          SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: item.costPerKg.toStringAsFixed(2),
              decoration: InputDecoration(labelText: 'Price/kg'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                final newPrice = double.tryParse(value) ?? item.costPerKg;
                if (newPrice != item.costPerKg) {
                  feedState
                      .updateIngredient(item.copyWith(costPerKg: newPrice));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
