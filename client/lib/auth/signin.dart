import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/menu.dart';
import 'package:soul_connection/models/user.module.dart';
import 'package:soul_connection/provider/auth.service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool loader = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: const Color(0xfff2f2f2),
      body: Container(
        width: dw(context),
        height: dh(context),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            Container(
              height: 30,
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            Container(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                if (!loader) {
                  setState(() {
                    loader = true;
                  });
                  UserModel? user = await AuthService.signInManagor(
                    _email.text,
                    _password.text,
                  );
                  if (user != null) {
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => MenuPage(user: user),
                      ),
                      (route) => false,
                    );
                  } else {
                    setState(() {
                      loader = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 5),
                        content: Center(
                          child: Text(
                            'Wrong email or password',
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  height: 70,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: loader
                      ? const CupertinoActivityIndicator()
                      : const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
