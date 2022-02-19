// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:latihan_firebase/services/firebase_service.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController product = TextEditingController();
  TextEditingController harga = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 30),
        child: Column(
          children: [
            TextField(
              controller: product,
              decoration: InputDecoration(
                  hintText: "Nama product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: harga,
              decoration: InputDecoration(
                  hintText: "Harga",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  FirebaseService().addProduct(product.text, int.parse(harga.text), context);
                },
                child: Text(
                  "Send",
                  style: TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 13)),
              ),
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
