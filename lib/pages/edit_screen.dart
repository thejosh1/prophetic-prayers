import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prophetic_prayers/pages/auth_pages/login.dart';

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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 22),
          color: Colors.white,
          child: Form(
            key: formKey,
            child:  Column(
              children: [
                SizedBox(height: 40),
                TextFormField(
                  style: const TextStyle(),
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color(0xffBEC2CE),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.person_add_outlined,
                        color: Color(0xffBEC2CE),
                      ),
                      border: UnderlineInputBorder(
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
                const SizedBox(height: 40),
                TextFormField(
                  style: const TextStyle(),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Color(0xffBEC2CE),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Color(0xffBEC2CE),
                      ),
                      border: UnderlineInputBorder(
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
                const SizedBox(height: 40),
                TextFormField(
                  style: const TextStyle(),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      hintText: 'password',
                      hintStyle: TextStyle(
                        color: Color(0xffBEC2CE),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xffBEC2CE),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffBEC2CE)
                        ),
                      )
                  ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                      return "please password should contain 1 Upper case, 1 lowercase, 1 Numeric Number, 1 Special Character";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 23),
                TextFormField(
                  style: const TextStyle(),
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                      hintText: 'confirm password',
                      hintStyle: TextStyle(
                        color: Color(0xffBEC2CE),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xffBEC2CE),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffBEC2CE)
                        ),
                      )
                  ),
                  validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                      return "please password should contain 1 Upper case, 1 lowercase, 1 Numeric Number, 1 Special Character";
                    } else if(value != _passwordController.text) {
                      return "passwords does not match";
                    }
                    else {
                      newPassword = value;
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 23),
                GestureDetector(
                  onTap: (() {
                    showInformationDialogue(context);
                    setState(() {});
                  }),
                  child: Row(
                    children: [
                      const Spacer(),
                      Row(
                        children: const [
                          Icon(Icons.library_add, color: Color(0xffBEC2CE),),
                          SizedBox(width: 5,),
                          Text(
                            "add Image",
                            style: TextStyle(
                                color: Color(0xffBEC2CE),
                                fontSize: 16
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                GestureDetector(
                  onTap: () async{
                    await uploadPfp().then((value) {});
                    String value = await getDownload();
                    if(formKey.currentState!.validate()) {
                      Get.snackbar("submitting", "check email for password",
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: Text("check email for password"),
                          messageText: const Text(
                            "check email for password", style: TextStyle(color: Colors.white),
                          )
                      );
                      AuthController.instance.edit(_emailController.value.text.trim(),
                          _nameController.value.text.trim(), value);
                      if(newPassword.isNotEmpty) {
                        try {
                          AuthController.instance.resetPassword();
                          FirebaseAuth.instance.signOut();
                          Get.offAll(()=> const LoginScreen());
                          Get.snackbar("Password update", "check email for new password",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              titleText: Text("Password update"),
                              messageText: const Text(
                                "check email for new password", style: TextStyle(color: Colors.white),
                              )
                          );
                        } catch(e) {
                          Get.snackbar("Error", e.toString(),
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              titleText: Text("Error"),
                              messageText: Text(
                                e.toString(), style: TextStyle(color: Colors.white),
                              )
                          );
                        }
                      }
                    }
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_back_outlined),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 34,
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
