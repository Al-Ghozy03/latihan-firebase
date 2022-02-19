// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:latihan_firebase/services/firebase_service.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final auth = FirebaseService();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                  )),
              SizedBox(
                height: height / 60,
              ),
              Text("Reset Password",
                  style: TextStyle(
                      fontSize: width >= 800 ? 50 : 70,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: height / 60,
              ),
              Text(
                  "Jika kamu meneruskan langkah ini, MySmk akan mengirimkan sebuat pesan ke email kamu. Nuka atau klik link pada pesan tersebut dan masukkan password baru pada halaman yang akan terbuka nantinya",
                  style: TextStyle(
                    fontSize: width >= 800 ? 30 : 24,
                  )),
              SizedBox(
                height: height / 20,
              ),
              TextField(
                controller: email,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    hintText: "E-mail Addres",
                    contentPadding: width >= 800
                        ? EdgeInsets.symmetric(vertical: 25, horizontal: 20)
                        : EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14))),
              ),
              SizedBox(
                height: height / 30,
              ),
              Container(
                  width: width,
                  child: ElevatedButton(
                    onPressed: () {
                      auth.resetPassword(email.text, context);
                    },
                    child: Text(
                      "Send reset password",
                      style: TextStyle(fontSize: width >= 800 ? 30 : 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Colors.green),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
