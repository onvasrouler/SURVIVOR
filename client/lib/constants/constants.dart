import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/models/tips.module.dart';

late SharedPreferences localUser;

List<Customer> allCustomers = [];

List<Tips> allTips = [];

double dh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double dw(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget sh(double height) {
  return Container(height: height);
}

Widget sw(double width) {
  return Container(width: width);
}

String token =
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uX2lkIjoiYjM1MDRjZWItNzAyYS00YzY5LWI0ZmYtYjk5NTZkZDU0YzRmIiwiaWF0IjoxNzI1NTI5ODcxfQ.mwBOL5362P9VU8dT7fflEcIVOOtPVJKJ5CowEEXH_JI';