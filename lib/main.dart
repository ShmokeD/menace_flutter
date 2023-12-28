import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme:
          Theme.of(context).copyWith(colorScheme: const ColorScheme.dark()),
      home: GameScreen(),
    );
  }
}
