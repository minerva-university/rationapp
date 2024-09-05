import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedingGuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: Text(
          S.of(context).feedingGuidelines,
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
            leading: SvgPicture.asset(
              'assets/cow_icon.svg',
              width: 80,
              height: 80,
            ),
            title: Text(S.of(context).earlyLactationFeeding),
            children: [
              _buildGuidelineTable(
                context: context,
                period: S.of(context).earlyLactationPeriod,
                dryMatterIntake: S.of(context).kgValue('16.5'),
                meIntake: S.of(context).mjPerDayValue('179.96'),
                crudeProtein: S.of(context).percentageValue('16'),
                ndf: S.of(context).percentageValue('40'),
                caIntake: S.of(context).percentageValue('0.80'),
                pIntake: S.of(context).percentageValue('0.40'),
              ),
            ],
          ),
          ExpansionTile(
            leading: SvgPicture.asset(
              'assets/cow_icon.svg',
              width: 80,
              height: 80,
            ),
            title: Text(S.of(context).midLactationFeeding),
            children: [
              _buildGuidelineTable(
                context: context,
                period: S.of(context).midLactationPeriod,
                dryMatterIntake: S.of(context).kgValue('16.5'),
                meIntake: S.of(context).mjPerDayValue('149.72'),
                crudeProtein: S.of(context).percentageValue('14'),
                ndf: S.of(context).percentageValue('40'),
                caIntake: S.of(context).percentageValue('0.70'),
                pIntake: S.of(context).percentageValue('0.35'),
              ),
            ],
          ),
          ExpansionTile(
            leading: SvgPicture.asset(
              'assets/cow_icon.svg',
              width: 80,
              height: 80,
            ),
            title: Text(S.of(context).lateLactationFeeding),
            children: [
              _buildGuidelineTable(
                context: context,
                period: S.of(context).lateLactationPeriod,
                dryMatterIntake: S.of(context).kgValue('16.5'),
                meIntake: S.of(context).mjPerDayValue('109.32'),
                crudeProtein: S.of(context).percentageValue('12'),
                ndf: S.of(context).percentageValue('40'),
                caIntake: S.of(context).percentageValue('0.40'),
                pIntake: S.of(context).percentageValue('0.20'),
              ),
            ],
          ),
          ExpansionTile(
            leading: SvgPicture.asset(
              'assets/cow_icon.svg',
              width: 80,
              height: 80,
            ),
            title: Text(S.of(context).dryCowFeeding),
            children: [
              _buildGuidelineTable(
                context: context,
                period: S.of(context).dryCowPeriod,
                dryMatterIntake: S.of(context).kgValue('16.5'),
                meIntake: S.of(context).mjPerDayValue('90'),
                crudeProtein: S.of(context).percentageValue('16'),
                ndf: S.of(context).percentageValue('40'),
                caIntake: S.of(context).percentageValue('0.40'),
                pIntake: S.of(context).percentageValue('0.20'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineTable({
    required BuildContext context,
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
          _buildTableRow(S.of(context).period, period),
          _buildTableRow(S.of(context).dryMatterIntakeLabel, dryMatterIntake),
          _buildTableRow(S.of(context).meIntakeLabel, meIntake),
          _buildTableRow(S.of(context).crudeProteinLabel, crudeProtein),
          _buildTableRow(S.of(context).ndfLabel, ndf),
          _buildTableRow(S.of(context).caIntakeLabel, caIntake),
          _buildTableRow(S.of(context).pIntakeLabel, pIntake),
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
