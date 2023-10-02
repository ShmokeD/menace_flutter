import 'package:flutter/material.dart';
import '../widgets/game_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Colors.black,
        ),
        GameWidget(width: width),
        Flexible(
          child: Container(
            width: double.infinity,
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}
