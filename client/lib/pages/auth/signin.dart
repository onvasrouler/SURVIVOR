import 'package:flutter/material.dart';
import 'package:soul_connection/pages/home.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/provider/auth.service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
  late TextEditingController _email;
  late TextEditingController _password;

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
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
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
                UserModel? user = await AuthService.signInManagor(
                  _email.text,
                  _password.text,
                );
                if (user != null) {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(user: user),
                    ),
                  );
                } else {
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
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: Colors.black,
                  height: 70,
                  width: 250,
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
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
