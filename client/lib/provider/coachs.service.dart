import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/employees.module.dart';

class CoachsService {
  static Future<bool> fetchEmployees() async {
    final employees = await http.get(
      Uri.parse('http://82.65.59.34:3333/soul_connection_api/employee'),
      headers: {
        'session': token,
      },
    );
    if (employees.statusCode == 200) {
      List<dynamic> bodyEmployees = jsonDecode(employees.body)['data'];
      allCoaches = bodyEmployees
          .map((json) => EmployeeModel.fromJson(json))
          .where((EmployeeModel e) => e.work == 'Coach')
          .toList();
      return true;
    } else {
      return false;
    }
  }
}
