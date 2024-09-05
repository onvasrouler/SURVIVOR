import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/models/user.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';
import 'package:soul_connection/pages/subpages/widgets/drop_down_button.dart';
import 'package:soul_connection/pages/subpages/widgets/progress_circle.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key, required this.user});
  final UserModel user;

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage>
    with HoverMixin<MatchesPage> {
  Map<String, dynamic> firstCustomer = {
    'name': 'Louis Delanata',
    'id': 1,
    'birthday': '02/03/2006',
    'address': '3 Rue de al Tour 34000 Montpelier, France'
  };
  Map<String, dynamic> secondCustomer = {
    'name': 'Louis Delanata',
    'id': 1,
    'birthday': '02/03/2006',
    'address': '3 Rue de al Tour 34000 Montpelier, France'
  };

  Widget profilePic(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sh(55),
        Builder(
          builder: (context) {
            return MouseRegion(
              onEnter: (event) {
                final renderBox = context.findRenderObject() as RenderBox;
                onHoverCard(event, index, renderBox);
              },
              onHover: (event) {
                final renderBox = context.findRenderObject() as RenderBox;
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
                  height:
                      (((dw(context) / 10) > 140 ? 140 : (dw(context) / 10)) +
                          (hoveredIndex != index ? 0 : 40)),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      widget.user.profilePic!,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        sh(20),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: dw(context) / 4.2,
          child: CustomerDropdown(
            customers: customers,
            onCustomerChange: (Map<String, dynamic> currentCustomer) {
              setState(() {
                if (index == 0) firstCustomer = currentCustomer;
                if (index == 1) secondCustomer = currentCustomer;
              });
            },
          ),
        ),
        sh(15),
        const Text(
          'Leo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: Column(
        children: [
          appBar(context, 'Matches'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: dh(context) / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomPaint(
                painter: GridPainter(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    sw(20),
                    profilePic(0),
                    Builder(
                      builder: (context) {
                        return MouseRegion(
                          onEnter: (event) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            onHoverCard(event, 2, renderBox);
                          },
                          onHover: (event) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            onHoverCard(event, 2, renderBox);
                          },
                          onExit: onExit,
                          child: Transform(
                            transform: hoveredIndex == 2
                                ? getTransformMatrix()
                                : Matrix4.identity(),
                            alignment: FractionalOffset.center,
                            child: CircleProgressIndicator(
                              hoveredIndex: hoveredIndex,
                            ),
                          ),
                        );
                      },
                    ),
                    profilePic(1),
                    sw(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const double step = 20;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
