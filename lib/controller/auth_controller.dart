import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/main_page.dart';

import '../pages/auth_pages/login.dart';

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
      Get.offAll(()=> const LoginScreen());
    } else {
      Get.offAll(()=> const MainPage());
    }
  }

  Future<User> getCurrentUser() async {
    return await auth.currentUser!;
  }
  
  void register(String email, password, String name, String imagepath) async{
   try {
     await auth.createUserWithEmailAndPassword(email: email, password: password);
     User? user = auth.currentUser;
     await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
       "uid": user?.uid,
       "email": user?.email,
       "name" : name,
       "imagePath" : imagepath,
     });
   } catch(e) {
     Get.snackbar("user creation", "for some reason we can't create your profile",
         backgroundColor: Colors.black,
         colorText: Colors.white,
         snackPosition: SnackPosition.BOTTOM,
         titleText: Text("Account creation failed"),
         messageText: Text(
         e.toString(), style: TextStyle(color: Colors.white),
     )
     );
   }
  }
  void Login(String email, password) async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("Login", "for some reason you can't login profile",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Login failed"),
          messageText: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.white
            ),
          )
      );
    }
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