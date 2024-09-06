import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';

class CustomersService {
  static Future<bool> fetchCustomers() async {
    final response = await http.get(
      Uri.parse('http://82.65.59.34:3333/soul_connection_api/customer'),
      headers: {
        'session': token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      allCustomers = body.map((json) => Customer.fromJson(json)).toList();
      return true;
    } else {
      return false;
    }
  }
}
