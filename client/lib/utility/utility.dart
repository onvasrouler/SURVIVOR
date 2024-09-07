import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility {
  static String tabName(int index) {
    return [
      'Home',
      'Coaches',
      'Customers',
      'Statistics',
      'Wardrobe',
      'Matches',
      'Tips',
      'Events'
    ][index];
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
