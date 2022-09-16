import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference _dbRef = _db.collection("testimonies");

class TestimonyServices {
  static String? Useruid;

  static Future<void> addItem({
    required String title,
    required String testimonies,
    required String useruid,
    required String timestamp,

  }) async {
    DocumentReference documentReference = _dbRef.doc();
    useruid = AuthController.instance.auth.currentUser!.uid.toString();
    timestamp = DateFormat.yMMMEd().format(DateTime.now()).toString();
    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "testimonies": testimonies,
      "useruid": useruid,
      "timestamp": timestamp
    };
    await documentReference.set(data).whenComplete(() => Get.snackbar(
      "Testimonies",
      "Your testimony has been successfully added",
      titleText: Text("Testimony", style: TextStyle(color: Colors.white)),
      messageText: const Text("Your Testimony has been added successfully", style: TextStyle(color: Colors.white),),
      backgroundColor: const Color(0xff515BDE),
      colorText: Colors.white
    )).catchError((e) => Get.snackbar("Error", e,
      titleText: Text("Error"),
      messageText: Text(e),
      backgroundColor: const Color(0xff515BDE),
      colorText: Colors.white
    ));
  }

  static Stream<QuerySnapshot> showTestimony() {
    CollectionReference testimonyCollection = FirebaseFirestore.instance.collection("testimonies");
    return testimonyCollection.snapshots();
  }

//   static Future<void> updateTestimony({
//   required String title,
//   required String testimonies,
//   required String docId,
// }) async {
//     DocumentReference documentReference = _dbRef.doc(Useruid).collection("testimonies").doc(docId);
//
//     Map<String, dynamic> data = <String, dynamic> {
//       "title": title,
//       "testimonies": testimonies
//     };
//
//     await documentReference.update(data).whenComplete(() => print("testimony updated successfully")).catchError((e) => print(e));
//   }



}