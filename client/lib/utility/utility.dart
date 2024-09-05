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
      const Icon(Icons.home, color: Colors.blue),
      const Icon(Icons.people, color: Colors.blue),
      const Icon(Icons.person, color: Colors.blue),
      const Icon(Icons.bar_chart, color: Colors.blue),
      const Icon(Icons.shopping_bag, color: Colors.blue),
      const Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.blue),
      const Icon(Icons.lightbulb, color: Colors.blue),
      const Icon(Icons.event, color: Colors.blue),
    ][index];
  }
}
