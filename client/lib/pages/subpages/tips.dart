import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';

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
                    itemCount: allTips.length,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Column (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        allTips[index].title,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        allTips[index].tips,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
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
