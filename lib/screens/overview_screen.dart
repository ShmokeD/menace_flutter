import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:menace_flutter/managers/manager.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({super.key, required this.manager});
  final GameManager manager;

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = [FlSpot.zero];
    widget.manager.aiManager.winRateData.forEach(
      (key, value) => spots.add(FlSpot(key, value)),
    );
    List<Widget> gridTiles = [];
    Map<int, int> positionValues = widget.manager.aiManager.positionValues;
    for (var pos in positionValues.keys) {
      gridTiles.add(GridTile(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(positionValues[pos]!.toString()),
          ),
        ),
      ));
    }
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: [
            const Center(
              child: Text(
                "First player",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Menace",
                  style: TextStyle(fontSize: 15),
                ),
                Switch(
                    value: (Player.human == widget.manager.firstPlayer),
                    onChanged: (state) {
                      setState(() {
                        widget.manager.setHumanFirstPlayer(state);
                      });
                    }),
                const Text(
                  "You",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ), // Swit
            const Center(
              child: Text(
                "M.E.N.A.C.E Win Rate",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                    )
                  ],
                  gridData: const FlGridData(
                    verticalInterval: 10,
                    horizontalInterval: 10,
                    show: true,
                  ),
                  maxY: 100,
                  maxX: spots.length.toDouble(),
                  minX: 0,
                  minY: 0,
                ),
                curve: Curves.bounceInOut,
              ),
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.maxFinite,
              child: GridView.count(
                crossAxisCount: 3,
                children: gridTiles,
              ),
            ),
          ],
        )
        // body: Column(children: [LineChart(LineChartData(maxY: 100))]),
        );
  }
}
