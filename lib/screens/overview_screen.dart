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
      ),
      body: Column(children: [LineChart(LineChartData(maxY: 100))]),
    );
  }
}
