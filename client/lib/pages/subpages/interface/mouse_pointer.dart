import 'package:flutter/widgets.dart';

mixin HoverMixin<T extends StatefulWidget> on State<T> {
  int? hoveredIndex;
  int? hoveredIndexProfile;
  double rotationX = 0;
  double rotationY = 0;

  void onHover(PointerEvent event, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      hoveredIndexProfile = 1;
      rotationY = (((position.dx - middleX) / middleX) + 0.1) * 0.2;
      rotationX = (((position.dy - middleY) / middleY) + 0.8) * 0.8;
    });
  }

  void onHoverGraph(PointerEvent event, int index, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      hoveredIndex = index;
      rotationY = (((position.dx - middleX) / middleX) + 0.1) * 0.2;
      rotationX = (((position.dy - middleY) / middleY) + 0.8) * 0.8;
    });
  }

  void onHoverCard(PointerEvent event, int index, RenderBox renderBox) {
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      hoveredIndex = index;
      rotationY = ((position.dx - middleX) / middleX) * 0.1;
      rotationX = -((position.dy - middleY) / middleY) * 0.1;
    });
  }

  void onExit(PointerEvent event) {
    setState(() {
      hoveredIndexProfile = null;
      rotationX = 0;
      rotationY = 0;
    });
  }

  Matrix4 getTransformMatrix() {
    return (Matrix4.identity()
      ..setEntry(2, 2, 0.001)
      ..rotateX(rotationX)
      ..rotateY(rotationY));
  }

  bool isHovered(int index) {
    return hoveredIndex == index;
  }

  void setHoveredIndex(int? index) {
    setState(() {
      hoveredIndex = index;
    });
  }
}
