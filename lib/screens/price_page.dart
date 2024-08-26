import 'package:flutter/material.dart';
import '../data/nutrition_tables.dart';
import '../models/feed_formula_model.dart';
import '../services/persistence_manager.dart';

class PricesPage extends StatefulWidget {
  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  List<FeedIngredient> fodderItems = [];
  List<FeedIngredient> concentrateItems = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPrices();
  }

  void _loadSavedPrices() {
    final savedPricesAndAvailability =
        SharedPrefsService.getFeedPricesAndAvailability();
    if (savedPricesAndAvailability != null) {
      setState(() {
        fodderItems =
            savedPricesAndAvailability.where((item) => item.isFodder).toList();
        concentrateItems =
            savedPricesAndAvailability.where((item) => !item.isFodder).toList();
      });
    } else {
      fodderItems = NutritionTables.fodderItems;
      concentrateItems = NutritionTables.concentrateItems;
      // save default prices
      _savePricesAndAvailability();
    }
  }

  void _savePricesAndAvailability() {
    List<FeedIngredient> prices = [];
    for (var item in [...fodderItems, ...concentrateItems]) {
      prices.add(FeedIngredient(
        name: item.name,
        weight: item.weight,
        dmIntake: item.dmIntake,
        meIntake: item.meIntake,
        cpIntake: item.cpIntake,
        ndfIntake: item.ndfIntake,
        caIntake: item.caIntake,
        pIntake: item.pIntake,
        costPerKg: item.costPerKg,
        isAvailable: item.isAvailable,
        isFodder: item.isFodder,
      ));
    }
    SharedPrefsService.setFeedPricesAndAvailability(prices);
  }

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
      body: ListView(
        children: [
          _buildSectionTitle('Fodder'),
          ...fodderItems.map(_buildFeedItemTile),
          _buildSectionTitle('Concentrates'),
          ...concentrateItems.map(_buildFeedItemTile),
        ],
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

  Widget _buildFeedItemTile(FeedIngredient item) {
    return ListTile(
      title: Text(item.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: item.isAvailable,
            onChanged: (bool? value) {
              setState(() {
                item.isAvailable = value ?? false;
                _savePricesAndAvailability();
              });
            },
          ),
          SizedBox(
            width: 100,
            child: TextField(
              decoration: InputDecoration(labelText: 'Price/kg'),
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: item.costPerKg.toString()),
              onChanged: (value) {
                item.costPerKg = double.tryParse(value) ?? 0;
                _savePricesAndAvailability();
              },
            ),
          ),
        ],
      ),
    );
  }
}
