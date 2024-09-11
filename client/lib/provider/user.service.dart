import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/user.module.dart';

class UserService {
  static Future<bool> fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://82.65.59.34:3333/api/me'),
      headers: {
        'session': localUser.getString('token')!,
      },
    );
    if (response.statusCode == 200) {
      dynamic bodyUser = jsonDecode(response.body)['data'];
      user = UserModel.fromJson(bodyUser);
      return true;
    } else {
      return false;
    }
  }
}
