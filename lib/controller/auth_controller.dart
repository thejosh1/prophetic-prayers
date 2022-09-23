import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/auth_pages/verification_screen.dart';
import 'package:prophetic_prayers/pages/main_page.dart';

import '../main.dart';
import '../pages/auth_pages/sign_up.dart';
import '../pages/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

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
      Get.offAll(()=> const SplashScreen());
    }
  }

  Future<User> getCurrentUser() async {
    return await auth.currentUser!;
  }
  
  void register(String email, String password, String name, String imagepath) async{
   showDialog(
       context: navigatorKey.currentContext!,
       barrierDismissible: false,
       builder: (BuildContext context) => const Center(child: CircularProgressIndicator(),)
   );
   try {
     await auth.createUserWithEmailAndPassword(email: email, password: password);
     User? user = auth.currentUser;
     await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
       "uid": user?.uid,
       "email": user?.email,
       "name" : name,
       "imagePath" : imagepath,
     });
   }on FirebaseAuthException catch(e) {
     Get.snackbar("user creation", "for some reason we can't create your profile",
         backgroundColor: Colors.black,
         colorText: Colors.white,
         snackPosition: SnackPosition.TOP,
         titleText: Text("Account creation failed"),
         messageText: Text(
         e.message.toString(), style: TextStyle(color: Colors.white),
         )
     );
     print(e.toString());
   }
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
      Get.snackbar("Password Reset", "Password Reset",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Password Reset"),
          messageText: const Text(
            "Please check your email", style: TextStyle(color: Colors.white),
          )
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Error Message",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Error Message"),
          messageText: Text(
            e.message.toString(), style: TextStyle(color: Colors.white),
          )
      );
      navigatorKey.currentState!.pop();
    }
  }
  void edit(String? email, String? name, String? imagepath) async {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      User? user = auth.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
        "uid":user?.uid,
        "email":email,
        "name":name,
        "imagePath":imagepath,
      });
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
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void Login(String email, password) async{
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(),)
    );
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      Get.snackbar("Login", "for some reason you can't login profile",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: Text("Login failed"),
          messageText: Text(
            e.message.toString(),
            style: TextStyle(
              color: Colors.white
            ),
          )
      );
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void Logout() async{
    await auth.signOut();
  }

  Future signInAnonymously() async {
    try {
      UserCredential result = await auth.signInAnonymously();
      User? user = result.user;
    } catch(e) {
      print(e.toString());
    }
  }
}