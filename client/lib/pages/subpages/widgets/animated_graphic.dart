import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart' as charts;

class AnimatedBarChart extends StatefulWidget {
  final List<double> data;
  final String label;

  const AnimatedBarChart({super.key, required this.data, required this.label});

  @override
  AnimatedBarChartState createState() => AnimatedBarChartState();
}

class AnimatedBarChartState extends State<AnimatedBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animations = widget.data.asMap().entries.map((entry) {
      int index = entry.key;
      return CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index / widget.data.length,
          (index + 1) / widget.data.length,
          curve: Curves.easeInOutQuad,
        ),
      );
    }).toList();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return chartToRun(
          widget.data
              .asMap()
              .entries
              .map((entry) => entry.value * _animations[entry.key].value)
              .toList(),
          widget.label,
        );
      },
    );
  }

  Widget chartToRun(List<double> data, String label) {
    charts.LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    charts.ChartData chartData;
    charts.ChartOptions chartOptions = const charts.ChartOptions();

    chartData = charts.ChartData(
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

    var verticalBarChartContainer = charts.VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = charts.VerticalBarChart(
      painter: charts.VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }
}
