import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EventGraph extends StatefulWidget {
  const EventGraph({super.key});

  @override
  State<EventGraph> createState() => _EventGraphState();
}

class _EventGraphState extends State<EventGraph> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Padding(
                      padding: EdgeInsets.only(left: 70, top: 20),
                      child: Text(
                        '01 Jul, 2024',
                        style: TextStyle(
                          color: Color(0xff97abc1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  case 29:
                    return const Padding(
                      padding: EdgeInsets.only(right: 70, top: 20),
                      child: Text(
                        '30 Jul, 2024',
                        style: TextStyle(
                          color: Color(0xff97abc1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
          leftTitles: const AxisTitles(),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 200,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(),
        maxY: 1200,
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return [
      _makeGroupData(0, 100),
      _makeGroupData(1, 1100),
      _makeGroupData(2, 800),
      _makeGroupData(3, 600),
      _makeGroupData(4, 400),
      _makeGroupData(5, 900),
      _makeGroupData(6, 700),
      _makeGroupData(7, 1000),
      _makeGroupData(8, 500),
      _makeGroupData(9, 1100),
      _makeGroupData(10, 900),
      _makeGroupData(11, 1200),
      _makeGroupData(12, 950),
      _makeGroupData(13, 850),
      _makeGroupData(14, 600),
      _makeGroupData(15, 1000),
      _makeGroupData(16, 400),
      _makeGroupData(17, 900),
      _makeGroupData(18, 750),
      _makeGroupData(19, 950),
      _makeGroupData(20, 600),
      _makeGroupData(21, 1100),
      _makeGroupData(22, 700),
      _makeGroupData(23, 850),
      _makeGroupData(24, 750),
      _makeGroupData(25, 1100),
      _makeGroupData(26, 900),
      _makeGroupData(27, 700),
      _makeGroupData(28, 950),
      _makeGroupData(29, 650),
    ];
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xff99aaff),
          borderRadius: BorderRadius.circular(0),
          width: 10,
        ),
      ],
    );
  }
}
