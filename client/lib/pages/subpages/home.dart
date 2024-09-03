import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/subpages/widget/animated_graphic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _hoveredIndex;
  Widget chartToRun(List<double> data, String label) {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartData = ChartData(
      dataRows: [
        data,
      ],
      dataRowsColors: const [
        Colors.blue,
      ],
      xUserLabels: const ['2019', '2020', '2021', '2022', '2023', '2024'],
      dataRowsLegends: [
        label,
      ],
      chartOptions: chartOptions,
    );
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }

  List<Map<String, dynamic>> data = [
    {
      'label': 'Chocolate',
      'data': [200.0, 80.0, 10.0, 20.0, 25.0, 320.0],
    },
    {
      'label': 'Milk',
      'data': [200.0, 190.0, 180.0, 200.0, 250.0, 300.0],
    },
    {
      'label': 'Cereal',
      'data': [20.0, 190.0, 10.0, 20.0, 25.0, 30.0],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sh(30),
        Text(
          'Soul Connection',
          style: TextStyle(
            fontSize: dw(context) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
        Text(
          'Dashboard',
          style: TextStyle(
            fontSize: dw(context) * 0.02,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Arial',
          ),
        ),
        sh(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 1,
            color: Colors.grey,
            width: dw(context),
          ),
        ),
        sh(10),
        SizedBox(
          height: 200,
          width: dw(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = i),
                    onExit: (_) => setState(() => _hoveredIndex = null),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: _hoveredIndex == i
                          ? dw(context) / 4.5
                          : dw(context) / 5,
                      height: _hoveredIndex == i ? 160 : 140,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        boxShadow: _hoveredIndex == i
                            ? [
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                )
                              ]
                            : [],
                      ),
                      child: AnimatedBarChart(
                        data: data[i]['data'],
                        label: data[i]['label'],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
