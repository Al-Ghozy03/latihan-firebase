// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:latihan_firebase/check_email.dart';
import 'package:latihan_firebase/login.dart';
import 'package:latihan_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FirebaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<User?> streamAuthStatus() {
    return auth.authStateChanges();
  }

  Future<QuerySnapshot<Object?>> getData() async {
    //sekali baca doang
    CollectionReference product = firestore.collection("product");
    return await product.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference product = firestore.collection("product");
    return product.snapshots();
  }

  void deleteProduct(BuildContext context, String docId) async {
    DocumentReference product = firestore.collection("product").doc(docId);
    int count = 0;
    try {
      await product.delete();
      Alert(
              context: context,
              title: "Berhasil",
              desc: "Berhasil hapus data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {Navigator.pop(context);})
              ],
              type: AlertType.success)
          .show();
    } catch (e) {
      Alert(
              context: context,
              title: "Terjadi kesalahan",
              desc: "Gagal hapus data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {})
              ],
              type: AlertType.error)
          .show();
    }
  }

  void updateProduct(
      String name, String harga, BuildContext context, String docId) async {
    DocumentReference product = firestore.collection("product").doc(docId);
    int count = 0;
    try {
      await product.update({"name": name, "harga": harga});
      Alert(
              context: context,
              title: "Berhasil",
              desc: "Berhasil update data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => count++ == 2))
              ],
              type: AlertType.success)
          .show();
    } catch (e) {
      Alert(
              context: context,
              title: "Terjadi kesalahan",
              desc: "Gagal update data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context))
              ],
              type: AlertType.error)
          .show();
    }
  }

  void addProduct(String namaProduct, int harga, BuildContext context) async {
    CollectionReference product = firestore.collection("product");
    int count = 0;
    try {
      await product.add({"name": namaProduct, "harga": harga});
      Alert(
              context: context,
              title: "Berhasil",
              desc: "Berhasil menambah data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>
                        Navigator.popUntil(context, (route) => count++ == 2))
              ],
              type: AlertType.success)
          .show();
    } catch (e) {
      Alert(
              context: context,
              title: "Terjadi kesalahan",
              desc: "Gagal menambah data",
              buttons: [
                DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context))
              ],
              type: AlertType.error)
          .show();
    }
  }

  void resetPassword(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckEmail(
                    data: "reset password",
                  )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Alert(
                context: context,
                title: "Terjadi kesalahan",
                desc: "Usernya gak ada mas, register dulu",
                type: AlertType.error)
            .show();
        print('No user found for that email.');
      }
    }
  }

  void signUp(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CheckEmail(
                    data: "verifikasi email",
                  )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Alert(
                context: context,
                title: "Terjadi kesalahan",
                desc: "Lemah amat passwordnya",
                type: AlertType.error)
            .show();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Alert(
                context: context,
                title: "Terjadi kesalahan",
                desc: "Email nya udah ada yang make",
                type: AlertType.error)
            .show();
        print('The account already exists for that email.');
      }
    } catch (e) {
      Alert(
              context: context,
              title: "Terjadi kesalahan",
              desc: e.toString(),
              type: AlertType.error)
          .show();
      print(e);
    }
  }

  void login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        Alert(
            context: context,
            title: "Kesalahan",
            desc: "email belum diverifikasi",
            type: AlertType.warning,
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Kembali",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.red,
                width: 120,
              ),
              DialogButton(
                onPressed: () => user.sendEmailVerification(),
                child: Text(
                  "Verifikasi",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.red,
                width: 120,
              ),
            ]).show();
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Alert(
                context: context,
                title: "Terjadi kesalahan",
                desc: "Usernya gak ada mas, register dulu",
                type: AlertType.error)
            .show();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Alert(
                context: context,
                title: "Terjadi kesalahan",
                desc: "Passwordnya salah bang, coba lagi",
                type: AlertType.error)
            .show();
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
