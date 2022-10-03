import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../services/route_services.dart';
import '../../utils/dimensions.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: EditForm(),
    );
  }
}

class EditForm extends StatefulWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure;
  }

  @override
  void dispose() {
    super.dispose();
   // _confirmPasswordController.dispose();
    _emailController.dispose();
   // _passwordController.dispose();
    _nameController.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  late String newPassword;

  Future<void>showInformationDialogue(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Choose photo"),
            actions: [
              TextButton(
                  onPressed: () async{
                    upload(true);
                    setState(() {});
                    Navigator.of(context, rootNavigator: true).pop(
                        Get.snackbar(
                            "success",
                            "picture has been Changed successfully",
                            titleText: const Text("success", style: TextStyle(color: Colors.white),),
                            messageText: const Text("picture has been changed",
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: const Color(0xff515BDE),
                            colorText: Colors.white
                        )
                    );

                  },
                  child: const Text("browse gallery")
              ),
              TextButton(
                  onPressed: () async{
                    upload(false);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text("Take selfie")
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.Width20+2),
          color: Colors.white,
          child: Form(
            key: formKey,
            child:  Column(
              children: [
                SizedBox(height: Dimensions.Height40),
                TextFormField(
                  style: const TextStyle(),
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: const Color(0xffBEC2CE),
                        fontSize: Dimensions.Width16,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_add_outlined,
                        color: Color(0xffBEC2CE),
                      ),
                      border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffBEC2CE)
                      ),
                    )
                  ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "please enter a correct name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: Dimensions.Height44-4),
                TextFormField(
                  style: const TextStyle(),
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: const Color(0xffBEC2CE),
                        fontSize: Dimensions.Width16,
                      ),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Color(0xffBEC2CE),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffBEC2CE)
                        ),
                      )
                  ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                      return "please enter a correct email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: Dimensions.Height44-4),
                GestureDetector(
                  onTap: (() {
                    showInformationDialogue(context);
                    setState(() {});
                  }),
                  child: Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.library_add, color: Color(0xffBEC2CE),),
                          SizedBox(width: Dimensions.Width6-1,),
                          Text(
                            "add Image",
                            style: TextStyle(
                                color: const Color(0xffBEC2CE),
                                fontSize: Dimensions.Width16
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height22+1,
                ),
                GestureDetector(
                  onTap: () async{
                    await uploadPfp().then((value) {});
                    String value = await getDownload();
                    if(formKey.currentState!.validate()) {
                      AuthController.instance.edit(_emailController.value.text.trim(),
                          _nameController.text.trim(),
                          value
                      );
                      AuthController.instance.Logout();
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.Width16-4),
                    child: Container(
                      width: double.infinity,
                      height: Dimensions.Height40+10,
                      color: const Color(0xff515BDE),
                      alignment: Alignment.center,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.Width16+2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.Height60/2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        var auth = FirebaseAuth.instance.currentUser?.email;
                        AuthController.instance.resetPassword(auth!);
                      }),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Color(0xffBEC2CE),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ((){
                        AuthController.instance.Logout();
                      }),
                      child: const Text(
                        'LogOut',
                        style: TextStyle(
                          color: Color(0xffBEC2CE),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  XFile? photo;
  Future<void> upload(bool gallery) async {
    final picker = ImagePicker();
    if (gallery) {
      photo =
      await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } else {
      photo =
      await picker.pickImage(source: ImageSource.camera, );
      setState(() {});
    }
  }

  Future<void> uploadPfp() async {
    File uploadFile =File(photo!.path);

    try {
      await storage.ref("avatar/${uploadFile.path}").putFile(
          uploadFile != null ? uploadFile : File("images/adrianna-geo.png"));
    } on FirebaseException catch(e) {
      print(e);
    }
    catch(e) {
      print(e);
    }
  }
  Future<String> getDownload() async {
    File uploadedFile = File(photo!.path);
    return storage.ref("avatar/${uploadedFile.path}").getDownloadURL();
  }


}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF7F8FA),
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height44+2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_outlined)),
          SizedBox(height: Dimensions.height22-1),
          Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: Dimensions.Height44-10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(126);
}
