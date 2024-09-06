import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';

class CustomersService {
  static Future<bool> fetchCustomers() async {
    final customers = await http.get(
      Uri.parse('http://82.65.59.34:3333/soul_connection_api/customer'),
      headers: {
        'session': token,
      },
    );
    if (customers.statusCode == 200) {
      List<dynamic> bodyCustomers = jsonDecode(customers.body)['data'];
      allCustomers =
          bodyCustomers.map((json) => CustomerModel.fromJson(json)).toList();
      return true;
    } else {
      return false;
    }
  }
}
