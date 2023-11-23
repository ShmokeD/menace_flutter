import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:menace_flutter/managers/ai_manager.dart';

class OverViewScreen extends StatelessWidget {
  const OverViewScreen({super.key, required this.aiManager});
  final AiManager aiManager;
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(spots: [
                      FlSpot(10, 10),
                      FlSpot(20, 20),
                      FlSpot(30, 30),
                      FlSpot(30, 40),
                      FlSpot(80, 50),
                    ])
                  ],
                  gridData: const FlGridData(
                    verticalInterval: 10,
                    horizontalInterval: 10,
                    show: true,
                  ),
                  maxY: 100,
                  maxX: 100,
                  minX: 0,
                  minY: 0,
                ),
                curve: Curves.bounceInOut,
              ),
            ),
          ],
        )
        // body: Column(children: [LineChart(LineChartData(maxY: 100))]),
        );
  }
}
