import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menace_flutter/managers/manager.dart';
import 'screens/game_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameManager manager = GameManager(Player.human);

  @override
  Widget build(BuildContext context) {
    manager.initialize();
    bool isReady = false;
    if (!isReady) {   
      sleep(const Duration(milliseconds: 500));  // await 500 milliseconds after initialize to ensure that storage is init.
      setState(() => isReady = true);
    }
    return MaterialApp(
      theme: ThemeData(useMaterial3: true)
          .copyWith(colorScheme: ColorScheme.dark()),
      // theme: ThemeData.dark(useMaterial3: true),
      // darkTheme:
      //     Theme.of(context).copyWith(colorScheme: const ColorScheme.dark()),
      home: GameScreen(manager: manager),
    );
  }
}
