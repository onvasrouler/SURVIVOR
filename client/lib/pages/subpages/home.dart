import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/tips.dart';
import 'package:soul_connection/pages/subpages/widgets/animated_graphic.dart';
import 'package:soul_connection/theme/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HoverMixin<HomePage> {
  List<Widget> graphs(bool isLandscaped) {
    return [
      for (int i = 0; i < 3; i++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Builder(
            builder: (context) {
              return MouseRegion(
                onEnter: (event) {
                  final renderBox = context.findRenderObject() as RenderBox;
                  onHoverCard(event, i, renderBox);
                },
                onHover: (event) {
                  final renderBox = context.findRenderObject() as RenderBox;
                  onHoverCard(event, i, renderBox);
                },
                onExit: onExit,
                child: Transform(
                  transform: hoveredIndex == i
                      ? getTransformMatrix()
                      : Matrix4.identity(),
                  alignment: FractionalOffset.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isLandscaped
                        ? dw(context) / 1.2
                        : hoveredIndex == i
                            ? dw(context) / 4.5
                            : dw(context) / 5,
                    height: hoveredIndex == i ? 160 : 140,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: AnimatedBarChart(
                      data: data[i]['data'],
                      label: data[i]['label'],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isWearOs(context)) sh(30) else sh(10),
            if (kIsWeb || isWearOs(context))
              Text(
                'SOUL CONNECTION',
                style: TextStyle(
                  fontSize: dw(context) * 0.05,
                  fontWeight: isWearOs(context) ? FontWeight.bold : null,
                  fontFamily: 'Arial',
                ),
              ),
            if (kIsWeb)
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: dw(context) * 0.025,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
            if (!isWearOs(context)) sh(10),
            if (!isWearOs(context))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 1.5,
                  color: Colors.black,
                  width: dw(context),
                ),
              ),
            sh(0),
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
                    'Table name',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: dw(context) < 700
                      ? dw(context) / 1.2
                      : dw(context) / 1.55,
                  height: kIsWeb ? 289 : null,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: SingleChildScrollView(
                    child: Table(
                      border: const TableBorder.symmetric(
                        inside: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      children: [
                        for (int row = 0; row <= products.length; row++)
                          if (row == 0)
                            TableRow(
                              decoration: const BoxDecoration(
                                color: AppColor.darkgrey,
                              ),
                              children: [
                                for (int col = 0;
                                    col < tableLabels.length;
                                    col++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      tableLabels[col],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: isWearOs(context) ? 7 : null,
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          else
                            TableRow(
                              children: [
                                for (int col = 0;
                                    col < tableLabels.length;
                                    col++)
                                  if (col == 0)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '$row',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              isWearOs(context) ? 7 : null,
                                        ),
                                      ),
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        products[row - 1]
                                            [tableLabels[col].toLowerCase()],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              isWearOs(context) ? 7 : null,
                                        ),
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
            if (isWearOs(context)) const TipsPage(),
          ],
        ),
      ),
    );
  }
}
