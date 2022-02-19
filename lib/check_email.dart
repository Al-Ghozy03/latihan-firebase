// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:latihan_firebase/main.dart';

class CheckEmail extends StatefulWidget {
    final String data;
    CheckEmail({required this.data});

  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 40,
              ),
              height: width / 4,
              width: width / 4,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset("assets/email.png"),
            ),
            Text(
              "Check your email",
              style: TextStyle(
                  fontSize: width >= 800 ? 30 : 40,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold),
            ),
            Text(
                "Link ${widget.data} sudah dikirmkan ke email, silahkan diikuti dengan instruksi yang ada",
                style: TextStyle(
                  fontSize: width >= 800 ? 30 : 20,
                  color: Colors.green,
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: 35),
              width: width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    primary: Colors.green,
                  ),
                  onPressed: ()async {
                    await DeviceApps.openApp("com.google.android.gm");
                  },
                  child: Text("Buka aplikasi email",
                      style: TextStyle(
                        fontSize: width >= 800 ? 30 : 30,
                      ))),
            ),
            Container(
              width: width,
              child: TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  },
                  child: Text("Saya akan mengecek nya nanti",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width >= 800 ? 30 : 25,
                      ))),
            )
          ],
        ),
      )),
    );
  }
}
