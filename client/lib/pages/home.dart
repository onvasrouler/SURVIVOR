import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: dh(context),
        width: dw(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.memory(
                widget.user.profilePic!,
                height: 180,
              ),
            ),
            Text(
              widget.user.surname! + widget.user.name!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.user.birthDate!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.user.gender!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.user.work!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
