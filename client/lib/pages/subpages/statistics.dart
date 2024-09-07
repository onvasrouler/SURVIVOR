import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';
import 'package:soul_connection/theme/color.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with HoverMixin<StatisticsPage> {
  Widget firstGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartData = ChartData(
      dataRows: const [
        [200.0, 190.0, 180.0, 200.0, 250.0, 300.0],
        [300.0, 280.0, 260.0, 240.0, 300.0, 350.0],
      ],
      xUserLabels: const [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June'
      ],
      dataRowsLegends: const [
        'First count',
        'Second count',
      ],
      dataRowsColors: const [
        AppColor.grey,
        Color.fromARGB(255, 195, 195, 195),
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

  Widget secondGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(
      dataRows: const [
        [10.0, 600.0, 1000000.0],
        [20.0, 1000.0, 1500000.0],
      ],
      xUserLabels: const ['First', 'Second', 'Third'],
      dataRowsLegends: const [
        'Spring',
        'Summer',
      ],
      dataRowsColors: const [Color.fromARGB(255, 195, 195, 195), AppColor.grey],
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

  Widget thirdGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        yTransform: log10,
        yInverseTransform: inverseLog10,
      ),
    );
    chartData = ChartData(
      dataRows: const [
        [10.0, 600.0, 1000000.0],
        [20.0, 1000.0, 1500000.0],
      ],
      xUserLabels: const ['First', 'Second', 'Third'],
      dataRowsLegends: const [
        'Spring',
        'Summer',
      ],
      dataRowsColors: const [Color.fromARGB(255, 195, 195, 195), AppColor.grey],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget fourthGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();

    chartData = ChartData(
      dataRows: const [
        [-9.0, -8.0, -8.0, -5.0, -8.0],
        [-1.0, -2.0, -4.0, -1.0, -1.0],
        [7.0, 8.0, 7.0, 11.0, 9.0],
        [3.0, 2.0, 1.0, 3.0, 3.0],
      ],
      xUserLabels: const ['1', '2', '3', '4', '5'],
      dataRowsLegends: const [
        '-2% or less',
        '-2% to 0%',
        '0% to +2%',
        'more than +2%',
      ],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.darkgrey,
        AppColor.lightgrey,
        AppColor.deepblue,
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

  Widget fifthGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartData = ChartData(
      dataRows: const [
        [9.0, 4.0, 3.0, 9.0],
        [7.0, 6.0, 7.0, 6.0],
        [4.0, 9.0, 6.0, 8.0],
        [3.0, 9.0, 10.0, 1.0],
      ],
      xUserLabels: const ['Unit1', 'Unit2', 'Unit3', 'Unit4'],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.darkgrey,
        AppColor.lightgrey,
        AppColor.deepblue,
      ],
      dataRowsLegends: const ['Java', 'Dart', 'Python', 'Newspeak'],
      yUserLabels: const [
        'Low',
        'Medium',
        'High',
      ],
      chartOptions: chartOptions,
    );

    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget sixGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions.noLabels();

    chartData = ChartData(
      dataRows: const [
        [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
        [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
        [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
        [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
      ],
      xUserLabels: const ['1', '2', '3', '4', '5', '6'],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.darkgrey,
        AppColor.lightgrey,
        AppColor.deepblue,
      ],
      dataRowsLegends: const [
        'Spring',
        'Summer',
        'Fall',
        'Winter',
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

  Widget sevensGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions.noLabels();

    chartData = ChartData(
      dataRows: const [
        [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
        [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
        [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
        [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
      ],
      xUserLabels: const ['1', '2', '3', '4', '5', '6'],
      dataRowsLegends: const [
        'Spring',
        'Summer',
        'Fall',
        'Winter',
      ],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.darkgrey,
        AppColor.lightgrey,
        AppColor.deepblue,
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget eightGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartData = ChartData(
      dataRows: const [
        [20.0, 25.0, 30.0, 35.0, 40.0, 20.0],
        [35.0, 40.0, 20.0, 25.0, 30.0, 20.0],
      ],
      xUserLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      dataRowsLegends: const [
        'Test Series1',
        'Test Series2',
      ],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.lightgrey,
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget nineGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        startYAxisAtDataMinRequested: true,
      ),
    );
    chartData = ChartData(
      dataRows: const [
        [-20.0, -25.0, -30.0, -35.0, -40.0, -20.0],
        [-35.0, -40.0, -20.0, -25.0, -30.0, -20.0],
      ],
      xUserLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      dataRowsLegends: const [
        '1',
        '2',
      ],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.deepblue,
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget tenGraph() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: chartOptions,
    );
    chartData = ChartData(
      dataRows: const [
        [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
        [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
        [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
        [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
      ],
      xUserLabels: const ['Wolf', 'Deer', 'Owl', 'Mouse', 'Hawk', 'Vole'],
      dataRowsLegends: const [
        'Spring',
        'Summer',
        'Fall',
        'Winter',
      ],
      dataRowsColors: const [
        AppColor.grey,
        AppColor.darkgrey,
        AppColor.lightgrey,
        AppColor.deepblue,
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  List<Widget> graphs() {
    return [
      firstGraph(),
      secondGraph(),
      thirdGraph(),
      fourthGraph(),
      fifthGraph(),
      sixGraph(),
      sevensGraph(),
      eightGraph(),
      nineGraph(),
      tenGraph(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: graphs().length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                height: 200,
                padding: const EdgeInsets.all(5.0),
                child: graphs()[index],
              ),
            );
          },
        ),
      );
    }
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appBar(context, 'Statistics'),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.5,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: graphs().length,
                    itemBuilder: (context, index) {
                      return Builder(
                        builder: (context) {
                          return MouseRegion(
                            onEnter: (event) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              onHoverCard(event, index, renderBox);
                            },
                            onHover: (event) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              onHoverCard(event, index, renderBox);
                            },
                            onExit: onExit,
                            child: Transform(
                              transform: hoveredIndex == index
                                  ? getTransformMatrix()
                                  : Matrix4.identity(),
                              alignment: FractionalOffset.center,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: graphs()[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                sh(200)
              ],
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: dw(context),
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      for (double i = 1; i > 0; i -= 0.1)
                        Colors.white.withOpacity(i)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
