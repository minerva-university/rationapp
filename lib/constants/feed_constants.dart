import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../feed_state.dart';

class FeedConstants {
  List<String> getFodderOptions(BuildContext context) {
    final fodder =
        Provider.of<FeedState>(context, listen: false).availableFodderItems;
    return [...fodder.map((item) => item.name)];
  }

  List<String> getConcentrateOptions(BuildContext context) {
    final concentrate = Provider.of<FeedState>(context, listen: false)
        .availableConcentrateItems;
    return [...concentrate.map((item) => item.name)];
  }
}
