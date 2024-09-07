import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';

class AuthService {
  static Future<String?> signUp(
    String email,
    String password,
    String username,
  ) async {
    final url = Uri.parse('http://82.65.59.34:3333/register');

    final Map<String, String> body = {
      'username': username,
      'email': email,
      'password': password,
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Group-Authorization': 'bf0d22904b98ad48a9cbf9251758ce74',
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*'
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    Map<String, dynamic> userData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      localUser.setString('token', userData['session']);
      return null;
    } else {
      return userData['message'];
    }
  }

  static Future<String?> signIn(String emailOrUsername, String password) async {
    final url = Uri.parse('http://82.65.59.34:3333/login');

    final Map<String, String> body = {
      'emailOrUsername': emailOrUsername,
      'password': password,
    };

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Group-Authorization': 'bf0d22904b98ad48a9cbf9251758ce74',
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*'
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    Map<String, dynamic> userData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      localUser.setString('token', userData['session']);
      return null;
    } else {
      return userData['message'];
    }
  }
}
