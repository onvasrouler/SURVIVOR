import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/pages/auth/onboard.dart';
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
  int? _hoveredIndexProfile;
  double _rotationX = 0;
  double _rotationY = 0;

  void _onHover(PointerEvent event, BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = event.localPosition;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      _hoveredIndexProfile = 1;
      _rotationY = (((position.dx - middleX) / middleX) + 0.1) * 0.2;
      _rotationX = (((position.dy - middleY) / middleY) + 0.8) * 0.8;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _hoveredIndexProfile = null;
      _rotationX = 0;
      _rotationY = 0;
    });
  }

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: hoveredIndex == index ? Colors.blueAccent : Colors.blue,
          width: 120 + (hoveredIndex == index ? 10 : 0),
          height: 40 + (hoveredIndex == index ? 10 : 0),
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
          child: GestureDetector(
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
                              'No',
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
            child: MouseRegion(
              onEnter: (event) => _onHover(event, context),
              onHover: (event) => _onHover(event, context),
              onExit: _onExit,
              child: Transform(
                transform: (Matrix4.identity()
                  ..setEntry(2, 2, 0.001)
                  ..rotateX(_rotationX)
                  ..rotateY(_rotationY)),
                alignment: FractionalOffset.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height:
                      (((dw(context) / 10) > 120 ? 120 : (dw(context) / 10)) +
                          (_hoveredIndexProfile == null ? 0 : 20)),
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
