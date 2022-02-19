// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names, unused_import, deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:latihan_firebase/services/firebase_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseService();
    final lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: lebar >= 800
            ? EdgeInsets.symmetric(vertical: 20, horizontal: 40)
            : EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _field(context, "Email address", email),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    _field(context, "Password", password),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 30),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      auth.signUp(email.text, password.text,context);
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: lebar >= 800 ? 30 : 30),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[700],
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 50)),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                            children: [
                          TextSpan(text: "Sudah punya akun?"),
                          TextSpan(
                              text: " Klik disini",
                              style: TextStyle(color: Colors.green[700])),
                        ])),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Widget _header(BuildContext context) {
  final lebar = MediaQuery.of(context).size.width;
  return RichText(
      text: TextSpan(
          style:
              TextStyle(color: Colors.green, fontSize: lebar >= 800 ? 50 : 70),
          children: [
        TextSpan(text: "Hello!\n"),
        TextSpan(text: "Welcome to\n"),
        TextSpan(
            text: "MySmk Apps",
            style: TextStyle(
                color: Colors.green[700], fontWeight: FontWeight.bold)),
      ]));
}

Widget _field(
    BuildContext context, String text, TextEditingController controller) {
  final lebar = MediaQuery.of(context).size.width;
  return TextField(
    controller: controller,
    style: TextStyle(fontSize: 20),
    decoration: InputDecoration(
        contentPadding: lebar >= 800
            ? EdgeInsets.symmetric(vertical: 25, horizontal: 20)
            : EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey[600])),
  );
}
