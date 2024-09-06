import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/models/employees.module.dart';

late SharedPreferences localUser;

List<CustomerModel> allCustomers = [];

List<EmployeeModel> allCoaches = [];

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

