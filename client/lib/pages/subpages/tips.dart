import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  int? _hoveredIndex;
  double _rotationX = 0;
  double _rotationY = 0;

  void _onHover(PointerEvent event, int index, RenderBox renderBox) {
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      _hoveredIndex = index;
      _rotationY = ((position.dx - middleX) / middleX) * 0.1;
      _rotationX = -((position.dy - middleY) / middleY) * 0.1;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _hoveredIndex = null;
      _rotationX = 0;
      _rotationY = 0;
    });
  }

  List<String> tips = [
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
    'Asuper tip ot help the coach with their customers',
  ];

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
            appBar(context, 'Tips'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          _onHover(event, index, renderBox);
                        },
                        onHover: (event) {
                          final renderBox =
                              context.findRenderObject() as RenderBox;
                          _onHover(event, index, renderBox);
                        },
                        onExit: _onExit,
                        child: Transform(
                          transform: _hoveredIndex == index
                              ? (Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateX(_rotationX)
                                ..rotateY(_rotationY))
                              : Matrix4.identity(),
                          alignment: FractionalOffset.center,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
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
    );
  }
}
