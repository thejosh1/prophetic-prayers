import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/auth_pages/verification_screen.dart';

import '../main.dart';
import '../pages/auth_pages/sign_up.dart';
import '../services/route_services.dart';

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
      Get.offAllNamed(RouteServices.INITIAL);
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
     // navigatorKey.currentState!.popUntil((route) => route.isFirst);
   }on FirebaseAuthException catch(e) {
     Get.snackbar("user creation", "for some reason we can't create your profile",
         backgroundColor: Colors.orange,
         colorText: Colors.white,
         snackPosition: SnackPosition.TOP,
         titleText: const Text("Account creation failed", style: TextStyle(color: Colors.white),),
         messageText: const Text(
         "for some reason we can't create your profile", style: TextStyle(color: Colors.white),
         )
     );
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
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Password Reset", style:TextStyle(color: Colors.white),),
          messageText: const Text(
            "Please check your email", style: TextStyle(color: Colors.white),
          )
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Error Message",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Error Message", style: TextStyle(color: Colors.white),),
          messageText: const Text(
            "Could not reset password", style: TextStyle(color: Colors.white),
          )
      );
      navigatorKey.currentState!.pop();
    }
  }
  void edit(String? name, String? imagepath,) async {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => const Center(child: CircularProgressIndicator(),)
    );
    try {
      User? user = auth.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
        "uid":user?.uid,
        "name":name,
        "imagePath":imagepath,
      });
    } on FirebaseAuthException catch(e) {
      Get.snackbar("Profile Information", "Couldn't update Profile info",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        titleText: const Text("Profile Update Failed", style: TextStyle(color: Colors.white),),
        messageText: const Text(
          "couldn't update profile info", style: TextStyle(color: Colors.white),
        )
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  void editwithoutimage(String? name) async {
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
      Get.snackbar("Profile Information", "Couldn't update Profile info",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Profile Update Failed", style: TextStyle(color: Colors.white),),
          messageText: const Text(
            "could not update profile info", style: TextStyle(color: Colors.white),
          )
      );
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
      Get.snackbar("Login", "Login failed",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          titleText: const Text("Login failed", style: TextStyle(color: Colors.white),),
          messageText: const Text("Login failed", style: TextStyle(color: Colors.white),
          )
      );
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