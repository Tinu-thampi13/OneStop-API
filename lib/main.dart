import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'BgRemover/BgRemoverHomeScreen.dart';
import 'CryptoList/screens/Cryptohomescreen.dart';
import 'HomeScreen.dart';
import 'Quote/screens/QuotehomeScreen.dart';
import 'RandMeal/screens/MealhomeScreen.dart';
import 'TextRecog/textRecoghomescreen.dart';

void main() => runApp(const ProviderScope(child: App()));

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/BgRemoverHomeScreen': (ctx) => const BgRemoverHomeScreen(),
        '/Cryptohomescreen': (ctx) => Cryptohomescreen(),
        '/QuotehomeScreen': (ctx) => const QuotehomeScreen(),
        '/MealhomeScreen': (ctx) => const MealhomeScreen(),
        '/textRecoghomescreen': (ctx) => const textRecoghomescreen(),
      },
    );
  }
}
