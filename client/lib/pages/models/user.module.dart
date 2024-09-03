import 'dart:typed_data';

import 'package:soul_connection/pages/constants/constants.dart';

class UserModel {
  String? id;
  String? email;
  String? surname;
  String? token;
  String? birthDate;
  String? gender;
  String? work;
  String? name;
  Uint8List? profilePic;

  UserModel({
    required this.id,
    required this.email,
    required this.surname,
    required this.birthDate,
    required this.gender,
    required this.work,
    required this.token,
    required this.name,
    required this.profilePic,
  });

  static Future<void> fromSharedPreferences(Map<String, dynamic> user) async {
    localUser.setString('user_id', user['id'].toString());
    localUser.setString('email', user['email']);
    localUser.setString('surname', user['surname']);
    localUser.setString('name', user['name']);
    localUser.setString('birthdate', user['birth_date']);
    localUser.setString('gender', user['gender']);
    localUser.setString('work', user['work']);
    localUser.setString('token', user['token']);
  }
}
