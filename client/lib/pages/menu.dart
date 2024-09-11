import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/auth/onboard.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/subpages/coaches.dart';
import 'package:soul_connection/pages/subpages/customers.dart';
import 'package:soul_connection/pages/subpages/event.dart';
import 'package:soul_connection/pages/subpages/home.dart';
import 'package:soul_connection/pages/subpages/matches.dart';
import 'package:soul_connection/pages/subpages/statistics.dart';
import 'package:soul_connection/pages/subpages/tips.dart';
import 'package:soul_connection/pages/subpages/wardrobe.dart';
import 'package:soul_connection/utility/utility.dart';
import 'package:soul_connection/widget/drawerbar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int tabIndex = 0;

  Widget tabPage(int index) {
    return [
      const HomePage(),
      const CoachesPage(),
      const CustomersPage(),
      if (user!.work != 'Coach') const StatisticsPage(),
      const WardrobePage(),
      const MatchesPage(),
      const TipsPage(),
      const EventPage(),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: kIsWeb || isWearOs(context)
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          CupertinoButton(
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
                          CupertinoButton(
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ],
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: const Color.fromARGB(0, 85, 85, 85),
                  ),
                ),
              ),
              title: const Text(
                "Soul Connection",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
      bottomNavigationBar: dw(context) <= 700 && !isWearOs(context)
          ? BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  tabIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              currentIndex: tabIndex,
              items: [
                for (int i = 0; i < Utility.tabName().length; i++)
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Utility.tabIcon(i),
                    label: Utility.tabName()[i],
                  ),
              ],
            )
          : null,
      body: SizedBox(
        height: dh(context),
        width: dw(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dw(context) > 700)
              SizedBox(
                width: dw(context) * 0.2,
                height: dh(context),
                child: Drawerbar(
                  onTabChange: (int tab) {
                    setState(() {
                      tabIndex = tab;
                    });
                  },
                ),
              ),
            if (dw(context) > 700)
              Center(
                child: Container(
                  color: Colors.black,
                  width: 1.5,
                  height: dh(context) - 80,
                ),
              ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: tabPage(tabIndex),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
