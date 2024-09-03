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
  double _rotationX = 0;
  double _rotationY = 0;
  List<String> tableLabels = ['seq', 'Product', 'Category', 'Period', 'Sales'];

  List<Map<String, dynamic>> products = [
    {
      'product': 'Tea ☕️',
      'category': 'cat1',
      'period': 'Jan-11',
      'sales': '20K',
    },
    {
      'product': 'Coffee ☕️',
      'category': 'cat2',
      'period': 'Jan-11',
      'sales': '15K'
    },
    {
      'product': 'Milk 🥛',
      'category': 'cat3',
      'period': 'Jan-11',
      'sales': '5K',
    },
    {
      'product': 'Cereal 🌾',
      'category': 'cat4',
      'period': 'Jan-11',
      'sales': '30K'
    },
    {
      'product': 'Chocolate 🍫',
      'category': 'cat5',
      'period': 'Jan-11',
      'sales': '25K'
    },
    {
      'product': 'Pasta 🍝',
      'category': 'cat6',
      'period': 'Jan-11',
      'sales': '205K'
    },
    {
      'product': 'Pizza 🍕',
      'category': 'cat7',
      'period': 'Jan-11',
      'sales': '15K'
    },
    {
      'product': 'Avocado 🥑',
      'category': 'cat8',
      'period': 'Jan-11',
      'sales': '21K'
    },
    {
      'product': 'Tomato 🍅',
      'category': 'ca9',
      'period': 'Jan-11',
      'sales': '15K'
    },
  ];

  void _onHover(PointerEvent event, int index, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      _hoveredIndex = index;
      _rotationY = (((position.dx - middleX) / middleX) + 0.1) * 0.2;
      _rotationX = (((position.dy - middleY) / middleY) + 0.8) * 0.8;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _hoveredIndex = null;
      _rotationX = 0;
      _rotationY = 0;
    });
  }

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

  List<Widget> graphs(bool isLandscaped) {
    return [
      for (int i = 0; i < 3; i++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: MouseRegion(
            onEnter: (event) => _onHover(event, i, context),
            onHover: (event) => _onHover(event, i, context),
            onExit: _onExit,
            child: Transform(
              transform: _hoveredIndex == i
                  ? (Matrix4.identity()
                    ..setEntry(2, 2, 0.001)
                    ..rotateX(_rotationX)
                    ..rotateY(_rotationY))
                  : Matrix4.identity(),
              alignment: FractionalOffset.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isLandscaped
                    ? dw(context) / 1.2
                    : _hoveredIndex == i
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
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          if (dw(context) > 700) ...[
            SizedBox(
              height: 200,
              width: dw(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: graphs(false),
              ),
            ),
          ] else ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: graphs(true),
            ),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  'Statistics',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width:
                    dw(context) < 700 ? dw(context) / 1.2 : dw(context) / 1.55,
                height: 289,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Table(
                    border: const TableBorder.symmetric(
                      inside: BorderSide(color: Colors.grey),
                    ),
                    children: [
                      for (int row = 0; row <= 8; row++)
                        if (row == 0)
                          TableRow(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(9),
                                topRight: Radius.circular(9),
                              ),
                            ),
                            children: [
                              for (int col = 0; col < tableLabels.length; col++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tableLabels[col],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          )
                        else
                          TableRow(
                            children: [
                              for (int col = 0; col < tableLabels.length; col++)
                                if (col == 0)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$row',
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      products[row - 1]
                                          [tableLabels[col].toLowerCase()],
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                            ],
                          ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
