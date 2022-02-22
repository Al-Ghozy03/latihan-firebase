// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:latihan_firebase/services/firebase_service.dart';

class EditProduct extends StatefulWidget {
  final Map data;
  final String docId;
  EditProduct({required this.data, required this.docId});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController product = TextEditingController();
  TextEditingController harga = TextEditingController();
  @override
  void initState(){
    product.text = widget.data["name"];
    harga.text = widget.data["harga"].toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
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
                  FirebaseService().updateProduct(product.text, harga.text, context, widget.docId);
                },
                child: Text(
                  "Update",
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
