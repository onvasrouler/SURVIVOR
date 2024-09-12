import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/utility/utility.dart';

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
                DateTime now = DateTime.now();
                String month = Utility.getMonthName(now.month);
                String year = now.year.toString();
                switch (value.toInt()) {
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.only(left: 70, top: 20),
                      child: Text(
                        '01 $month, $year',
                        style: const TextStyle(
                          color: Color(0xff97abc1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  case 14:
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        '15 $month, $year',
                        style: const TextStyle(
                          color: Color(0xff97abc1),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  case 30:
                    return Padding(
                      padding: const EdgeInsets.only(right: 70, top: 20),
                      child: Text(
                        '30 $month, $year',
                        style: const TextStyle(
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
              interval: allCustomers.length.toDouble(),
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
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(1, 10),
              FlSpot(3, 20),
              FlSpot(5, 15),
              FlSpot(7, 30),
              FlSpot(9, 25),
              FlSpot(11, 40),
              FlSpot(13, 35),
              FlSpot(15, 50),
              FlSpot(17, 45),
              FlSpot(19, 60),
              FlSpot(21, 50),
              FlSpot(23, 70),
              FlSpot(25, 65),
              FlSpot(27, 80),
              FlSpot(29, 70),
              FlSpot(30, 100),
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
              FlSpot(1, 9),
              FlSpot(3, 25),
              FlSpot(5, 20),
              FlSpot(7, 35),
              FlSpot(9, 15),
              FlSpot(11, 50),
              FlSpot(13, 32),
              FlSpot(15, 58),
              FlSpot(17, 38),
              FlSpot(19, 52),
              FlSpot(21, 48),
              FlSpot(23, 62),
              FlSpot(25, 70),
              FlSpot(27, 73),
              FlSpot(29, 60),
              FlSpot(30, 90),
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
