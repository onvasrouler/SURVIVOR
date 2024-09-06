import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_connection/auth/onboard.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/menu.dart';
import 'package:soul_connection/models/user.module.dart';
import 'package:soul_connection/provider/coachs.service.dart';
import 'package:soul_connection/provider/customers.service.dart';
import 'package:soul_connection/provider/tips.service.dart';

void main() async {
  localUser = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    fetchCustomers();
    fetchEmployees();
    fetchTips();
    super.initState();
  }

  void fetchCustomers() async {
    isLoading = await CustomersService.fetchCustomers();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchEmployees() async {
    isLoading = await CoachsService.fetchEmployees();
    isLoading = await TipsService.fetchTips();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchTips() async {
    isLoading = await TipsService.fetchTips();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget page() {
    if (isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Soul Connection',
              style: TextStyle(
                fontSize: dw(context) * 0.05,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
          ),
        ),
      );
    } else if (localUser.containsKey('token')) {
      String base64String = localUser.getString('profile_pic')!;
      return MenuPage(
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
