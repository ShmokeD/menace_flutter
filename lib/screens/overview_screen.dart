import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:menace_flutter/managers/ai_manager.dart';

class OverViewScreen extends StatelessWidget {
  OverViewScreen({super.key, required this.aiManager});
  final AiManager aiManager;
  final List<FlSpot> spots = [];
  @override
  Widget build(BuildContext context) {
    aiManager.winRateData.forEach(
      (key, value) => spots.add(FlSpot(key, value)),
    );
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
          ],
        )
        // body: Column(children: [LineChart(LineChartData(maxY: 100))]),
        );
  }
}
