import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressChart extends StatelessWidget {
  final double progress;

  const ProgressChart({super.key,
    required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: Stack(
            alignment: Alignment.center,
            children:[
              PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: progress * 100,
                      color: const Color(0xFFE55733),
                      radius: 8,
                      title: '${(progress * 100).toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                          color: Color(0xFF191717),
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.33,
                          height: 0
                      ),
                    ),
                    PieChartSectionData(
                      value: (1 - progress) * 100,
                      color: const Color(0xFF191717),
                      radius: 8,
                      title: '',
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 37,// Space in the middle
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFF191717),
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.33,
                ),
              ),
            ]
        )
    );
  }
}