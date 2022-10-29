import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/auth_pages/verification_screen.dart';

import '../data/repositories/auth_repo.dart';
import '../pages/auth_pages/sign_up.dart';
import '../services/route_services.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthController({
    required this.authRepo
});

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen (User? user) {
    if(user == null) {
      Get.offAll(()=> const SignUpScreen());
    } else if(user != null && !user.emailVerified) {
      Get.offAll(()=> const VerificationScreen());
    } else {
      Get.offAllNamed(RouteServices.INITIAL);
    }
  }

  Future<User> getCurrentUser() async {
    return authRepo.getCurrentUser();
  }
  
  void register(String email, String password, String name, String imagePath) async{
    authRepo.register(email, password, name, imagePath);
  }
  void resetPassword(String email) async {
    authRepo.resetPassword(email);
  }
  void edit(String? name, String? imagepath,) async {
    authRepo.edit(name, imagepath);
  }
  void editWithoutImage(String? name) async {
    authRepo.editWithoutImage(name);
  }
  void Login(String email, password) async{
    authRepo.Login(email, password);
  }
  void Logout() async{
    authRepo.Logout();
  }
}