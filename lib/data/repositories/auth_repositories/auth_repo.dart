import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class AuthRepo {

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    return await auth.currentUser!;
  }

  void register(String email, String password, String name) async{
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = auth.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        "uid": user?.uid,
        "email": user?.email,
        "name" : name,
        // "imagePath" : imagePath,
      });
    }on FirebaseAuthException catch(e) {
      Get.snackbar("user creation", e.toString(),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void resetPassword(String email) async {
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      auth.sendPasswordResetEmail(
        email: email,
      );
      Get.snackbar("Password Reset", "Please check your email");
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString());
      navigatorKey.currentState!.pop();
    }
  }
  void editWithoutImage(String? name) async {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      User? user = auth.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
        "uid":user!.uid,
        "name":name,
      });
    } on FirebaseAuthException catch(e) {
      Get.snackbar("Profile Information", e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void Login(String email, password) async{
    showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      Get.snackbar("Login", e.toString());
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void Logout() async{
    await auth.signOut();
  }

  bool isLoggedIn () {
    return auth.currentUser!.uid.isNotEmpty;
  }
}