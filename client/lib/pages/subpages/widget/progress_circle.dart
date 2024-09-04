import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatefulWidget {
  const CircleProgressIndicator({super.key, this.hoveredIndex});
  final int? hoveredIndex;

  @override
  CircleProgressIndicatorState createState() => CircleProgressIndicatorState();
}

class CircleProgressIndicatorState extends State<CircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: (widget.hoveredIndex != 2 ? 200 : 270),
              width: (widget.hoveredIndex != 2 ? 200 : 270),
              child: const CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 207, 207, 207),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(
              '${(_animation.value * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: (widget.hoveredIndex != 2 ? 200 : 270),
              width: (widget.hoveredIndex != 2 ? 200 : 270),
              child: CircularProgressIndicator(
                value: _animation.value,
                strokeWidth: 3.0,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
