import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';

class Utility {
  static List<String> tabName() {
    return [
      'Dashboard',
      'Coaches',
      'Customers',
      if (user!.work != 'Coach') 'Statistics',
      'Wardrobe',
      'Matches',
      'Tips',
      'Events'
    ];
  }

  static Icon tabIcon(int index) {
    return [
      const Icon(Icons.home, color: Colors.black),
      const Icon(Icons.people, color: Colors.black),
      const Icon(Icons.person, color: Colors.black),
      const Icon(Icons.bar_chart, color: Colors.black),
      const Icon(Icons.shopping_bag, color: Colors.black),
      const Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.black),
      const Icon(Icons.lightbulb, color: Colors.black),
      const Icon(Icons.event, color: Colors.black),
    ][index];
  }
}
