import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomersGraph extends StatefulWidget {
  const CustomersGraph({super.key});

  @override
  State<CustomersGraph> createState() => _CustomersGraphState();
}

class _CustomersGraphState extends State<CustomersGraph> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 14,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 1:
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
                  case 14:
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        '15 Jul, 2024',
                        style: TextStyle(
                          color: Color(0xff97abc1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  case 30:
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
                }
                return const Text('');
              },
            ),
          ),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              interval: 1200,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Color(0xff97abc1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(),
        ),
        minY: 0,
        maxY: 1200,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(1, 100),
              FlSpot(3, 200),
              FlSpot(5, 150),
              FlSpot(7, 300),
              FlSpot(9, 250),
              FlSpot(11, 400),
              FlSpot(13, 350),
              FlSpot(15, 500),
              FlSpot(17, 450),
              FlSpot(19, 600),
              FlSpot(21, 550),
              FlSpot(23, 700),
              FlSpot(25, 650),
              FlSpot(27, 800),
              FlSpot(29, 750),
              FlSpot(30, 1000),
            ],
            isCurved: false,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xffebeeff),
            ),
            color: const Color(0xff6d85ff),
            dotData: const FlDotData(show: false),
          ),
          LineChartBarData(
            spots: const [
              FlSpot(1, 90),
              FlSpot(3, 250),
              FlSpot(5, 200),
              FlSpot(7, 350),
              FlSpot(9, 150),
              FlSpot(11, 500),
              FlSpot(13, 320),
              FlSpot(15, 580),
              FlSpot(17, 380),
              FlSpot(19, 520),
              FlSpot(21, 480),
              FlSpot(23, 620),
              FlSpot(25, 700),
              FlSpot(27, 730),
              FlSpot(29, 680),
              FlSpot(30, 900),
            ],
            isCurved: false,
            isStrokeCapRound: true,
            barWidth: 2,
            color: const Color(0xffbac9ff),
            dashArray: [5, 5],
            dotData: const FlDotData(show: false),
          ),
        ],
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
