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
    bool isReady = false;
    manager.initialize().then((value) => setState(
          () => isReady = value,
        ));
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme:
          Theme.of(context).copyWith(colorScheme: const ColorScheme.dark()),
      home: AnimatedCrossFade(
          firstChild: Placeholder(),
          secondChild: GameScreen(manager: manager),
          crossFadeState:
              isReady ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200)),
    );
  }
}
