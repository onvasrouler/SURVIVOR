import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/subpages/coaches.dart';
import 'package:soul_connection/pages/subpages/customers.dart';
import 'package:soul_connection/pages/subpages/event.dart';
import 'package:soul_connection/pages/subpages/home.dart';
import 'package:soul_connection/pages/subpages/statistics.dart';
import 'package:soul_connection/pages/subpages/tips.dart';
import 'package:soul_connection/pages/utility/utility.dart';
import 'package:soul_connection/pages/widget/drawerbar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.user});
  final UserModel user;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int tabIndex = 2;

  Widget tabPage(int index) {
    return [
      const HomePage(),
      const CoachesPage(),
      const CustomersPage(),
      const StatisticsPage(),
      const TipsPage(),
      const EventPage(),
    ][index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 249, 249),
      bottomNavigationBar: dw(context) <= 700
          ? BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  tabIndex = index;
                });
              },
              selectedItemColor: Colors.blue,
              currentIndex: tabIndex,
              items: [
                for (int i = 0; i < 6; i++)
                  BottomNavigationBarItem(
                    icon: Utility.tabIcon(i),
                    label: Utility.tabName(i),
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
                  user: widget.user,
                  onTabChange: (int tab) {
                    setState(() {
                      tabIndex = tab;
                    });
                  },
                ),
              ),
            Center(
              child: Container(
                color: Colors.grey,
                width: 1,
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
