import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';

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
    _isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;
    if(!_isEmailVerified) {
      AuthController.instance.verifyEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await AuthController.instance.auth.currentUser!.reload();
    setState(() {
      _isEmailVerified = AuthController.instance.auth.currentUser!.emailVerified;
    });
    if(_isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => _isEmailVerified ? const MainPage() : Scaffold(
    appBar: AppBar(
      title: Text("Verify Email"),
    ),
  );
}
