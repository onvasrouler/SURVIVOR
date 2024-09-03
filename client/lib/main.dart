import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_connection/pages/auth/onboard.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/home.dart';
import 'package:soul_connection/pages/models/user.module.dart';

void main() async {
  localUser = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget page() {
    if (localUser.containsKey('token')) {
      String base64String = localUser.getString('profile_pic')!;
      return HomePage(
        user: UserModel(
          birthDate: localUser.getString('birthdate') ?? '',
          email: localUser.getString('email') ?? '',
          id: localUser.getString('user_id') ?? '',
          surname: localUser.getString('surname') ?? '',
          name: localUser.getString('name') ?? '',
          gender: localUser.getString('gender') ?? '',
          work: localUser.getString('work') ?? '',
          token: localUser.getString('token') ?? '',
          profilePic: base64Decode(base64String),
        ),
      );
    } else {
      return const OnBoardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soul Connection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: page(),
    );
  }
}
