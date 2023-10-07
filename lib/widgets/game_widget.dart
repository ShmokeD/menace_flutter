import 'package:flutter/material.dart';

import '../managers/manager.dart';

class GameWidget extends StatefulWidget {
  GameWidget({super.key, required this.width});
  final double width;

  final GameManager manager = GameManager(Player.human);

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
    var state = widget.manager.gameState.gameState;
    return Column(
      children: [
        Row(children: [
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          )
        ]),
        Row(children: [
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          )
        ]),
        Row(children: [
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
            width: 5,
            height: (widget.width / 3) - 10,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () => setState(() {
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
                  : Icon(Icons.airplanemode_off_outlined,
                      size: (widget.width / 3) - 15),
            ),
          ),
          Container(
              width: 5, height: (widget.width / 3) - 10, color: Colors.black)
        ]),
      ],
    );
  }
}
