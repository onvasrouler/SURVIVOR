import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';

Column appBar(BuildContext context, String title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      sh(30),
      Text(
        title,
        style: TextStyle(
          fontSize: dw(context) * 0.05,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arial',
        ),
      ),
      sh(10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          height: 1,
          color: Colors.grey,
          width: dw(context),
        ),
      ),
      sh(20),
    ],
  );
}