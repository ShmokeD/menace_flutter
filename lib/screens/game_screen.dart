import 'package:flutter/material.dart';
import 'package:menace_flutter/managers/manager.dart';
import 'package:menace_flutter/screens/overview_screen.dart';
import '../widgets/game_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.manager});
  final GameManager manager;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true, actions: [
        IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => OverViewScreen(
                      aiManager: widget.manager.aiManager,
                    ))),
            icon: const Icon(
              Icons.auto_graph_outlined,
              color: Colors.black,
            ))
      ]),
      body: Column(children: [
        Image.asset(
          'assets/logo.png',
        ),
        GameWidget(width: width, manager: widget.manager),
        Flexible(
          child: Container(
            width: double.infinity,
            // color: Colors.black,
            // color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
