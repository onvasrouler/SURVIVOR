import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/constants/datas.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> with HoverMixin<TipsPage> {
  @override
  Widget build(BuildContext context) {
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
                appBar(context, 'Tips'),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 2.0,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: tips.length,
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
                                  ? (Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateX(rotationX)
                                    ..rotateY(rotationY))
                                  : Matrix4.identity(),
                              alignment: FractionalOffset.center,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      tips[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
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
                      const Color(0xfff2f2f2),
                      for (double i = 1; i > 0; i -= 0.1)
                        const Color(0xfff2f2f2).withOpacity(i)
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
