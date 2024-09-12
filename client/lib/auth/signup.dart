import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/employees.module.dart';
import 'package:soul_connection/provider/auth.service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _birthday;
  late TextEditingController _username;
  late TextEditingController _gender;
  late TextEditingController _surname;
  bool loader = false;
  Uint8List? _image;

  @override
  void initState() {
    _email = TextEditingController();
    _username = TextEditingController();
    _birthday = TextEditingController();
    _password = TextEditingController();
    _gender = TextEditingController();
    _surname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _password.dispose();
    _birthday.dispose();
    _surname.dispose();
    _gender.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthday.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isWearOs(context)) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sh(30),
                TextField(
                  controller: _username,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                TextField(
                  controller: _password,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                TextField(
                  controller: _birthday,
                  decoration: const InputDecoration(
                    hintText: 'Birthday',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                sh(20),
                GestureDetector(
                  onTap: () async {
                    if (!loader) {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: loader
                        ? const CupertinoActivityIndicator()
                        : const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                sh(30),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Sign up",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: dw(context),
        height: dh(context),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _userImage(),
            sh(30),
            TextField(
              controller: _username,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            sh(30),
            TextField(
              controller: _surname,
              decoration: const InputDecoration(hintText: 'Surname'),
            ),
            sh(30),
            TextField(
              controller: _gender,
              decoration: const InputDecoration(hintText: 'Gender'),
            ),
            sh(30),
            TextField(
              controller: _birthday,
              decoration: const InputDecoration(
                hintText: 'Birthday',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
            ),
            sh(30),
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            sh(30),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            sh(30),
            GestureDetector(
              onTap: () async {
                setState(() {
                  loader = true;
                });
                final resonse = await AuthService.signUp(
                  _email.text,
                  _password.text,
                  _username.text,
                  _gender.text,
                  _birthday.text,
                  _surname.text,
                  'Coach',
                  _image!,
                );
                if (resonse['status'] == 200) {
                  allCoaches.add(
                    EmployeeModel(
                      name: _username.text,
                      surname: _surname.text,
                      birthDate: _birthday.text,
                      lastSession: 'Never',
                      id: int.parse(resonse['data']),
                      email: _email.text,
                      gender: _gender.text,
                      work: 'Coach',
                      employeeId: resonse['data'],
                      assignedCustomer: [],
                      profilePicture: '',
                    ),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blue,
                    duration: const Duration(seconds: 5),
                    content: Center(
                      child: Text(
                        resonse['data'],
                      ),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                height: 70,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                alignment: Alignment.center,
                child: loader
                    ? const CupertinoActivityIndicator()
                    : const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image == null) {
      return;
    }
    final bytes = await image.readAsBytes();

    setState(() {
      _image = bytes;
    });
  }

  Widget _userImage() {
    return Hero(
        tag: 'PP',
        child: Stack(
          children: [
            if (_image == null)
              IgnorePointer(
                child: Container(
                  height: 140,
                  width: 140,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: const Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 140,
                    color: Colors.white,
                  ),
                ),
              )
            else
              IgnorePointer(
                child: Container(
                  height: 140,
                  width: 140,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.memory(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            GestureDetector(
              onTap: getImage,
              child: Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(23, 0, 0, 0),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.camera,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
