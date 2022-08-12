import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

import '../widgets/big_text.dart';

class CreateTestimonyScreen extends StatelessWidget {
  const CreateTestimonyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateTestimonyForm(),
    );
  }
}

class CreateTestimonyForm extends StatefulWidget {
  const CreateTestimonyForm({Key? key}) : super(key: key);

  @override
  State<CreateTestimonyForm> createState() => _CreateTestimonyFormState();
}

class _CreateTestimonyFormState extends State<CreateTestimonyForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var data = Get.arguments;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 440,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: const Color(0xff515BDE)
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.clear, color: Colors.white,),
                    ),
                    const Text("Create Testimony", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(()=> const MainPage());
                      },
                      child: Container(
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.home, size: 16,),
                            Text("Home")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ),
            Positioned(
              top: 100,
              child: Container(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Form(
                            child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration.collapsed(
                                      hintText: "Title here",
                                      hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 24, fontWeight: FontWeight.w600)
                                    ),
                                    controller: _titleController,
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: 320,
                                    child: TextFormField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller: _noteController,
                                      decoration: const InputDecoration.collapsed(
                                          hintText: "Testimony here",
                                          hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 24, fontWeight: FontWeight.w600)
                                      ),
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 200),
                                  GestureDetector(
                                    onTap: () async{
                                      _formKey.currentState?.save();
                                      TestimonyServices.addItem(
                                          title: _titleController.text.trim(),
                                          testimonies: _noteController.text.trim(),
                                          useruid: AuthController.instance.auth.currentUser!.uid.toString(),
                                          prayertype: data[0].toString(),
                                          timestamp: DateFormat.yMMMEd().format(DateTime.now()).toString()
                                      );
                                      Get.back();
                                      },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        color: const Color(0xff515BDE),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
      // SingleChildScrollView(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 22),
      //     child: Column(
      //       children: [
      //         SizedBox(height: 20),
      //         Form(
      //           child: Column(
      //             children: [
      //               TextFormField(
      //                 decoration: const InputDecoration.collapsed(
      //                   hintText: "Title",
      //                 ),
      //                 controller: _titleController,
      //                 style: TextStyle(
      //                     fontSize: 16.0,
      //                     fontWeight: FontWeight.bold
      //                 ),
      //               ),
      //               const Divider(),
      //               SizedBox(height: 23),
      //               TextFormField(
      //                 controller: _noteController,
      //                 decoration: const InputDecoration.collapsed(
      //                   hintText: "Testimony",
      //                 ),
      //                 style: TextStyle(
      //                     fontSize: 18.0,
      //                     fontWeight: FontWeight.bold
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 300),
      //         GestureDetector(
      //           onTap: () async{
      //             _formKey.currentState?.save();
      //             TestimonyServices.addItem(
      //                 title: _titleController.text.trim(),
      //                 testimonies: _noteController.text.trim(),
      //                 useruid: AuthController.instance.auth.currentUser!.uid.toString(),
      //                 prayertype: data[0].toString(),
      //                 timestamp: DateFormat.yMMMEd().format(DateTime.now()).toString()
      //             );
      //             print("a text" + _titleController.text.trim());
      //             print("a text" + _noteController.text.trim());
      //             print("a text " + AuthController.instance.auth.currentUser!.uid.toString());
      //             Get.back();
      //           },
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.circular(12),
      //             child: Container(
      //               width: double.infinity,
      //               height: 50,
      //               color: const Color(0xff515BDE),
      //               alignment: Alignment.center,
      //               child: const Text(
      //                 'Submit',
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.w700,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 30),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

// _validator() {
//   if(_emailController){

//   }
// }
}


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.auth.currentUser;
    // TODO: implement build
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 0.5,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
                color: Colors.transparent
            )
          ]
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.arrow_back, size: 24,),
          SizedBox(width: 20,),
          BigText(text: "Testimony")
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(126);
}
