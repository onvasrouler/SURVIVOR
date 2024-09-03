import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/utility/utility.dart';

class Drawerbar extends StatefulWidget {
  const Drawerbar({super.key, required this.user, required this.onTabChange});
  final UserModel user;
  final Function(int) onTabChange;

  @override
  State<Drawerbar> createState() => _DrawerbarState();
}

class _DrawerbarState extends State<Drawerbar> {
  int? hoveredIndex;

  Widget tabButton(String title, int index) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredIndex = null;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: hoveredIndex == index
              ? const Color.fromARGB(255, 0, 93, 254)
              : Colors.blue,
          width: 120,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.memory(
                widget.user.profilePic!,
                height: (dw(context) / 10) > 120 ? 120 : (dw(context) / 10),
              ),
            ),
          ),
        ),
        sh(10),
        Text(
          widget.user.name!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          widget.user.work!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        sh(70),
        for (int i = 0; i < 6; i++) ...[
          GestureDetector(
            onTap: () {
              widget.onTabChange(i);
            },
            child: tabButton(
              Utility.tabName(i),
              i,
            ),
          ),
          sh(20),
        ],
      ],
    );
  }
}
