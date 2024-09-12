import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';

class PieChartSample extends StatelessWidget {
  const PieChartSample({super.key});

  Widget legend(String provider, int count, Color color, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            sw(3),
            Text(
              provider,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff8fa4bd),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            sw(5),
            Text(
              '$percentage%',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff8fa4bd),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: 150,
        child: PieChart(
          PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 30,
            sections: _buildSections(),
          ),
        ),
      ),
      sh(30),
      SizedBox(
        width: dw(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                legend(
                  'Dating app',
                  305,
                  const Color(0xff748bff),
                  45,
                ),
                sw(20),
                legend(
                  'Social Media',
                  205,
                  const Color(0xffbbabff),
                  35,
                ),
              ],
            ),
            sh(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                legend(
                  'XXX app',
                  35,
                  const Color(0xffffa4cf),
                  15,
                ),
                sw(20),
                legend(
                  'XX Media',
                  15,
                  const Color(0xffffda69),
                  5,
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }

  List<PieChartSectionData> _buildSections() {
    return [
      PieChartSectionData(
        color: const Color(0xff748bff),
        value: 45,
        radius: 60,
        showTitle: false,
      ),
      PieChartSectionData(
        color: const Color(0xffbbabff),
        value: 20,
        radius: 60,
        showTitle: false,
      ),
      PieChartSectionData(
        color: const Color(0xffffa4cf),
        value: 15,
        radius: 60,
        showTitle: false,
      ),
      PieChartSectionData(
        color: const Color(0xffffda69),
        value: 10,
        radius: 60,
        showTitle: false,
      ),
    ];
  }
}
