import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../main_page.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if(AuthController.instance.auth.currentUser !=null) {
      try {
        _isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;
      } on FirebaseAuthException catch(e) {
        Get.snackbar("Profile Information", "Couldn't update Profile info",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            titleText: Text("Profile Update Failed"),
            messageText: Text(
              e.message.toString(), style: TextStyle(color: Colors.white),
            )
        );
        print(e.message.toString());
      }
    }

      if(!_isEmailVerified) {
        sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = AuthController.instance.auth.currentUser;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      // Get.snackbar("Error", "Error Message",
      //     backgroundColor: Colors.black,
      //     colorText: Colors.white,
      //     snackPosition: SnackPosition.TOP,
      //     titleText: const Text("Error Message"),
      //     messageText: Text(
      //       e.message.toString(), style: TextStyle(color: Colors.white),
      //     )
      // );
      print(e.message.toString());
    }

  }

  Future checkEmailVerified() async {
    await AuthController.instance.auth.currentUser!.reload();
    setState(() {
      _isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;
    });
    if(_isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) => _isEmailVerified ? const MainPage() : const Scaffold(
    backgroundColor: Color(0xffF7F8FA),
    body: Center(
      child: Text("Please Click the link in your email to verify your account", textAlign: TextAlign.center, style: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black45
      ),)
    ),
  );
}
