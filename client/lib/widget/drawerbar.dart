import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/theme/color.dart';
import 'package:soul_connection/utility/utility.dart';

class Drawerbar extends StatefulWidget {
  const Drawerbar({super.key, required this.onTabChange});
  final Function(int) onTabChange;

  @override
  State<Drawerbar> createState() => _DrawerbarState();
}

class _DrawerbarState extends State<Drawerbar> with HoverMixin<Drawerbar> {
  int tabIndex = 0;
  Widget tabButton(String title, int index) {
    return MouseRegion(
      onEnter: (_) => setHoveredIndex(index),
      onExit: (_) => setHoveredIndex(null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 60,
        width: dw(context) - 20,
        decoration: BoxDecoration(
          color: index == tabIndex
              ? AppColor.darkgrey
              : !isHovered(index)
                  ? Colors.white
                  : AppColor.darkgrey,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sh(60),
        for (int i = 0; i < 8; i++) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                widget.onTabChange(i);
                setState(() {
                  tabIndex = i;
                });
              },
              child: tabButton(
                Utility.tabName(i),
                i,
              ),
            ),
          ),
          if (i != 7)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Container(
                  color: Colors.black,
                  height: 1.5,
                  width: dw(context) - 30,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
