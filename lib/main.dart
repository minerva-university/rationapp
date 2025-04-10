import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rationapp/utils/cow_requirements_calculator.dart';
import 'screens/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import 'services/persistence_manager.dart';
import 'feed_state.dart';

// coverage:ignore-start
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init();
  final cowRequirementsCalculator = CowRequirementsCalculator();
  final sharedPrefsService = SharedPrefsService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FeedState()),
        Provider.value(value: sharedPrefsService),
        Provider.value(value: cowRequirementsCalculator),
      ],
      child: RationCalculatorApp(),
    ),
  );
}
// coverage:ignore-end

class RationCalculatorApp extends StatelessWidget {
  const RationCalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FeedState(),
      child: Builder(
        builder: (context) {
          final feedState = Provider.of<FeedState>(context, listen: false);
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            ),
            home: Builder(
              builder: (context) {
                feedState.initializeWithContext(context);
                return const HomeScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
