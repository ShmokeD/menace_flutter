import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../managers/manager.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({super.key, required this.width, required this.manager});
  final double width;

  final GameManager manager;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var manager = widget.manager;
    bool isDisabled = manager.isGameDisabled;
    var state = widget.manager.gameState.gameState;
    return Column(
      children: [
        ElevatedButton(
          child: const Text("Reset"),
          onPressed: () {
            setState(() {
              manager.reset();
            });
          },
        ),

        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(1);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.red,
              child: state[1] != Player.none
                  ? (state[1] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {} //Dont do anything if game is disabled
                : () => setState(() {
                      widget.manager.addHumanMove(2);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.blue,
              child: state[2] != Player.none
                  ? (state[2] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(3);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.green,
              child: state[3] != Player.none
                  ? (state[3] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
        ]),
        Container(
          height: 5,
          color: Colors.black,
          width: double.infinity,
        ),
        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(4);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.red,
              child: state[4] != Player.none
                  ? (state[4] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(5);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.blue,
              child: state[5] != Player.none
                  ? (state[5] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(6);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.green,
              child: state[6] != Player.none
                  ? (state[6] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
        ]),
        Container(
          height: 5,
          color: Colors.black,
          width: double.infinity,
        ),
        Row(children: [
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(7);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.red,
              child: state[7] != Player.none
                  ? (state[7] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(8);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.blue,
              child: state[8] != Player.none
                  ? (state[8] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          )),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          Expanded(
              child: GestureDetector(
            onTap: isDisabled
                ? () {}
                : () => setState(() {
                      widget.manager.addHumanMove(9);
                    }),
            child: Container(
              height: (widget.width / 3) - 10,
              width: (widget.width / 3) - 10,
              color: Colors.green,
              child: state[9] != Player.none
                  ? (state[9] == Player.human)
                      ? Icon(Icons.star, size: (widget.width / 3) - 15)
                      : Icon(Icons.circle_outlined,
                          size: (widget.width / 3) - 15)
                  : const SizedBox(),
            ),
          ))
        ]),
        switch (manager.gameWinner) {
          Player.human => const Text(
              'YOU WIN!!',
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
          Player.menace => const Text(
              'M.E.N.A.C.E WINS!!',
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          Player.none => const Text('') //Show Nothing
        },
        if (kDebugMode) ...{
          ElevatedButton(
            child: const Text("Store To Disk"),
            onPressed: () {
              setState(() {
                manager.aiManager.store();
              });
            },
          ),
          ElevatedButton(
            child: const Text("Read from Disk"),
            onPressed: () {
              setState(() {
                manager.aiManager.read();
              });
            },
          ),
          ElevatedButton(
            child: const Text("Reset Disk"),
            onPressed: () {
              setState(() {
                manager.aiManager.resetDisk();
              });
            },
          ),
        },

        // (manager.gameWinner == Player.human)
        //     ?
        //     : const Text(
        //         'M.E.N.A.C.E WINS!!',
        //         style: TextStyle(fontSize: 30, color: Colors.red),
        //       ),
      ],
    );
  }
}
