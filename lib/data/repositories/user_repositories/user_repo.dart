import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controllers/auth_controller.dart';
import '../../../services/route_services.dart';

class UserRepo {
  final AuthController authController;
  UserRepo({required this.authController});


  Future<DocumentSnapshot<Object?>> getUserRoute() async {
    User? user = authController.auth.currentUser;
    return await FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
  }

  Future<void> changeProfilePicture(String imagePath) async {
    try {
      User? user = authController.auth.currentUser;
      if(user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).update(
            {"imagePath": imagePath}
        );
      }
    } catch(e) {
      Get.snackbar("Profile Information", "Profile Picture Updated");
    }
  }

  Future<void> editName (String name) async {
    try {
      User? user = authController.auth.currentUser;
      if(user != null) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).update(
            {"name": name}
        );
      }
    } catch(e) {
      Get.snackbar("Profile Information", "Name has been updated");
    }
  }

  Future<void> editEmail (String email, String password) async {
    User? user = authController.auth.currentUser;
    if(user != null) {
      UserCredential userCredential = await user.reauthenticateWithCredential(EmailAuthProvider.credential(
          email: email,
          password: password
      ));
      if(userCredential.user != null) {
       Get.toNamed(RouteServices.VERIFICATIONSCREEN);
      }
    }
  }
}