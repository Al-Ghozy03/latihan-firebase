// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:latihan_firebase/add_product.dart';
import 'package:latihan_firebase/login.dart';
import 'package:latihan_firebase/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseService();

    return StreamBuilder<User?>(
        stream: auth.streamAuthStatus(),
        builder: (context, snapshot) {
          print(snapshot.data);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: snapshot.data != null && !snapshot.data!.emailVerified
                ? Home()
                : LoginPage(),
          );
        });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () => auth.logout(context), icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: auth.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var listData = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context,i){
                Map<String,dynamic> data = listData[i].data()! as Map<String,dynamic>;
                return ListTile(
                  title: Text(data["name"]),
                  subtitle: Text("Rp ${data["harga"]}"),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
