import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/user.module.dart';

class AuthService {
  static Future<UserModel?> signInManagor(String email, String password) async {
    final url = Uri.parse('https://soul-connection.fr/api/employees/login');
    final getMyData = Uri.parse('https://soul-connection.fr/api/employees/me');

    final Map<String, String> body = {
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

    Map<String, dynamic> userToken = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (userToken.containsKey('access_token')) {
        final response = await http.get(
          getMyData,
          headers: {
            'Content-Type': 'application/json',
            'X-Group-Authorization': 'bf0d22904b98ad48a9cbf9251758ce74',
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*',
            'Authorization': 'Bearer ${userToken['access_token']}',
          },
        );
        if (response.statusCode != 200) {
          return null;
        }
        Map<String, dynamic> userData = jsonDecode(response.body);
        Map<String, dynamic> storeUser = userData;
        Uint8List profilePic = await http.readBytes(
          Uri.parse(
              'https://soul-connection.fr/api/employees/${userData['id']}/image'),
          headers: {
            'Content-Type': 'application/json',
            'X-Group-Authorization': 'bf0d22904b98ad48a9cbf9251758ce74',
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*',
            'Authorization': 'Bearer ${userToken['access_token']}',
          },
        );
        storeUser['token'] = userToken['access_token'];
        String base64String = base64Encode(profilePic);
        await localUser.setString('profile_pic', base64String);
        UserModel.fromSharedPreferences(storeUser);
        return UserModel(
          id: userData['id'].toString(),
          email: userData['email'],
          name: userData['name'],
          surname: userData['surname'],
          birthDate: userData['birth_date'],
          gender: userData['gender'],
          work: userData['work'],
          token: userToken['access_token'],
          profilePic: profilePic,
        );
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
