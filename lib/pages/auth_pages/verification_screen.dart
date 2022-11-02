import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../main_screen/main_page.dart';

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
        Get.snackbar("Profile Information", e.message.toString());

      }
    }

      if(!_isEmailVerified) {
        sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = AuthController.instance.auth.currentUser;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      //i don't want users to see the error message firebase base sends cos of the too many requests sent to the server caused by timer.periodic
      // Get.snackbar("Error message", e.message.toString());
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
  Widget build(BuildContext context) => _isEmailVerified ? const MainPage() : Scaffold(
    backgroundColor: const Color(0xffF7F8FA),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Please Click the link in your email to verify your account",
          textAlign: TextAlign.center,
          style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: Dimensions.Width20+4, color: Colors.black45
        ),
        ),
        Text("In case you did not see the email, please check your spam",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: Dimensions.Width20+4, color: Colors.black45
          ),
        ),
      ],
    ),
  );
}
