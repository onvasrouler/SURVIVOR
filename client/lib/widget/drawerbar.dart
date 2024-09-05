import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/auth/onboard.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/user.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/profile.dart';
import 'package:soul_connection/utility/utility.dart';

class Drawerbar extends StatefulWidget {
  const Drawerbar({super.key, required this.user, required this.onTabChange});
  final UserModel user;
  final Function(int) onTabChange;

  @override
  State<Drawerbar> createState() => _DrawerbarState();
}

class _DrawerbarState extends State<Drawerbar> with HoverMixin<Drawerbar> {
  Widget tabButton(String title, int index) {
    return MouseRegion(
      onEnter: (_) => setHoveredIndex(index),
      onExit: (_) => setHoveredIndex(null),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHovered(index) ? Colors.white : Colors.blue,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isHovered(index) ? Colors.grey : Colors.transparent,
            ),
          ),
          width: 120 + (isHovered(index) ? 10 : 0),
          height: 40 + (isHovered(index) ? 10 : 0),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isHovered(index) ? Colors.black : Colors.white,
              fontSize: 17,
            ),
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
          child: GestureDetector(
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    user: widget.user,
                  ),
                ),
              );
            },
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              localUser.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OnBoardPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Transform.rotate(
                                  angle: -0.8,
                                  child: const Icon(
                                    CupertinoIcons.hand_raised_fill,
                                    color: Colors.red,
                                  ),
                                ),
                                const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: Builder(
              builder: (context) {
                return MouseRegion(
                  onEnter: (event) {
                    final renderBox = context.findRenderObject() as RenderBox;
                    onHoverCard(event, 9, renderBox);
                  },
                  onHover: (event) {
                    final renderBox = context.findRenderObject() as RenderBox;
                    onHoverCard(event, 9, renderBox);
                  },
                  onExit: onExit,
                  child: Transform(
                    transform: hoveredIndex == 9
                        ? getTransformMatrix()
                        : Matrix4.identity(),
                    alignment: FractionalOffset.center,
                    child: Hero(
                      tag: 'profilePic',
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: (((dw(context) / 10) > 120
                                ? 120
                                : (dw(context) / 10)) +
                            (hoveredIndex != 9 ? 0 : 20)),
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
                  ),
                );
              },
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
        sh(20),
        for (int i = 0; i < 8; i++) ...[
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
