import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/widget/drawerbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: dw(context) <= 700
          ? BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  tabIndex = index;
                });
              },
              selectedItemColor: Colors.blue,
              currentIndex: tabIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.blue),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people, color: Colors.blue),
                  label: 'Coaches',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.blue),
                  label: 'Customers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart, color: Colors.blue),
                  label: 'Statistics',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb, color: Colors.blue),
                  label: 'Tips',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event, color: Colors.blue),
                  label: 'Events',
                ),
              ],
            )
          : null,
      body: SizedBox(
        height: dh(context),
        width: dw(context),
        child: Row(
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
            Container(
              color: Colors.grey,
              width: 1,
              height: dh(context) - 80,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: (dw(context) * 0.8) - 1,
              height: dh(context),
              color: [Colors.white, Colors.red][tabIndex % 2],
            ),
          ],
        ),
      ),
    );
  }
}
